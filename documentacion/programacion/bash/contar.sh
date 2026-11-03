#!/bin/bash

# Sintaxis: ${#variable}
# Devuelve el número total de caracteres de la variable.
echo ${#s} # Resultado: 5

# Sintaxis: ${variable:posicion_inicio:longitud}
# El índice comienza en 0. Si se omite la longitud, extrae hasta el final.
echo ${s:0:3} # Resultado: "Lin" (extrae 3 caracteres desde el índice 0)
echo ${s:2}   # Resultado: "nux" (extrae desde el índice 2 hasta el final)
echo ${s: -3} # Resultado: "nux" (extrae los últimos 3 caracteres; nota el espacio antes del signo menos)

# Disponible en Bash 4.0 o superior.
echo ${s^^} # Resultado: "LINUX" (convierte toda la cadena a mayúsculas)
echo ${s,,} # Resultado: "linux" (convierte toda la cadena a minúsculas)
echo ${s^}  # Convierte solo el primer carácter a mayúscula
echo ${s,}  # Convierte solo el primer carácter a minúscula

s+="OS" # Equivale a: s="${s}OS"
echo $s # Resultado: "LinuxOS"

# En Bash, [[ ... ]] devuelve un código de estado 0 para verdadero y 1 para falso.

# Comprobar si contiene una subcadena usando comodines (*):
[[ $s == *nu* ]]
echo $? # Resultado: 0 (verdadero)

# Comprobar inicio o fin de cadena:
[[ $s == Lin* ]] # Verdadero si empieza por "Lin"
[[ $s == *OS ]]  # Verdadero si termina en "OS"

# Comprobar expresiones regulares con =~:
[[ $s =~ ^[A-Za-z]+$ ]] # Verdadero si solo contiene letras

# Reemplazo de texto:
# Sintaxis: ${variable/busqueda/reemplazo}
texto="servidor1_servidor2"
echo ${texto/servidor/nodo}  # Resultado: "nodo1_servidor2" (reemplaza la primera coincidencia)
echo ${texto//servidor/nodo} # Resultado: "nodo1_nodo2" (reemplaza todas las coincidencias)


# Eliminacion de prefijos y sufijos de cadenas usando patrones.
ruta="/var/log/syslog.txt"
# ${variable#patron}  : Elimina el prefijo coincidente más corto
# ${variable##patron} : Elimina el prefijo coincidente más largo
# ${variable%patron}  : Elimina el sufijo coincidente más corto
# ${variable%%patron} : Elimina el sufijo coincidente más largo

echo ${ruta##*/} # Resultado: "syslog.txt" (extrae solo el nombre del archivo)
echo ${ruta%/*}  # Resultado: "/var/log" (extrae solo el directorio)
echo ${ruta%.*}  # Resultado: "/var/log/syslog" (elimina la extensión)

# Valores por defecto y asignación condicional en Bash permiten manejar variables que pueden no estar definidas o vacías, proporcionando una forma de establecer valores predeterminados o asignar valores solo si la variable no tiene un valor.
# ${variable:-defecto} : Usa el valor por defecto si la variable está vacía o no definida (no modifica la variable)
# ${variable:=defecto} : Asigna el valor por defecto a la variable si está vacía
echo ${usuario:-"invitado"} # Si $usuario no existe, imprime "invitado"
