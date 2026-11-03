#!/bin/bash

# Argumnentos posicionales
echo "Nombre del script ejecutado (\$0): $0"
echo "Nombre limpio del script (sin ruta): $(basename "$0")"

echo "Primer argumento (\$1): $1"
echo "Segundo argumento (\$2): $2"
echo "Tercer argumento (\$3): $3"
echo "Décimo argumento (\${10}): ${10}"

# $# : Devuelve la cantidad total de argumentos pasados al script
echo "Número total de argumentos (\$#): $#"
# $* : Devuelve todos los argumentos en una sola cadena
echo "Todos los argumentos con \$*: $*"
# $@ : Devuelve todos los argumentos preservando la separación individual
echo "Todos los argumentos con \$@: $@"


# Diferencia entre "$*" Y "$@" Con comillas

# Ejecución del script con: ./script.sh "uno dos" tres

# "$*" agrupa TODOS los argumentos en un solo bloque de texto.
echo "--- Bucle con \"\$*\" ---"
for arg in "$*"; do
    echo "Elemento: $arg"
done
# Resultado: 1 sola iteración con el texto "uno dos tres"

# "$@" mantiene cada argumento entrecomillado de forma independiente.
# Es el método recomendado para iterar sobre argumentos.
echo "--- Bucle con \"\$@\" ---"
for arg in "$@"; do
    echo "Elemento: $arg"
done
# Resultado: 2 iteraciones ("uno dos" y "tres")

# Valores por defecto y asignación condicional en Bash permiten manejar variables que pueden no estar definidas o vacías, proporcionando una forma de establecer valores predeterminados o asignar valores solo si la variable no tiene un valor.
# Asigna un valor si el parámetro no fue pasado al ejecutar el script:
usuario=${1:-"invitado"}
puerto=${2:-8080}

echo "Usuario: $usuario | Puerto: $puerto"

# Validación de argumentos: Comprobar si se ha pasado un número mínimo de argumentos
# Comprobar si se ha pasado un número mínimo de argumentos
if [ $# -lt 2 ]; then
    echo "Error: Se requieren al menos 2 argumentos."
    echo "Uso correcto: $0 <archivo_origen> <directorio_destino>"
    exit 1
fi

# Desplazamiento de argumentos con 'shift': Permite descartar argumentos procesados y mover los restantes hacia la izquierda.
# 'shift' descarta el primer argumento ($1) y desplaza el resto hacia la izquierda.
# $2 pasa a ser $1, $3 pasa a ser $2, etc.
echo "Primer argumento actual: $1"
shift
echo "Nuevo primer argumento tras shift: $1"

# Se puede indicar el número de posiciones a desplazar:
shift 2 # Desplaza 2 posiciones a la izquierda


# Procesamiento de opciones con getopts: Permite manejar opciones y sus argumentos de manera estructurada.
# Utilizado para scripts que aceptan opciones como: ./script.sh -f archivo.txt -v
while getopts "f:v" opcion; do
    case $opcion in
        f)
            archivo_entrada="$OPTARG"
            echo "Opción -f detectada con valor: $archivo_entrada"
            ;;
        v)
            echo "Modo verbose activado (-v)"
            ;;
        ?)
            echo "Opción no válida"
            exit 1
            ;;
    esac
done

# Elimina las opciones procesadas por getopts para dejar solo los argumentos normales
shift $((OPTIND - 1))