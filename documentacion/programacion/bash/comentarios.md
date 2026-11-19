# Comentarios en Bash

Los comentarios permiten explicar el propósito del código y desactivar temporalmente instrucciones sin eliminarlas.

## Comentarios de una línea

Una línea iniciada por `#` es un comentario. Cuando se escribe `#` después de una instrucción, el resto de esa línea no se ejecuta.

```bash
# Comprueba si el primer argumento es mayor que diez
if [[ $1 -gt 10 ]]; then
    echo "El número es mayor que 10"
fi

echo "Hola" # Comentario al final de una instrucción
```

Bash no admite un bloque nativo de comentarios como `/* */`. Cada línea del bloque debe comenzar por `#`.

## El shebang

La primera línea de un script puede indicar el intérprete:

```bash
#!/bin/bash
```

Este valor ayuda al sistema a utilizar Bash cuando el script se ejecuta directamente. El uso de `/usr/bin/env bash` puede ser preferible en sistemas donde Bash no está ubicado siempre en `/bin`.

```bash
#!/usr/bin/env bash
```

## Comentar bloques extensos

Una here-document dirigida a `:` permite desactivar temporalmente varias líneas. El texto no se interpreta como código:

```bash
: << 'FIN_COMENTARIO'
Este texto no se ejecutará.
Puede contener varias líneas de documentación.
FIN_COMENTARIO
```

La palabra final puede modificarse, siempre que coincida exactamente al principio y al final del bloque.

## Casos especiales

El símbolo `#` no siempre inicia un comentario:

- Dentro de una cadena, `#` se interpreta como texto.
- En `${#VARIABLE}`, se utiliza para obtener la longitud de la variable.
- Puede usarse como carácter literal mediante escape.

```bash
echo "Esto # no es un comentario"
echo "La longitud es ${#VARIABLE}"
echo 'Esto \# no es un comentario'
```

## Recomendaciones

- Explica decisiones y efectos, no una traducción obvia de cada línea.
- Mantén los comentarios actualizados al modificar el código.
- Usa comentarios para secciones importantes o instrucciones temporales.
- Comprueba que los ejemplos no contienen secretos ni rutas privadas.