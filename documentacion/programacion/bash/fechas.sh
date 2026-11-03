#!/bin/bash

# El Tiempo Unix (Epoch) es el número de segundos transcurridos desde el 1 de enero de 1970 a las 00:00:00 UTC.
# Se utiliza en sistemas informáticos para almacenar y comparar fechas numéricamente sin sufrir desajustes por zonas horarias o formatos regionales.

# Obtener los segundos Unix actuales:
date +%s

# Convertir una fecha específica a segundos Unix:
date -d "2026-11-03 20:30:00" +%s

# Convertir una marca de tiempo Unix a un formato legible por humanos:
date -d @1700000000
date -d @1700000000 "+%Y-%m-%d %H:%M:%S"

# Días:
# %d : Día del mes con dos dígitos (01..31)
# %j : Día del año (001..366)
# %u : Día de la semana en número (1 es Lunes, 7 es Domingo)
# %A : Nombre completo del día de la semana (ej. Martes)
# %a : Nombre abreviado del día de la semana (ej. Mar)

# Meses y Semanas:
# %m : Mes del año en número (01..12)
# %B : Nombre completo del mes (ej. Noviembre)
# %b : Nombre abreviado del mes (ej. Nov)
# %V : Número de semana del año según estándar ISO (01..53)

# Años:
# %Y : Año con 4 dígitos (ej. 2026)
# %y : Año con los últimos 2 dígitos (ej. 26)

# Horas y Segundos:
# %H : Hora en formato de 24 horas (00..23)
# %I : Hora en formato de 12 horas (01..12)
# %p : Indicador AM o PM (en mayúsculas)
# %M : Minuto (00..59)
# %S : Segundo (00..59)
# %s : Segundos transcurridos desde el Epoch (Tiempo Unix)

# Zonas Horarias:
# %Z : Nombre de la zona horaria (ej. CET, UTC)
# %z : Desfase numérico respecto a UTC (ej. +0100)

# Formatos combinados (Atajos):
# %F : Fecha completa en formato ISO 8601 (equivalente a %Y-%m-%d)
# %T : Hora completa en formato de 24 horas (equivalente a %H:%M:%S)
# %R : Hora y minutos en formato de 24 horas (equivalente a %H:%M)
# %D : Fecha en formato estadounidense (equivalente a %m/%d/%y)

# Formatear la fecha actual:
date +%d%m%Y
date "+%A %d de %B de %Y"
date "+%F %T"

# Creación de variables dinámicas para backups o logs:
fich_backup="copia_$(date +%Y%m%d_%H%M%S).tar.gz"

# Medir el tiempo de ejecución de un proceso:
inicio=$(date +%s)
sleep 2
fin=$(date +%s)
duracion=$((fin - inicio))
echo "Tiempo transcurrido: ${duracion} segundos"

# Consultar la fecha en otra zona horaria sin cambiar la del sistema:
TZ=UTC date "+%Y-%m-%d %H:%M:%S %Z"

# Cambiar temporalmente el idioma de salida de la fecha:
LC_TIME=C date "+%A, %B %d, %Y"
