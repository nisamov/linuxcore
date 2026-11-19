# Entrada y argumentos en Bash

Un script puede recibir datos mediante argumentos posicionales, variables de entorno o lectura interactiva.

## Argumentos posicionales

| Variable | Significado |
| --- | --- |
| `$0` | Nombre del script ejecutado. |
| `$1` a `$9` | Primeros argumentos posicionales. |
| `${10}` | Argumento diez o superior. |
| `$#` | Número total de argumentos. |
| `$@` | Argumentos conservados por separado. |
| `$*` | Argumentos unidos en una cadena. |
| `$?` | Código de salida del último comando. |
| `$$` | PID del proceso actual. |
| `$!` | PID del último proceso iniciado en segundo plano. |

Ejemplo:

```bash
#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
    echo "Uso: $0 <numero>" >&2
    exit 1
fi

if (( $1 >= 10)); then
    echo "El número es mayor o igual que 10"
else
    echo "El número es menor que 10"
fi
```

Ejecuta el script:

```bash
./input.sh 15
./input.sh 15 20
```

## Valores predeterminados

```bash
valor=${1:-10}
usuario=${NOMBRE_USUARIO:-invitado}
```

La expansión `:-` utiliza el valor predeterminado si la variable no existe o está vacía.

## Desplazar argumentos

`shift` elimina el primer argumento y desplaza los restantes:

```bash
while (( $# > 0)); do
    echo "Procesando: $1"
    shift
done
```

El bucle consume todos los argumentos pasados al script.

## Lectura interactiva

```bash
read -r -p "Introduce un valor: " variable
```

## Opciones con getopts

```bash
while getopts "f:v" opcion; do
    case "$opcion" in
        f)
            archivo="$OPTARG"
            echo "Archivo: $archivo"
            ;;
        v)
            modo_verbose=true
            ;;
        \?)
            echo "Opción no válida" >&2
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))
```

El dos puntos dentro de la cadena de opciones indica que una opción requiere un argumento.