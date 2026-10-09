# Administración de Procesos

## El Sistema de Ficheros Virtual `/proc`

El núcleo de Linux almacena información dinámica sobre el estado del sistema y los procesos en ejecución en el directorio `/proc`. No ocupa espacio en el disco duro, ya que es un sistema de archivos pseudovirtual generado en la memoria RAM por el kernel.

* `/proc/meminfo` - Estado de la memoria física y de intercambio (SWAP) disponible y utilizada.
* `/proc/cpuinfo` - Información detallada del procesador (modelo, arquitectura, núcleos, caché).
* `/proc/version` - Versión del kernel de Linux, compilador utilizado y fecha de compilación.
* `/proc/uptime` - Tiempo que lleva el sistema encendido y tiempo de inactividad de los núcleos.
* `/proc/cmdline` - Parámetros pasados al kernel durante el arranque.
* `/proc/net/` - Directorio con estadísticas e información sobre interfaces de red, rutas y conexiones.
* `/proc/sys/` - Parámetros modificables del kernel en tiempo de ejecución (red, memoria, seguridad).
* `/proc/$PID/` - Subdirectorio dedicado a un proceso específico identificado por su PID. Contiene:
* `/proc/$PID/cmdline` - Comando exacto y argumentos con los que se inició el proceso.
* `/proc/$PID/cwd` - Enlace simbólico al directorio de trabajo actual del proceso.
* `/proc/$PID/environ` - Variables de entorno asociadas al proceso.
* `/proc/$PID/exe` - Enlace simbólico al archivo ejecutable original.
* `/proc/$PID/fd/` - Directorio con los descriptores de archivo abiertos por el proceso.
* `/proc/$PID/status` - Estado legible en texto plano (PID, PPID, uso de memoria, hilos, etc.).

## Inspección de Procesos con `ps`

El comando `ps` (Process Status) muestra una captura puntual del estado de los procesos en ejecución. Admite sintaxis de estilo UNIX (con guion `-`), estilo BSD (sin guion) y estilo GNU (con doble guion `--`).

* `ps -e` o `ps -A` - Muestra todos los procesos del sistema.
* `ps -u usuario` - Muestra los procesos pertenecientes al usuario especificado.
* `ps -x` - Incluye procesos que no están vinculados a ninguna terminal (como demonios).
* `ps aux` - Sintaxis BSD muy habitual. Lista todos los procesos de todos los usuarios, detallando consumo de recursos y terminales.
* `ps -ef` - Sintaxis UNIX muy extendida. Lista todos los procesos con formato completo (UID, PID, PPID, C, STIME, TTY, TIME, CMD).
* `ps -p PID` - Muestra la información única del proceso filtrado por su número PID.
* `ps -C nombre` - Filtra los procesos por el nombre exacto del ejecutable.
* `ps -f` - Muestra el formato completo (incluye UID, PPID o proceso padre, hora de inicio).
* `ps -H` o `ps --forest` - Representa los procesos en forma de árbol jerárquico según la relación padre-hijo.
* `ps -eo pid,user,%cpu,%mem,comm` - Permite personalizar las columnas mostradas en la salida.
* `ps aux --sort=-%mem` - Ordena los procesos de forma descendente según el uso de memoria RAM.

## Monitoreo en Tiempo Real y Campos de Estado (`top` / `htop`)

Comandos como `top` o `htop` proporcionan una vista dinámica y actualizada en tiempo real del uso de recursos del sistema y de las métricas de cada proceso.

* **PID** - Identificador único del proceso (Process ID).
* **USER** - Usuario propietario que ejecuta el proceso.
* **PRI / PR** - Prioridad real del proceso asignada por el planificador del kernel. Cuanto menor sea el número, mayor será la prioridad de asignación de CPU.
* **NI** - Valor *Nice* o grado de cortesía (-20 a 19). Permite ajustar manualmente la prioridad de un proceso. Un valor negativo da mayor prioridad (requiere privilegios de root); un valor positivo otorga menor prioridad.
* **VIRT** - Memoria virtual total reservada por el proceso (incluye código, datos, librerías compartidas y páginas en disco).
* **RES** - Memoria residente: cantidad de memoria RAM física real que el proceso está consumiendo en el momento actual. Es la medida más precisa del uso de memoria física.
* **SHR** - Memoria compartida utilizada con otros procesos (por ejemplo, librerías del sistema cargadas en común).
* **S** - Estado del proceso:
* `R` (Running) - En ejecución o en la cola listo para ejecutarse en la CPU.
* `S` (Sleeping) - En reposo interrumpible, esperando un evento o señal para despertar.
* `D` (Uninterruptible Sleep) - En espera no interrumpible, generalmente bloqueado por operaciones de Entrada/Salida en disco.
* `T` (Stopped / Traced) - Detenido manualmente por una señal de control o por un depurador.
* `Z` (Zombie) - Proceso finalizado pero que aún conserva entrada en la tabla de procesos porque su padre no ha leído su código de salida.

