#!/usr/bin/env bash

# Arrays indexados, asociativos y operaciones básicas con cadenas.
set -euo pipefail

# Las comillas dobles preservan cada elemento, incluidos sus espacios.
discos=("Disco del sistema" "Disco de respaldo")
printf 'Cantidad de discos: %d\n' "${#discos[@]}"
for disco in "${discos[@]}"; do
    printf 'Elemento: %s\n' "$disco"
done

# Añadir y eliminar un elemento en un array indexado.
discos+=("Disco de laboratorio")
unset 'discos[2]'

# Los arrays asociativos requieren Bash 4 o posterior.
declare -A puertos=([ssh]=22 [https]=443)
puertos[http]=80
for servicio in "${!puertos[@]}"; do
    printf '%s escucha en el puerto %s\n' "$servicio" "${puertos[$servicio]}"
done

texto="Linux y Bash"
printf 'Texto: %s\n' "$texto"
printf 'Longitud: %d\n' "${#texto}"
printf 'Prefijo: %s\n' "${texto:0:5}"
printf 'Reemplazo: %s\n' "${texto/Bash/shell}"

# Expansión con valor predeterminado si una variable no está definida o vacía.
nombre="${NOMBRE:-persona usuaria}"
printf 'Hola, %s.\n' "$nombre"
