# Pautas de Contribución para LinuxCore

¡Gracias por contribuir a LinuxCore! Antes de enviar una solicitud de extracción, por favor, tómese un momento para revisar estas pautas.

## Proceso de Contribución

El repositorio sigue un estándar fijo de documentación para mantener el orden y permitir una correcta sintaxis.

1. Clonar el repositorio y crear un Pull Request - [Crear Pull Request](https://github.com/Nisamov/LinuxCommands/pulls)
2. Realizar cambios o crear contenido siguiendo la estructura del repositorio
    - [Ejemplo Sintaxis JSON](../README.md)
3. Abrir pull request informando sobre los cambios realizados.
4. Solicitar revisión del pull request.

## Automatización del Proyecto

La automatización que se lleva a cabo en el servidor permite que los comandos, servicios y documentos se muestren en la [página web](https://linuxcore.site) tras haber sigo complementados al repositorio principal.

```sh
...
SUB_DIR="$DEST_DIR/repo"
mkdir -p "$DEST_DIR"
mkdir -p "$DEST_DIR/db"
mkdir -p "$SUB_DIR"
if [ ! -d "$REPO_DIR/.git" ]; then
    git clone "$REPO_URL" "$REPO_DIR"
else
    cd "$REPO_DIR" || exit 1
    git fetch origin main
    git reset --hard origin/main
    git clean -fd
fi
rsync -av --delete --exclude='.git/' "$REPO_DIR/" "$SUB_DIR/"
rsync -av --delete "$REPO_DIR/.github/db/" "$DEST_DIR/db/"
chown -R www-data:www-data "$DEST_DIR"
...
```

El dominio se actualiza de forma automática **cada 15 minutos**

Ejemplo de estructura `.json` de los comandos:

```json
{
  "id": "badblocks",
  "nombre": "badblocks",
  "descripcion": "Busca bloques defectuosos en un dispositivo mediante pruebas de lectura, escritura o lectura-escritura no destructiva.",

  "clasificacion": {
    "categoria": "almacenamiento",
    "subcategoria": "discos",
    "tags": [
      "disco",
      "diagnostico",
      "filesystem"
    ]
  },

  "sintaxis": {
    "principal": "badblocks [opciones] dispositivo [ultimo_bloque] [primer_bloque]",
    "alternativas": []
  },

  "parametros": [
    {
      "flag": "-b",
      "argumento": "block_size",
      "tipo": "integer",
      "requerido": false,
      "default": 1024,
      "valores": [],
      "descripcion": "Especifica el espacio de los bloques en bytes.",
      "conflictos": [],
      "requiere": []
    },
    {
      "flag": "-c",
      "argumento": "blocks_at_once",
      "tipo": "integer",
      "requerido": false,
      "default": 64,
      "valores": [],
      "descripcion": "Especifica el numero de bloques que se prueban a la vez.",
      "conflictos": [],
      "requiere": []
    }
  ],

  "requisitos": {
    "permisos": [
      "root"
    ],
    "dependencias": [],
    "paquetes": [
      "e2fsprogs"
    ]
  },

  "seguridad": {
    "nivel": "critico",
    "destructivo": true,
    "requiere_root": true,
    "requiere_confirmacion": true,
    "advertencias": [
      "El modo -w destruye los datos del dispositivo.",
      "El uso de -f sobre un dispositivo montado puede provocar destruccion."
    ]
  },

  "instalacion": {
    "instalable": true,
    "metodo": "gestor_paquetes",
    "paquetes": {
      "debian_ubuntu": "sudo apt install e2fsprogs -y",
      "arch_linux": "sudo pacman -S e2fsprogs",
      "rhel_centos": "sudo dnf install e2fsprogs -y"
    }
  },

  "ejemplos": [
    {
      "nombre": "prueba_lectura",
      "comando": "sudo badblocks -s -v /dev/sda",
      "descripcion": "Realiza una prueba de lectura mostrando el progreso y la informacion detallada.",
      "resultado_esperado": "Lista de bloques defectuosos y mensajes de progreso."
    },
    {
      "nombre": "prueba_no_destructiva",
      "comando": "sudo badblocks -n -o bloques_defectuosos.txt /dev/sdb1",
      "descripcion": "Realiza una prueba no destructiva y guarda la lista de bloques defectuosos.",
      "resultado_esperado": "Archivo con los bloques defectuosos encontrados."
    }
  ],

  "automatizacion": {
    "idempotente": false,
    "interactivo": false,
    "apto_script": true,
    "variables": [
      {
        "nombre": "DISPOSITIVO",
        "tipo": "device",
        "requerido": true
      }
    ],
    "validaciones": [
      "El dispositivo existe.",
      "El dispositivo no esta montado cuando se utiliza un modo destructivo."
    ],
    "rollback": null
  }
}
```

## Recomendaciones de Extensiones

Para una documentación más cómoda se recomiendan las siguientes extensiones:

- [Data Preview](https://marketplace.visualstudio.com/items?itemName=RandomFractalsInc.vscode-data-preview)
- [Indent Rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
- [Markdown Preview Enchanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)

## Requisitos del Pull Request

- Todos los cambios deben estar en el idioma oficial del repositorio (Español).
- La estructura sigue el Modelo Base del repositorio.
- Es necesario respetar la estructura de directorios y ficheros, así como sus extensiones.
- Se ha verificado que no hay errores tipográficos o de sintaxis.
- Se recomienda revisar cuidadosamente los cambios para asegurar la correcta documentación del contenido.

## Colaboradores

Gracias por contribuir al proyecto, si tu pull request es aceptado, aparecerás en la siguiente lista:

<div align="center">
  <a href="https://github.com/nisamov/linuxcore/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=nisamov/linuxcore" alt="Contribuyentes de LinuxCore" />
  </a>
</div>
