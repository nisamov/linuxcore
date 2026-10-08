#!/usr/bin/env python3
"""Valida los registros de comandos con el esquema JSON oficial del repositorio."""

from __future__ import annotations

import json
import sys
from pathlib import Path

from jsonschema import Draft202012Validator, FormatChecker

ROOT = Path(__file__).resolve().parents[2]
COMMANDS_DIR = ROOT / "comandos"
SCHEMA_PATH = ROOT / ".github" / "schemas" / "comando.schema.json"


def main() -> int:
    try:
        schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        print(f"[ERROR] No se pudo cargar el esquema {SCHEMA_PATH}: {error}")
        return 1

    Draft202012Validator.check_schema(schema)
    validator = Draft202012Validator(schema, format_checker=FormatChecker())
    files = sorted(COMMANDS_DIR.rglob("*.json"))
    errors: list[str] = []

    for path in files:
        try:
            instance = json.loads(path.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError) as error:
            errors.append(f"{path.relative_to(ROOT)}: JSON inválido: {error}")
            continue

        for error in validator.iter_errors(instance):
            location = "/".join(str(part) for part in error.absolute_path) or "$"
            errors.append(f"{path.relative_to(ROOT)}: {location}: {error.message}")

    if errors:
        print(f"[ERROR] Validación fallida: {len(errors)} problema(s) en {len(files)} archivo(s).")
        for error in errors:
            print(f"- {error}")
        return 1

    print(f"[OK] {len(files)} archivos JSON cumplen comando.schema.json.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
