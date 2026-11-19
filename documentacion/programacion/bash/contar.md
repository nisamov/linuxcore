# Contar en Bash

Bash permite contar caracteres, elementos, líneas y repeticiones mediante variables y comandos externos.

## Contar caracteres

```bash
cadena="Linux"
echo "${#cadena} letras"
```

`${#cadena}` devuelve el número de caracteres almacenados en la variable.

## Contar elementos

```bash
usuarios=(ana ben eva)

contador=0
for usuario in "${usuarios[@]}"; do
    ((contador++))
done

echo "Hay $contador usuarios"
```

También puede consultarse directamente:

```bash
echo "Hay ${#usuarios[@]} usuarios"
```

## Contar líneas

```bash
wc -l < /etc/passwd
```

El operador `<` proporciona el archivo como entrada estándar sin incluir el nombre del archivo en la salida.

## Contar palabras o caracteres

```bash
wc -w /ruta/archivo
wc -c /ruta/archivo
```

- `-w` cuenta palabras.
- `-c` cuenta bytes.
- `-m` cuenta caracteres y puede diferir de `-c` si hay caracteres Unicode.

## Contar líneas coincidentes

```bash
grep -c '/bin/bash' /etc/passwd
```

`grep -c` imprime el número de líneas que contienen el patrón.

## Contar repeticiones de texto

```bash
sort archivo.txt | uniq -c
```

Las líneas deben estar ordenadas para que `uniq` agrupe repeticiones consecutivas.