# Cron y tareas programadas

Cron permite ejecutar comandos o scripts de forma periódica. Cada cuenta puede tener una tabla individual llamada crontab y el administrador puede controlar tareas comunes para el sistema.

## Requisitos previos

- Un sistema Linux con el servicio `cron` o `crond` instalado.
- Permisos para editar la tabla correspondiente a la cuenta.
- Rutas absolutas y entorno de ejecución definido en cada tarea cuando sea necesario.

## Sintaxis de crontab

```text
minuto hora día_mes mes día_semana comando
```

Los cinco campos admiten valores y patrones:

| Campo | Valores |
| --- | --- |
| Minuto | `0-59` |
| Hora | `0-23` |
| Día del mes | `1-31` |
| Mes | `1-12` o nombres |
| Día de la semana | `0-7` o nombres; `0` y `7` suelen representar domingo |

Ejemplos:

```bash
0 3 * * * /usr/local/bin/copia.sh
*/15 * * * * /usr/local/bin/comprobar.sh
30 8 * * 1-5 /usr/local/bin/informe.sh
0 0 1 * * /usr/local/bin/limpieza-mensual.sh
```

- `*` representa todos los valores.
- `*/15` representa cada 15 unidades.
- `1-5` representa un rango.
- Las comas permiten indicar varios valores, por ejemplo `1,15,30`.

## Gestionar la crontab

```bash
crontab -e
crontab -l
crontab -r
```

`crontab -r` elimina toda la tabla del usuario sin pedir confirmación. Revisa primero la tabla existente con `crontab -l` y conserva una copia si es necesaria.

La variable de usuario puede modificarse al inicio:

```text
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MAILTO=usuario@example.invalid

0 2 * * * /root/scripts/copia.sh
```

El entorno de cron puede ser distinto al de una sesión interactiva. Preferentemente usa rutas absolutas y evita depender de variables que solo estén definidas en `.bashrc`.

## Archivos de configuración del sistema

Las distribuciones suelen incluir directorios especiales:

```text
/etc/crontab
/etc/cron.d/
/etc/cron.hourly/
/etc/cron.daily/
/etc/cron.weekly/
/etc/cron.monthly/
```

En `/etc/crontab` y `/etc/cron.d` debe indicarse el usuario que ejecutará el trabajo:

```text
0 4 * * * root /usr/local/bin/mantenimiento.sh
```

Los scripts dentro de los directorios diarios, semanales y mensuales deben tener permisos adecuados y un nombre sin caracteres especiales. El planificador de la distribución determina cuándo los ejecuta.

## Comprobación y registros

Cron registra normalmente actividad mediante el demonio de inicio o el diario del sistema:

```bash
sudo systemctl status cron
sudo journalctl -u cron
```

En sistemas con `crond`, el nombre del servicio puede ser `crond`:

```bash
sudo systemctl status crond
sudo journalctl -u crond
```

Para distinguir entre problemas de cron y problemas del script:

1. Ejecuta el comando manualmente con el mismo usuario.
2. Prueba primero el script desde una sesión no interactiva.
3. Guarda la salida y los errores en archivos temporales o logs controlados.
4. Comprueba permisos, rutas absolutas y variables de entorno.

## Script seguro

```bash
#!/bin/bash
set -euo pipefail

fecha=$(date +%F)
log="/var/log/copia-$fecha.log"

/usr/local/bin/copia.sh >> "$log" 2>&1
```

El script utiliza un archivo en `/var/log`, por lo que necesita ejecutarse con permisos suficientes, normalmente como root o mediante una política controlada.

## Alternativa con systemd timers

Los timers de systemd pueden sustituir a cron cuando se necesita arranque diferido, dependencias, ejecución tras la finalización de tareas o activación basada en servicios.

Ejemplo conceptual:

```text
[Timer]
OnCalendar=daily
Persistent=true
```

El intervalo horario puede ser más fiable que cron si el equipo estuvo apagado, pero `Persistent=true` hace que se ejecuten de nuevo las activaciones vencidas al volver a encender el equipo.

## Advertencias

- Los trabajos de cron no usan por defecto el entorno interactivo de un usuario.
- Los comandos que borran datos, comprimen directorios o reinician servicios deben confirmar el destino antes de automatizarse.
- No introduzcas contraseñas ni claves privadas directamente en una crontab.
- Revisa con `crontab -l` o los archivos de configuración antes de eliminar trabajos.
