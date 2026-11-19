# Códigos de devolución en Bash

Cada proceso termina con un código numérico. Cero indica éxito y un valor distinto de cero indica un error o una condición determinada por el programa.

## Consultar el código

```bash
comando

echo "Código anterior: $?"
```

La variable `$?` contiene el estado del último comando o función ejecutada.

## Finalizar con exit

```bash
if [[ ! -f "$1" ]]; then
    echo "El archivo no existe" >&2
    exit 1
fi

exit 0
```

Los scripts suelen utilizar `0` para éxito y valores entre `1` y `255` para distintos errores.

## Evaluar directamente

```bash
if id ana &> /dev/null; then
    echo "El usuario existe"
else
    echo "El usuario no existe"
    exit 3
fi
```

El bloque `else` no modifica el sistema.

## Buenas prácticas

- Documenta qué significa cada código cuando un script ofrece varios errores.
- Usa `exit 1` para errores generales y valores específicos para categorías conocidas.
- Redirige errores a la salida estándar de errores.
- No hagas que un script termine con cero después de detectar un error.

Ejemplo de función:

```bash
sumar() {
    if (( $# != 2)); then
        echo "Se requieren dos números" >&2
        return 2
    fi

    echo $(( $1 + $2 ))
}

sumar 3 4
codigo=$?
echo "Código: $codigo"
```