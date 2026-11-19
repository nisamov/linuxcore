# Fechas y horas en Bash

El comando `date` permite obtener, formatear y calcular fechas en scripts.

## Tiempo Unix

El tiempo Unix representa los segundos transcurridos desde el 1 de enero de 1970 a las 00:00:00 UTC:

```bash
date +%s
date -d '2026-11-03 20:30:00' +%s
date -d '@1700000000'
```

## Formatos

| Código | Resultado |
| --- | --- |
| `%d` | Día del mes. |
| `%m` | Mes numérico. |
| `%Y` | Año con cuatro dígitos. |
| `%H` | Hora en formato de 24 horas. |
| `%M` | Minutos. |
| `%S` | Segundos. |
| `%A` | Nombre completo del día. |
| `%B` | Nombre completo del mes. |
| `%F` | Fecha ISO `AAAA-MM-DD`. |
| `%T` | Hora `HH:MM:SS`. |
| `%s` | Segundos desde el tiempo Unix. |
| `%Z` | Nombre de la zona horaria. |
| `%z` | Desfase respecto a UTC. |

```bash
date '+%A %d de %B de %Y'
date '+%F %T'
```

## Copias y registros

```bash
fichero_copia="copia_$(date +%Y%m%d_%H%M%S).tar.gz"
```

El nombre incluye la fecha y hora para diferenciar ejecuciones.

## Medir una ejecución

```bash
inicio=$(date +%s)
sleep 2
fin=$(date +%s)
duracion=$(( fin - inicio ))
echo "Tiempo transcurrido: $duracion segundos"
```

## Consultar otra zona horaria

```bash
TZ=UTC date '+%Y-%m-%d %H:%M:%S %Z'
```

La variable `TZ` solo afecta al proceso indicado si se utiliza antes del comando.

## Cambiar el idioma temporalmente

```bash
LC_TIME=C date '+%A, %B %d, %Y'
```

La salida puede variar según los idiomas disponibles en el sistema.