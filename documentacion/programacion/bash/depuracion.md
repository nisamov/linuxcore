# Depuración de scripts de Bash

Depurar consiste en identificar y corregir errores de ejecución o lógica en un script.

## Ejecutar con trazado

```bash
bash -x script.sh
```

La opción `-x` muestra cada comando después de realizar la expansión de variables.

## Depurar una sección

```bash
set -x
# Código que se quiere revisar
echo "Valor: $variable"
set +x
```

`set -x` activa el trazado y `set +x` lo desactiva.

## Opciones útiles

```bash
set -e
set -u
set -o pipefail
```

- `set -e`: termina el script si un comando falla.
- `set -u`: muestra un error si se utiliza una variable no definida.
- `set -o pipefail`: hace fallar una tubería si cualquiera de sus comandos falla.

También pueden combinarse al inicio:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

## Registro de mensajes

```bash
printf 'Ruta recibida: %s\n' "$ruta" >&2
```

Enviar información diagnóstica a la salida de errores evita mezclarla con la salida normal del programa.

## Verificación previa

Antes de ejecutar operaciones destructivas:

- Comprueba argumentos y rutas.
- Prueba el script con datos ficticios.
- Usa mensajes de seguimiento bajo una opción `-v` o `--verbose`.
- Conserva una copia de los archivos que puedan modificarse.