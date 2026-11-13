#!/bin/bash

# Expresiones regulares (Regex)
# Una expresión regular es un patrón que define un conjunto de strings de caracteres.
# Se utilizan para buscar, validar y analizar cadenas de caracteres.
# Permiten combinar expresiones simples mediante diferentes operadores.
# No son específicas de ningún lenguaje de programación.

# Selección de caracteres:
# . : Cualquier carácter excepto el salto de línea.
# ^ : Indica el comienzo de una línea o cadena.
# $ : Indica el final de una línea o cadena.
# ^ tiene un significado diferente cuando se utiliza dentro de [].

# Tipos de caracteres:
# \d : Dígitos del 0 al 9.
# \D : Cualquier carácter que no sea un dígito.
# \w : Caracteres alfanuméricos (a-z, A-Z, 0-9 y _).
# \W : Cualquier carácter que no sea alfanumérico.
# \s : Espacios en blanco (espacio, tabulador, nueva línea).
# \S : Cualquier carácter que no sea un espacio en blanco.
# \b : Límite de una palabra.
# \B : Posición que no representa un límite de palabra.

# IMPORTANTE:
# Bash utiliza expresiones regulares POSIX extendidas (ERE) con =~.
# Por tanto, no reconoce directamente \d, \w, \s o \b.
# Sus equivalencias habituales son:
# [0-9] : Dígitos.
# [^0-9] : Cualquier carácter que no sea un dígito.
# [[:alnum:]] : Caracteres alfanuméricos.
# [[:space:]] : Espacios en blanco.

# Selección de un conjunto de caracteres:
# [abc] : Cualquiera de los caracteres indicados (a, b o c).
# [^abc] : Cualquier carácter excepto los indicados.
# [a-q] : Letras minúsculas desde la a hasta la q.
# [A-Q] : Letras mayúsculas desde la A hasta la Q.
# [0-6] : Dígitos desde el 0 hasta el 6.

# Clases de caracteres:
# [[:upper:]] : Letras mayúsculas.
# [[:lower:]] : Letras minúsculas.
# [[:digit:]] : Dígitos del 0 al 9.
# [[:alpha:]] : Letras del alfabeto.
# [[:alnum:]] : Letras y números.
# [[:space:]] : Espacios en blanco.
# [[:punct:]] : Caracteres de puntuación.

# Cuantificadores:
# ? : El elemento precedente puede aparecer cero o una vez.
# * : El elemento precedente puede aparecer cero o más veces.
# + : El elemento precedente debe aparecer una o más veces.
# {n} : El elemento precedente debe aparecer exactamente n veces.
# {m,} : El elemento precedente debe aparecer al menos m veces.
# {,m} : El elemento precedente puede aparecer como máximo m veces.
# {n,m} : El elemento precedente debe aparecer entre n y m veces.

# Unión de expresiones:
# | : Unión de varias expresiones. Coincide con cualquiera de ellas.
# () : Agrupa varias expresiones para tratarlas como una unidad.

# Caracteres especiales:
# Para buscar literalmente un metacarácter se utiliza \ delante.
# \. : Busca un punto literal.
# \* : Busca un asterisco literal.
# \+ : Busca un signo + literal.
# \? : Busca una interrogación literal.
# \\ : Busca una barra invertida literal.

# Ejemplos de expresiones regulares:
# Pablo        : Busca Pablo.
# ^Pablo       : Busca Pablo al comienzo de la línea.
# Pablo$       : Busca Pablo al final de la línea.
# ^Pablo$      : Busca una línea que contenga únicamente Pablo.
# niñ[oa]      : Busca niño o niña.
# ni[^aeiou]a  : El tercer carácter no puede ser una vocal minúscula.
# ni.a         : El tercer carácter puede ser cualquiera.
# ^....$       : Cualquier línea que contenga exactamente 4 caracteres.
# ^\.          : Cualquier línea que empiece por un punto.
# ^[^\.]       : Cualquier línea que no empiece por un punto.
# [a-z][a-z]*  : Una o más letras minúsculas.
# [Ax5]        : Cualquier carácter que sea A, x o 5.
# boy|girl|thing : Cualquiera de estas tres palabras.
# (sla|ha)ve   : Busca slave o have.
# [0-6]{3}$    : Tres dígitos entre 0 y 6 al final de la línea.

# Operador =~:
# Permite evaluar una expresión regular dentro de una condición [[ ]].
# Sintaxis:
# [[ $variable =~ expresion_regular ]]

# Comprobar si una variable contiene alguna letra mayúscula:
if [[ $1 =~ [A-Z] ]]; then
    echo "Contiene una letra mayúscula"
fi

# Comprobar si una variable contiene únicamente números:
if [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Contiene solamente números"
fi

# Comprobar si una variable tiene exactamente 4 caracteres:
if [[ $1 =~ ^....$ ]]; then
    echo "Tiene exactamente 4 caracteres"
fi

# Comprobar si una variable tiene entre 3 y 8 dígitos:
if [[ $1 =~ ^[0-9]{3,8}$ ]]; then
    echo "Tiene entre 3 y 8 dígitos"
fi

# El operador =~ debe utilizarse dentro de doble corchete [[ ]].
# No funciona con el comando test ni con su alias de un solo corchete [ ].
