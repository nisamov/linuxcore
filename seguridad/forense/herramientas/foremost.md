# Herramienta `foremost`

`foremost` es una herramienta de análisis forense digital utilizada para la recuperación de datos borrados o corruptos mediante la técnica conocida como *file carving*. Funciona inspeccionando directamente los bloques de una imagen de disco o dispositivo físico, identificando archivos por sus encabezados (*headers*), pies de página (*footers*) y estructuras internas de datos, de forma completamente independiente al sistema de archivos subyacente.

## Sintaxis básica

```bash
foremost -i <imagen_o_dispositivo> -o <directorio_salida> [opciones]
```

## Opciones principales

* **`-i <archivo/dispositivo>`**: Especifica la imagen de entrada (archivos `.img`, `.dd`, etc.) o la partición/disco físico (por ejemplo, `/dev/sdb1`).
* **`-o <directorio>`**: Define la carpeta de salida donde se organizarán los archivos recuperados por categorías y se generará el informe final.
* **`-t <extensiones>`**: Filtra la búsqueda únicamente para los tipos de archivos indicados, separados por comas (ejemplo: `jpg,pdf,png,zip,doc`).
* **`-v`**: Activa el modo detallado (*verbose*), mostrando en la terminal la información de los sectores analizados y los hallazgos en tiempo real.
* **`-q`**: Habilita el modo rápido (*quick mode*), realizando búsquedas orientadas únicamente al inicio de cada sector.
* **`-T`**: Agrega una marca de tiempo (*timestamp*) al nombre del directorio de salida para evitar sobrescribir análisis previos.
* **`-c <archivo_config>`**: Carga un archivo de configuración alternativo en lugar del predeterminado.
* **`-a`**: Desactiva la verificación de errores en la extracción, recuperando todos los bloques que coincidan con la firma aunque estén dañados.

## Casos de uso comunes

Recuperación básica de una imagen de almacenamiento:
```bash
foremost -i volcado1G.img -o ficherosrecuperados
```

Escaneo directo sobre un dispositivo buscando formatos específicos con salida detallada:
```bash
foremost -v -t jpg,pdf,png -i /dev/sdb1 -o /home/usuario/recuperacion_usb
```

Recuperación rápida generando un directorio de salida único con fecha y hora:
```bash
foremost -q -T -i evidencia.dd -o caso_forense
```

## Configuración y firmas de archivos

El comportamiento de la herramienta y el catálogo de firmas soportadas se gestiona en el archivo de configuración global `/etc/foremost.conf`.

* Permite definir firmas de cabecera (*header*) y pie (*footer*) personalizadas expresadas en formato hexadecimal o texto ASCII.
* Permite limitar el tamaño máximo de archivo que se intentará extraer para evitar falsos positivos o archivos corruptos de tamaño excesivo.
* Permite habilitar o deshabilitar la búsqueda de tipos de archivos específicos descomentando o comentando las reglas del archivo.
