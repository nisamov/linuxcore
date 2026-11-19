# Control de flujo en Bash

Las estructuras condicionales y los bucles permiten ejecutar bloques de código según decisiones o repetir acciones hasta cumplir una condición.

## if y elif

```bash
#!/usr/bin/env bash

if (( $1 > 10)); then
    echo "El número es mayor que 10"
elif (( $1 == 10)); then
    echo "El número es igual a 10"
else
    echo "El número es menor que 10"
fi
```

Conviene comprobar que `$1` existe antes de utilizarlo. El uso directo puede producir resultados inesperados si el script se ejecuta sin argumentos.

## Condiciones compactas

```bash
[[ $1 -gt 10 ]] && echo "Mayor que 10" || echo "Menor o igual que 10"
```

Las expresiones largas pueden ser menos legibles y más propensas a errores. Para varias decisiones es preferible usar `if`/`else`.

## while

`while` evalúa la condición antes de cada iteración:

```bash
contador=$1
while (( contador > 13)); do
    echo "$contador es mayor que 13"
    ((contador--))
done
```

El decremento evita que el bucle continúe indefinidamente.

## until

`until` repite las instrucciones mientras la condición sea falsa:

```bash
i=1
until (( i > 5)); do
    echo "Iteración $i"
    ((i++))
done
```

## for

### Lista

```bash
dias="Lunes Martes Miércoles"
for dia in $dias; do
    echo "$dia"
done
```

Para listas con espacios se prefieren arrays:

```bash
mi_lista=(primer_elemento segundo_elemento tercer_elemento)
for elemento in "${mi_lista[@]}"; do
    echo "$elemento"
done
```

Los índices de los arrays comienzan en cero.

### Archivos

```bash
for archivo in /etc/*; do
    echo "$archivo"
done
```

### Estilo C

```bash
end=5
for (( i=1; i<=end; i++)); do
    echo "Índice $i"
done
```

## case

`case` agrupa varias comprobaciones basadas en patrones:

```bash
read -r -p "¿Estás de acuerdo? S o N: " respuesta

case "$respuesta" in
    [sS]|SI|si)
        echo "Sí"
        ;;
    [nN]|NO|no)
        echo "No"
        ;;
    *)
        echo "Respuesta no reconocida"
        ;;
esac
```

## break y continue

- `break` finaliza el bucle actual.
- `continue` omite el resto de la iteración actual y pasa a la siguiente.

```bash
for numero in 1 2 3 4 5; do
    (( numero == 2 )) && continue
    (( numero == 5 )) && break
    echo "Procesando $numero"
done
```