import json
import os


def build_commands_db():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    repo_root = os.path.abspath(os.path.join(script_dir, "../.."))
    commands_path = os.path.join(repo_root, "comandos")
    output_path = os.path.join(repo_root, ".github", "db", "commands.json")

    if not os.path.isdir(commands_path):
        print(f"[ERROR] No existe el directorio: {commands_path}")
        raise SystemExit(1)

    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    commands = []
    total_files = 0
    invalid_files = 0

    for root, _, files in os.walk(commands_path):
        rel_dir = os.path.relpath(root, commands_path)
        categoria_db = "" if rel_dir == "." else rel_dir.replace(os.sep, "/")

        for filename in sorted(files):
            if not filename.lower().endswith(".json"):
                continue

            total_files += 1
            file_path = os.path.join(root, filename)
            rel_file = os.path.relpath(file_path, repo_root).replace(os.sep, "/")

            try:
                with open(file_path, "r", encoding="utf-8") as file:
                    data = json.load(file)
            except (OSError, json.JSONDecodeError) as error:
                print(f"[ERROR] {file_path}: {error}")
                invalid_files += 1
                continue

            def enrich(command):
                if categoria_db:
                    command.setdefault("categoria_db", categoria_db)
                command.setdefault("archivo_fuente", rel_file)
                return command

            if isinstance(data, dict):
                commands.append(enrich(data))

            elif isinstance(data, list):
                for command in data:
                    if isinstance(command, dict):
                        commands.append(enrich(command))
                    else:
                        print(f"[AVISO] Elemento inválido en: {file_path}")

            else:
                print(f"[AVISO] Formato JSON no válido en: {file_path}")
                invalid_files += 1

    commands.sort(
        key=lambda command: (
            command.get("categoria_db", ""),
            command.get("id", ""),
            command.get("nombre", "")
        )
    )

    database = {
        "_meta": {"total_registros": len(commands)},
        "comandos": commands
    }

    try:
        with open(output_path, "w", encoding="utf-8") as file:
            json.dump(
                database,
                file,
                indent=2,
                ensure_ascii=False
            )
            file.write("\n")
    except OSError as error:
        print(f"[ERROR] No se pudo generar la base de datos: {error}")
        raise SystemExit(1)

    print(f"[OK] Archivos procesados: {total_files}")
    print(f"[OK] Comandos recopilados: {len(commands)}")
    print(f"[OK] Archivos inválidos: {invalid_files}")
    print(f"[OK] Base de datos: {output_path}")


if __name__ == "__main__":
    build_commands_db()