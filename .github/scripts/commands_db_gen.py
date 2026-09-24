import json
import os

def build_services_db():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    services_path = os.path.abspath(os.path.join(script_dir, '../../servicios'))
    db_output_dir = os.path.abspath(os.path.join(script_dir, '../db'))
    db_output_file = os.path.join(db_output_dir, 'services.json')
    mega_db = []
    
    def get_empty_service_structure(service_name, category_name, source_file):
        return {
            "servicio": service_name,
            "descripcion": "Sin descripción registrada.",
            "categoria_db": category_name,
            "archivo_fuente": source_file,
            "opciones": [],
            "instalacion": {
                "es_instalable": False,
                "pasos": {}
            },
            "ejemplos": []
        }

    print(f"--> Buscando servicios en: {services_path}")
    if not os.path.exists(services_path):
        print(f"[ERROR] La carpeta '{services_path}' no existe. Revisa la ubicación desde donde ejecutas el script.")
        return
    if not os.path.exists(db_output_dir):
        os.makedirs(db_output_dir)
        
    total_archivos = 0
    for root, _, files in os.walk(services_path):
        json_files = [f for f in files if f.endswith('.json')]
        if not json_files:
            continue
        categoria = os.path.basename(root)
        print(f"Procesando categoría [{categoria}] - Encontrados {len(json_files)} archivos")

        for file in json_files:
            full_path = os.path.join(root, file)
            service_name_fallback = os.path.splitext(file)[0]
            
            try:
                if os.path.getsize(full_path) == 0:
                    print(f"   [AVISO] {file} está vacío. Aplicando estructura por defecto.")
                    empty_data = get_empty_service_structure(service_name_fallback, categoria, file)
                    mega_db.append(empty_data)
                    total_archivos += 1
                    continue

                with open(full_path, 'r', encoding='utf-8') as f:
                    try:
                        data = json.load(f)
                        
                        if isinstance(data, dict):
                            if "servicio" not in data or not data["servicio"]:
                                data["servicio"] = service_name_fallback
                            data['categoria_db'] = categoria
                            data['archivo_fuente'] = file
                            mega_db.append(data)
                        elif isinstance(data, list):
                            for item in data:
                                if isinstance(item, dict):
                                    if "servicio" not in item or not item["servicio"]:
                                        item["servicio"] = service_name_fallback
                                    item['categoria_db'] = categoria
                                    item['archivo_fuente'] = file
                            mega_db.extend(data)
                            
                        total_archivos += 1
                        
                    except json.JSONDecodeError:
                        print(f"   [JSON CORRUPTO] Error de sintaxis en {file}. Aplicando estructura limpia.")
                        empty_data = get_empty_service_structure(service_name_fallback, categoria, file)
                        mega_db.append(empty_data)
                        total_archivos += 1
                        
            except (OSError, TypeError, ValueError, KeyError) as e:
                print(f"   [ERROR CRÍTICO] No se pudo acceder a {file}: {e}")

    with open(db_output_file, 'w', encoding='utf-8') as f:
        json.dump(mega_db, f, indent=2, ensure_ascii=False)
    print(f"\n[ÉXITO] Base de datos de servicios generada en: {db_output_file}")
    print(f" Total de servicios indexados: {total_archivos}")

if __name__ == "__main__":
    build_services_db()