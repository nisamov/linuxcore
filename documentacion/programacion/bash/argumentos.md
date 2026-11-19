# Argumentos posicionales en Bash

Los argumentos son valores proporcionados al ejecutar un script. Bash los almacena en variables numeradas.

## Variables principales

| Variable | Descripción |
| --- | --- |
| `$0` | Nombre del script ejecutado. |
| `$1` a `$9` | Primer al noveno argumento. |
| `${10}` | Argumento desde la posición diez. |
| `$#` | Número total de argumentos. |
| `$@` | Lista de argumentos conservando cada elemento. |
| `$*` | Todos los argumentos unidos en una cadena. |

```bash
#!/usr/bin/env bash

echo "Script: $0"
echo "Primer argumento: ${1:-sin argumento}"
echo "Número de argumentos: $#"
```

Ejemplo:

```bash
./script.sh "uno dos" tres
```

## Diferencia entre $* y $@

Entrecomillado, `"$*"` reúne todos los argumentos en una sola palabra separada por el primer carácter de `IFS`. `"$@"` conserva cada argumento como un elemento independiente:

```bash
for argumento in "$*"; do
    echo "$argumento"
done

for argumento in "$@"; do
    echo "$argumento"
done
```

Con los argumentos `"uno dos"` y `tres`, el primer bucle realiza una iteración y el segundo realiza dos.

## Valores predeterminados

```bash
usuario=${1:-invitado}
puerto=${2:-8080}
```

La forma `:-` usa el valor predeterminado si la variable no existe o está vacía.

## Validación

```bash
if (( $# < 2)); then
    echo "Uso: $0 <archivo_origen> <directorio_destino>" >&2
    exit 1
fi
```

Comprueba los argumentos antes de modificar archivos o directorios.

## Desplazar argumentos

`shift` elimina el primer argumento y desplaza los siguientes hacia la izquierda:

```bash
while (( $# > 0)); do
    echo "Argumento: $1"
    shift
done
```

`shift 2` descarta dos posiciones.

## Opciones con getopts

```bash
while getopts "f:v" opcion; do
    case "$opcion" in
        f) archivo="$OPTARG" ;;
        v) verbose=true ;;
        \?) echo "Opción no válida" >&2; exit 1 ;;
    esac
done

shift $((OPTIND - 1))
```

Este método procesa opciones cortas como `-f archivo.txt` y `-v`.