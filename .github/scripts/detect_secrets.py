#!/usr/bin/env python3
"""
Códigos de salida:
    0 -> sin hallazgos
    1 -> se detectaron posibles secretos
    2 -> error al ejecutar el escáner
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]

IGNORE_DIRS = {
    ".git",
    ".venv",
    "venv",
    "env",
    "node_modules",
    ".idea",
    ".vscode",
    "__pycache__",
    ".pytest_cache",
    ".mypy_cache",
    ".ruff_cache",
    "dist",
    "build",
    "site",
}

BINARY_EXTENSIONS = {
    ".7z",
    ".avi",
    ".bmp",
    ".class",
    ".db",
    ".dll",
    ".doc",
    ".docx",
    ".elf",
    ".exe",
    ".gif",
    ".gz",
    ".ico",
    ".iso",
    ".jar",
    ".jpeg",
    ".jpg",
    ".mov",
    ".mp3",
    ".mp4",
    ".o",
    ".pdf",
    ".png",
    ".pyc",
    ".so",
    ".tar",
    ".ttf",
    ".wav",
    ".webp",
    ".woff",
    ".woff2",
    ".xz",
    ".zip",
}

PLACEHOLDER_RE = re.compile(
    r"(?:example|sample|dummy|test|testing|changeme|change_me|replace|your[_-]?|"
    r"insert[_-]?|placeholder|fake|not[_-]?a[_-]?secret|redacted|"
    r"<[^>]+>|\$\{?[A-Z0-9_]+\}?)",
    re.IGNORECASE,
)

PATTERNS: tuple[tuple[str, re.Pattern[str]], ...] = (
    (
        "PRIVATE_KEY",
        re.compile(
            r"-----BEGIN (?:(?:OPENSSH|RSA|EC|DSA|PGP) )?(?:ENCRYPTED )?PRIVATE KEY-----"
        ),
    ),
    (
        "GITHUB_TOKEN",
        re.compile(r"\b(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9_]{20,}\b|\bgithub_pat_[A-Za-z0-9_]{20,}\b"),
    ),
    (
        "AWS_ACCESS_KEY_ID",
        re.compile(r"\bAKIA[0-9A-Z]{16}\b"),
    ),
    (
        "SLACK_TOKEN",
        re.compile(r"\bxox(?:a|b|p|r|s)-[A-Za-z0-9-]{10,}\b"),
    ),
    (
        "GOOGLE_API_KEY",
        re.compile(r"\bAIza[0-9A-Za-z_-]{35}\b"),
    ),
    (
        "JWT",
        re.compile(r"\beyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\b"),
    ),
    (
        "GENERIC_CREDENTIAL_ASSIGNMENT",
        re.compile(
            r"(?i)\b(?:api[_-]?key|access[_-]?key|secret[_-]?key|client[_-]?secret|"
            r"auth[_-]?token|access[_-]?token|refresh[_-]?token|bearer|password|passwd|"
            r"private[_-]?key)\b\s*(?:=|:)\s*[\"']?([^\"'\s,;]{8,})"
        ),
    ),
    (
        "DATABASE_URL_CREDENTIALS",
        re.compile(
            r"(?i)\b(?:mysql|mariadb|postgres(?:ql)?|mongodb(?:\+srv)?|redis)://"
            r"[^\s:@/]+:[^\s@/]+@"
        ),
    ),
    (
        "BASIC_AUTH_URL",
        re.compile(r"https?://[^\s/@:]+:[^\s/@]+@[^\s]+", re.IGNORECASE),
    ),
)

SECRET_FILE_NAMES = {
    ".env",
    ".env.local",
    ".env.production",
    ".env.development",
    "credentials",
    "credentials.json",
    "secrets.yml",
    "secrets.yaml",
    "secret.json",
    "service-account.json",
}

@dataclass(frozen=True)
class Finding:
    path: Path
    line_number: int
    rule: str

# Evitar falsos positivos obvios en documentación y ejemplos.
def is_placeholder(value: str) -> bool:
    compact = value.strip().strip("\"'")
    if not compact:
        return True

    if PLACEHOLDER_RE.search(compact):
        return True

    normalized = compact.lower()
    if normalized in {
        "secret",
        "token",
        "password",
        "passwd",
        "changeme",
        "foobar",
        "foo",
        "bar",
        "baz",
        "null",
        "none",
    }:
        return True
    if len(set(compact)) == 1:
        return True
    return False

def get_git_files() -> list[Path]:
    try:
        result = subprocess.run(
            ["git", "ls-files", "-z"],
            cwd=ROOT,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    except (OSError, subprocess.CalledProcessError) as exc:
        raise RuntimeError(f"No se pudo consultar Git: {exc}") from exc

    raw_paths = result.stdout.decode("utf-8", errors="replace").split("\0")
    return [ROOT / p for p in raw_paths if p]

def get_all_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        relative_parts = path.relative_to(ROOT).parts
        if any(part in IGNORE_DIRS for part in relative_parts):
            continue
        files.append(path)
    return sorted(files)

def should_scan(path: Path) -> bool:
    if path.suffix.lower() in BINARY_EXTENSIONS:
        return False
    if any(part in IGNORE_DIRS for part in path.relative_to(ROOT).parts):
        return False
    return True

def iter_text_lines(path: Path) -> Iterable[tuple[int, str]]:
    try:
        raw = path.read_bytes()
    except OSError as exc:
        raise RuntimeError(f"No se pudo leer {path.relative_to(ROOT)}: {exc}") from exc
    if b"\x00" in raw:
        return
    text = raw.decode("utf-8", errors="replace")
    for number, line in enumerate(text.splitlines(), start=1):
        yield number, line

def rule_matches(rule_name: str, pattern: re.Pattern[str], line: str) -> bool:
    match = pattern.search(line)
    if not match:
        return False
    if rule_name in {"GENERIC_CREDENTIAL_ASSIGNMENT", "DATABASE_URL_CREDENTIALS", "BASIC_AUTH_URL"}:
        candidate = match.group(1) if match.lastindex else match.group(0)
        return not is_placeholder(candidate)
    return True

def scan_file(path: Path) -> list[Finding]:
    findings: list[Finding] = []
    if not should_scan(path):
        return findings
    relative = path.relative_to(ROOT)
    try:
        lines = iter_text_lines(path)
        for line_number, line in lines:
            for rule_name, pattern in PATTERNS:
                if rule_matches(rule_name, pattern, line):
                    findings.append(Finding(relative, line_number, rule_name))
                    break
    except RuntimeError:
        raise
    return findings

def scan_suspicious_filenames(files: Iterable[Path]) -> list[Finding]:
    findings: list[Finding] = []
    for path in files:
        if not should_scan(path):
            continue
        if path.name.lower() not in SECRET_FILE_NAMES:
            continue
        try:
            raw = path.read_bytes()
        except OSError as exc:
            raise RuntimeError(f"No se pudo leer {path.relative_to(ROOT)}: {exc}") from exc
        if not raw.strip():
            continue
        if b"\x00" in raw:
            continue
        text = raw.decode("utf-8", errors="replace")
        for number, line in enumerate(text.splitlines(), start=1):
            if not line.strip() or line.lstrip().startswith("#"):
                continue
            if re.search(r"=\s*[^$\{<\"']\S{7,}", line):
                value = line.split("=", 1)[1].strip()
                if not is_placeholder(value):
                    findings.append(Finding(path.relative_to(ROOT), number, "SENSITIVE_FILENAME"))
                    break
    return findings

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--all-files",
        action="store_true",
        help="Escanea todos los archivos del árbol en lugar de solo los versionados por Git.",
    )
    args = parser.parse_args()

    try:
        files = get_all_files() if args.all_files else get_git_files()
    except RuntimeError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2
    findings: list[Finding] = []
    scanned = 0
    for path in files:
        if not should_scan(path):
            continue
        scanned += 1
        findings.extend(scan_file(path))
    findings.extend(scan_suspicious_filenames(files))

    # Quitar duplicados
    findings = sorted(set(findings), key=lambda item: (str(item.path), item.line_number, item.rule))
    print(f"Secret scan: {scanned} archivos de texto candidatos revisados.")

    if findings:
        print("\nSe detectaron posibles secretos. No se muestran los valores para evitar exponerlos en los logs:\n")
        for finding in findings:
            print(f"- {finding.path}:{finding.line_number} -> {finding.rule}")
        print("\nRevisa los hallazgos antes de hacer push.")
        return 1
    print("No se detectaron posibles secretos.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
