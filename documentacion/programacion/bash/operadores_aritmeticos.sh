#!/bin/bash

# Bash solo soporta operaciones con enteros de forma nativa. Para operaciones en punto flotante (decimales) hay que usar aplicaciones como `bc` o `awk`.

# La sintaxis de una operación aritmética puede realizarse de varias formas:
# - $((...)) evalúa la expresión dentro y devuelve el resultado. Es el método recomendado.
# - ((...)) sin el '$' ejecuta la operación, modifica variables o evalúa condiciones sin devolver texto.
# - `let` permite asignar operaciones directamente a variables.
# - `expr` es un comando externo tradicional que evalúa la expresión e imprime el resultado.

# Los operadores aritméticos usuales son:
# "+"   Suma
# "-"   Resta
# "*"   Multiplicación
# "/"   División entera (trunca el resultado decimal)
# "%"   Módulo (resto de la división)
# "**"  Exponenciación / Potencia
# "++"  Incremento
# "--"  Decremento

# Operadores de asignación compuesta:
# "+=", "-=", "*=", "/=", "%="

# Operadores a nivel de bits (bitwise):
# "&" (AND), "|" (OR), "^" (XOR), "~" (NOT), "<<" (desplazamiento izq), ">>" (desplazamiento der)

# Ejemplos con $((...)) y ((...)):
a=5
b=2
echo $((a + b))      # output: 7
echo $((5 % 2))      # output: 1
echo $((2 ** 3))     # output: 8
((a++))              # Incrementa 'a' en 1 (pasa a valer 6)
((a += 10))          # Le suma 10 a 'a' (pasa a valer 16)

# Ejemplos con el comando `let`:
let resultado=a+b    # Asigna la suma a la variable resultado (sin espacios alrededor del '=')
let "resultado = a * b" # Si hay espacios en la expresión, se usan comillas

# Ejemplos con `expr` (Requiere espacios obligatorios entre operandos y escapar el asterisco '*'):
# input: expr 1 + 1
# output: 2
# input: expr 5 \* 2
# output: 10

# Trabajar con diferentes bases numéricas en $((...)):
# Hexadecimal: prefijo 0x -> $((0xFF))      # output: 255
# Octal: prefijo 0       -> $((010))       # output: 8
# Base N: base#numero    -> $((2#1010))    # output: 10 (binario a decimal)

# Operaciones con decimales / punto flotante (usando herramientas externas):
# Con `bc` (se usa 'scale' para indicar la cantidad de decimales deseados):
echo "scale=2; 5 / 2" | bc                # output: 2.50

# Con `awk`:
awk 'BEGIN {print 5 / 2}'                 # output: 2.5

# ";"    Separador entre órdenes, permite ejecutar múltiples comandos en una sola línea.
## apt update ; apt upgrade ;
# "&&"   Ejecuta el segundo comando solo si el primero tuvo éxito (retorno 0).
## apt update && apt upgrade -y
# "||"   Ejecuta el segundo comando solo si el primero falló (retorno distinto de 0).
## apt update || rm -rf /tmp
# "&"    Ejecuta el comando en segundo plano, permitiendo continuar con la terminal.
## ( cmd_1 && cmd_2 ) || ( cmd_3 & cmd_4 )
# "()"   Agrupa comandos.
## ( cmd_1 && cmd_2 ) || ( cmd_3 & cmd_4 )
# "{}"    Agrupa comandos.
## { cmd_1 && cmd_2; } || { cmd_3 & cmd_4; }
