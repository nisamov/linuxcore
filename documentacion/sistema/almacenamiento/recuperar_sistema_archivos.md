# Recuperar un sistema de archivos

Este procedimiento orienta la evaluación y reparación de sistemas de archivos GNU/Linux tras errores lógicos o una interrupción. La reparación de metadatos no recupera necesariamente archivos eliminados, bloques sobrescritos ni daños físicos.

## Requisitos previos

- Identificación inequívoca del dispositivo, de su sistema de archivos y de las capas que lo contienen.
- Copia de seguridad comprobada. Si el medio muestra errores de entrada/salida (E/S) o degradación física, la prioridad es preservar los datos y trabajar sobre una imagen; una reparación repetida sobre el original puede agravar la pérdida.
- Acceso de administrador y disponibilidad de la herramienta específica del sistema de archivos.
- Sistema GNU/Linux. Las herramientas y opciones disponibles dependen de la distribución y sus versiones; los ejemplos no declaran una versión probada.
- Un entorno de rescate si el sistema afectado es la raíz (`/`), para evitar repararlo montado como raíz activa.

No ejecutes una reparación hasta distinguir una inconsistencia lógica de un fallo del dispositivo. Si los datos son irremplazables o el disco falla físicamente, detén la intervención y considera recuperación especializada.

## Procedimiento

1. Registra el estado y localiza el volumen. Estos comandos consultan dispositivos, montajes y mensajes del kernel:

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,MODEL,SERIAL
findmnt
sudo journalctl -k -b
```

Identifica si el sistema de archivos está en una partición, un volumen lógico, un dispositivo cifrado o un RAID. `/dev/sdX` es una asignación variable y no basta para identificar un disco físico; compara el modelo o número de serie.

2. Si hay errores de E/S, ruidos anómalos, desconexiones o alertas de salud del dispositivo, no inicies una reparación lógica sobre el original. Preserva el medio y prioriza una imagen o la asistencia especializada. La recuperación desde una imagen requiere un destino distinto y suficiente espacio; su creación también puede someter a carga un dispositivo degradado.

3. Detén los servicios que escriben en el sistema de archivos y confirma su estado de montaje. Las herramientas de reparación indicadas abajo requieren que el volumen esté desmontado:

```bash
findmnt --source /dev/dispositivo
```

Si se trata de `/`, inicia un entorno de rescate. No desmontes un volumen activo sin conocer las dependencias de los servicios.

4. Selecciona la herramienta según el formato. No son intercambiables:

| Sistema de archivos | Comprobación inicial | Reparación |
|---|---|---|
| ext2, ext3, ext4 | `sudo e2fsck -fn /dev/particion` | `sudo e2fsck -f /dev/particion` |
| XFS | `sudo xfs_repair -n /dev/particion` | `sudo xfs_repair /dev/particion` |

Sustituye los nombres ilustrativos por el dispositivo exacto que contiene el sistema de archivos. La comprobación de ext con `-n` y la comprobación de XFS con `-n` no realizan las correcciones habituales; aun así, deben ejecutarse sobre el volumen correcto y desmontado. La reparación modifica metadatos y puede afectar la accesibilidad de archivos. En `e2fsck`, revisa las propuestas antes de confirmarlas.

En XFS no uses `xfs_repair -L` como medida rutinaria: descarta el registro y puede perder cambios recientes. Requiere un análisis específico y una copia recuperable. Para Btrfs, las operaciones de `scrub` y `check` tienen alcances distintos; `btrfs check --repair` no es una reparación general y no debe ejecutarse sin seguir la documentación oficial del formato y preservar primero los datos.

5. Si la reparación se completa, conserva sus mensajes y el código de salida. Si informa de errores que no pudo corregir, se interrumpe o reaparecen errores de E/S, no repitas el proceso automáticamente; vuelve al diagnóstico del medio y a la copia de seguridad.

## Verificación

Con el volumen montado de acuerdo con su uso normal, comprueba los datos y servicios afectados. `findmnt` y `df` muestran el montaje y el espacio disponible:

```bash
findmnt --target /punto/de/montaje
df -hT /punto/de/montaje
sudo journalctl -k -b
```

La finalización de la herramienta no demuestra por sí sola que todos los datos estén íntegros. Comprueba la lectura de los datos esperados, la integridad de las aplicaciones que los utilizan y la ausencia de nuevos errores de E/S. Si faltan archivos, la restauración desde una copia conocida es preferible a reparaciones sucesivas.

## Reversión

La reparación de metadatos no tiene una reversión universal. Una imagen previa permite recuperar el estado capturado y una copia de seguridad permite restaurar los datos; sin ellas, el resultado puede ser irreversible.
Si el estado empeora, detén las escrituras y evita sobrescribir la única copia recuperable.

## Advertencias

- No ejecutes `e2fsck` sobre XFS, `xfs_repair` sobre ext ni una herramienta de reparación sobre un sistema de archivos montado para escritura.
- La recuperación lógica no corrige fallos físicos ni garantiza recuperar archivos.
- Las opciones de corrección automática o destructiva pueden descartar estructuras; no deben emplearse sin comprender su efecto.
- Los sistemas raíz, cifrados o RAID requieren identificar y preparar la capa correcta antes de cualquier comprobación.
