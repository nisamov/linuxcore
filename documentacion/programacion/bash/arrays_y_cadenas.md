# Arrays y cadenas en Bash

Bash permite almacenar varias cadenas en arrays y manipular el contenido de variables textuales.

## Arrays indexados

```bash
discos=("Disco del sistema" "Disco de respaldo")

echo "Cantidad: ${#discos[@]}"
echo "Primero: ${discos[0]}"

discos+=("Disco de laboratorio")
unset 'discos[2]'
```

Recorre todos los elementos conservando sus espacios:

```bash
for disco in "${discos[@]}"; do
    echo "$disco"
done
```

Los índices comienzan en cero.

## Arrays asociativos

Los arrays asociativos requieren Bash 4 o posterior:

```bash
declare -A puertos=([ssh]=22 [https]=443)
puertos[http]=80

for servicio in "${!puertos[@]}"; do
    echo "$servicio escucha en el puerto ${puertos[$servicio]}"
done
```

`${!puertos[@]}` devuelve las claves y `${puertos[$servicio]}` devuelve el valor asociado.

## Longitud y subcadenas

```bash
texto="Linux y Bash"

echo "${#texto}"
echo "${texto:0:5}"
echo "${texto:8}"
```

El índice comienza en cero.

## Mayúsculas y minúsculas

```bash
echo "${texto^^}"
echo "${texto,,}"
echo "${texto^}"
echo "${texto,}"
```

Los dos primeros modificadores convierten toda la cadena. Los otros convierten solo el primer carácter.

## Concatenación y reemplazo

```bash
texto="Linux"
texto+="Core"
echo "$texto"

texto="servidor1_servidor2"
echo "${texto/servidor/nodo}"
echo "${texto//servidor/nodo}"
```

## Prefijos y sufijos

```bash
ruta="/var/log/syslog.txt"

echo "${ruta##*/}"
echo "${ruta%/*}"
echo "${ruta%.*}"
```

- `##` elimina el prefijo coincidente más largo.
- `#` elimina el prefijo coincidente más corto.
- `%%` elimina el sufijo coincidente más largo.
- `%` elimina el sufijo coincidente más corto.