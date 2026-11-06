#!/usr/bin/env bash

# Ejemplos de bucles en Bash. Ejecuta este archivo con Bash, no con sh.
set -euo pipefail

# Recorrer una lista sin dividir palabras que contienen espacios.
servicios=("servidor web" "base de datos" "monitorización")
for servicio in "${servicios[@]}"; do
    printf 'Servicio: %s\n' "$servicio"
done


# Recorrido numérico con la sintaxis aritmética de Bash.
for ((numero = 1; numero <= 3; numero++)); do
    printf 'Iteración %d\n' "$numero"
done

# while lee de forma segura cada línea, incluso si termina en una barra invertida.
archivo="${1:-}"
if [[ -n "$archivo" ]]; then
    if [[ ! -r "$archivo" ]]; then
        printf 'No se puede leer el archivo indicado.\n' >&2
        exit 1
    fi

    while IFS= read -r linea || [[ -n "$linea" ]]; do
        printf 'Línea: %s\n' "$linea"
    done < "$archivo"
fi

# until repite mientras la condición sea falsa; este contador termina en 3.
contador=1
until (( contador > 3 )); do
    printf 'Contador: %d\n' "$contador"
    ((contador += 1))
done

# break termina el bucle y continue omite el resto de la iteración actual.
for numero in 1 2 3 4 5; do
    (( numero == 2 )) && continue
    (( numero == 5 )) && break
    printf 'Valor procesado: %d\n' "$numero"
done