* **%CPU** - Porcentaje de capacidad de la CPU consumido instantáneamente por el proceso.
* **%MEM** - Porcentaje de la memoria RAM física total asignado a dicho proceso.
* **TIME+** - Tiempo total acumulado de CPU consumido por el proceso desde su inicio, expresado con precisión de centésimas de segundo.
* **COMMAND** - Comando o ejecutable que inició el proceso.

## Ciclo de Vida y Tipos de Procesos

* **Proceso Padre e Hijo:** Todo proceso es creado por otro proceso mediante la llamada al sistema `fork()`. El proceso creador es el Padre (PPID) y el nuevo es el Hijo (PID).
* **PID 1 (`systemd` o `init`):** Es el primer proceso cargado por el kernel durante el arranque y el ancestro de todos los demás procesos del sistema.
* **Procesos Huérfanos:** Cuando un proceso padre termina antes que sus hijos, los procesos hijos quedan huérfanos y son adoptados automáticamente por el proceso `systemd` (PID 1) para gestionar su limpieza al finalizar.
* **Procesos Zombi:** Ocurre cuando un proceso hijo finaliza su tarea (`exit`), pero su padre no ejecuta la llamada `wait()` para recoger su código de terminación. No consumen RAM ni CPU, pero ocupan un número dentro de la tabla de procesos del kernel.

## Control de Trabajos en la Terminal (Foreground y Background)

* **Primer plano (Foreground):** El proceso toma el control de la terminal interactiva bloqueando el prompt hasta terminar.
* **Segundo plano (Background):** Se añade el carácter `&` al final del comando para ejecutar el proceso sin bloquear la terminal.
* `Ctrl + C` - Envía la señal `SIGINT` para cancelar el proceso ejecutado en primer plano.
* `Ctrl + Z` - Envía la señal `SIGTSTP` para pausar la ejecución del proceso en primer plano y enviarlo suspendido al fondo.
* `jobs` - Muestra la lista de trabajos activos o pausados asociados a la sesión de terminal actual.
* `fg %N` - Mueve el trabajo número `N` del segundo plano al primer plano.
* `bg %N` - Reanuda en segundo plano la ejecución de un trabajo que estaba en estado pausado.
* `nohup comando &` - Ejecuta un comando inmune a la desconexión de la terminal (`SIGHUP`), permitiendo que siga ejecutándose si el usuario cierra sesión.
* `disown %N` - Desvincula un trabajo activo de la terminal actual para evitar que termine cuando esta se cierre.

## Señales del Sistema y Comandos de Manipulación

Una señal es un mecanismo de comunicación asíncrona mediante el cual el kernel o un usuario notifica a un proceso que ha ocurrido un evento específico. El proceso puede capturar la señal, ignorarla o ejecutar la acción predeterminada por el sistema.

### Señales Principales

* **SIGHUP (1)** - *Hang Up*. Notifica la desconexión o cierre de la terminal controladora. Se usa comúnmente en demonios para forzar la relectura de sus archivos de configuración sin reiniciar.
* **SIGINT (2)** - *Interrupt*. Generada habitualmente con `Ctrl + C`. Solicita la interrupción limpia del proceso.
* **SIGQUIT (3)** - *Quit*. Similar a `SIGINT`, pero genera un volcados de memoria (*core dump*) del proceso antes de finalizar.
* **SIGKILL (9)** - *Kill*. Finalización forzada e inmediata. No puede ser interceptada, ignorada ni bloqueada por el proceso. Destruye el proceso al instante.
* **SIGSEGV (11)** - *Segmentation Fault*. Notifica que el proceso ha intentado acceder a una posición de memoria no permitida o no asignada.
* **SIGTERM (15)** - *Termination*. Señal por defecto enviada para solicitar el cierre ordenado de un software. Permite al proceso liberar recursos y guardar su estado antes de salir.
* **SIGCONT (18 / 19)** - *Continue*. Reanuda la ejecución de un proceso que se encontraba pausado o detenido.
* **SIGSTOP (19 / 20)** - *Stop*. Pausa indefinidamente la ejecución del proceso. Al igual que `SIGKILL`, no puede ser ignorada ni bloqueada.

### Comandos para Enviar Señales

* `kill -SEÑAL PID` - Envía una señal específica a un proceso mediante su número PID. Por defecto envía `SIGTERM (15)` si no se especifica otra (ejemplo: `kill -9 1234` o `kill -SIGKILL 1234`).
* `killall -SEÑAL nombre_proceso` - Envía la señal a todos los procesos que coincidan exactamente con el nombre especificado del ejecutable (ejemplo: `killall nginx`).
* `pkill -SEÑAL patrón` - Envía la señal a los procesos cuyo nombre o línea de comandos coincida con una expresión regular o criterio específico (ejemplo: `pkill -u ubuntu` finaliza los procesos del usuario ubuntu).
