#!/bin/bash

# La evaluación del estado puede realizarse de muchas formas dependiendo del tipo de datos que se quieran evaluar
# if [ condicion ] usa el [ como un equivalente del comando tradicional `test`. Es el metodo mas estandar y portable, aunque fuerza a que las comparaciones sean de otra manera
# if [[ condicion ]] es una actualizacion de test con funcionalidad extendida. Permite buscar con expresiones regulares y patrones (globs)
# if (( condicion )) es otra extension que permite la evaluacion de operaciones aritmeticas con los operadores usuales (>, <, >=, <=, ==, !=)
# if ( comando ) ejecuta el comando en un subshell que devolverá un codigo de devolucion acorde con el resultado de la ejecución
# if comando ejecuta el comando directamente y evalúa su código de retorno ($? == 0 es verdadero)
#
# La evaluaciones de valores numericos depende del operador usado para incluir la expresión
# -lt   Menor que
# -gt   Mayor que
# -le   Menor o igual
# -ge   Mayor o igual
# -eq   Igual
# -ne   No igual

# Cadenas de texto (strings)
# ==    Igual usando doble corchete
# =     Igual usando test
# !=    No igual
# <     Menor en orden alfabético
# >     Mayor en orden alfabético
# -n    Longitud de string diferente a 0 (no vacía)
# -z    Longitud de string NULL (vacía)
# =~    Igual con expresiones regulares (solo en [[ ]])

# Operadores lógicos
# !     No lógico
# &&    Y logico (en [[ ]], (( )) o entre comandos)
# ||    O Lógico (en [[ ]], (( )) o entre comandos)
# -a    Y lógico (solo dentro de [ ])
# -o    O lógico (solo dentro de [ ])

# Comprobación de ficheros y directorios
# -e    Si existe (fichero, directorio, enlace, etc.)
# -f    Fichero (Si existe y es un fichero regular)
# -d    Si existe y es un directorio
# -s    Si existe y su tamaño es mayor que 0 (no está vacío)
# -r    Si existe y tiene permisos de lectura
# -w    Si existe y tiene permiso de escritura
# -x    Fichero (Si existe y tiene permisos de ejecucion)
# -h    Si existe y es un enlace simbólico (igual que -L)
# -L    Si existe y es un enlace simbólico
# -b    Si existe y es un dispositivo de bloques
# -c    Si existe y es un dispositivo de caracteres
# -p    Si existe y es una tubería nombrada (FIFO)
# -S    Si existe y es un socket

# Comparación entre dos ficheros
# f1 -nt f2   f1 es más reciente que f2 (newer than)
# f1 -ot f2   f1 es más antiguo que f2 (older than)
# f1 -ef f2   f1 y f2 apuntan al mismo archivo (mismo inodo / enlace duro)
