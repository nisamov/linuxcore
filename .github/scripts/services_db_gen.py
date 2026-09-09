import os
import json
base_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
services_path = os.path.join(base_dir, "servicios")
output_file = os.path.join(base_dir, ".github", "db", "services.json")

entries = []
for root, _, files in os.walk(services_path):
    category = os.path.basename(root)
    for filename in sorted(files):
        if not filename.endswith(".json"):
            continue
        filepath = os.path.join(root, filename)
        fallback = os.path.splitext(filename)[0]
        try:
            with open(filepath, "r", encoding="utf-8") as file:
                data = json.load(file)
        except (OSError, json.JSONDecodeError):
            data = {}
        items = data if isinstance(data, list) else [data]
        for item in items:
            if not isinstance(item, dict):
                item = {}
            item.setdefault("servicio", fallback)
            item.setdefault("descripcion", "Sin descripción registrada.")
            item.setdefault("estructura", item["servicio"])
            item["categoria_db"] = category
            item["archivo_fuente"] = os.path.relpath(filepath, base_dir)
            entries.append(item)

os.makedirs(os.path.dirname(output_file), exist_ok=True)
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(entries, f, indent=2, ensure_ascii=False)