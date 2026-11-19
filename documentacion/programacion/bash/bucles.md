# Bucles en Bash

Los bucles repiten instrucciones sobre una condición, una lista o un rango de valores.

## for

Ejecuta una iteración por cada elemento:

```bash
for servicio in "servidor web" "base de datos" "monitorización"; do
    echo "$servicio"
done
```

Comillas dobles alrededor de elementos con espacios permite conservarlos.

### Rango

```bash
for numero in {1..5}; do
    echo "$numero"
done
```

### Estilo C

```bash
for ((numero=1; numero<=3; numero++)); do
    echo "Iteración $numero"
done
```

### Lista de archivos

```bash
for archivo in *.txt; do
    echo "Procesando $archivo"
done
```

`*.txt` es una expansión de nombre realizada por el shell, no una expresión regular.

## while

`while` repite las instrucciones mientras la condición tenga éxito:

```bash
contador=1
while (( contador <= 3)); do
    echo "Contador: $contador"
    ((contador++))
done
```

### Leer líneas de un archivo

```bash
archivo="archivo.txt"

while IFS= read -r linea || [[ -n "$linea" ]]; do
    echo "Línea: $linea"
done < "$archivo"
```

`IFS=` evita modificar espacios al leer. `-r` impide interpretar barras invertidas como caracteres de escape.

## until

`until` repite las instrucciones mientras la condición tenga error:

```bash
contador=1
until (( contador > 3)); do
    echo "Contador: $contador"
    ((contador++))
done
```

## break y continue

- `break` termina el bucle.
- `continue` pasa a la siguiente iteración.

```bash
for numero in 1 2 3 4 5; do
    (( numero == 2 )) && continue
    (( numero == 5 )) && break
    echo "$numero"
done
```