#!/usr/bin/env bash

# Funciones, argumentos y códigos de salida en Bash.
set -euo pipefail

saludar() {
    local nombre="${1:-persona usuaria}"
    printf 'Hola, %s.\n' "$nombre"
}

sumar() {
    if (( $# != 2 )); then
        printf 'Uso: sumar numero1 numero2\n' >&2
        return 2
    fi

    local resultado
    resultado=$(( $1 + $2 ))
    printf '%d\n' "$resultado"
}

archivo_legible() {
    local ruta="${1:-}"
    [[ -n "$ruta" && -f "$ruta" && -r "$ruta" ]]
}

saludar "LinuxCore"
total=$(sumar 7 5)
printf 'La suma es %s.\n' "$total"

if archivo_legible "${1:-}"; then
    printf 'El archivo indicado existe y puede leerse.\n'
else
    printf 'No se indicó un archivo legible.\n'
fi
