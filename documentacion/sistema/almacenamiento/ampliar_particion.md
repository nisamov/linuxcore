# Ampliar una partición

Este procedimiento describe la ampliación de una partición y del sistema de archivos o volumen lógico que contiene. El orden depende de la topología: cada capa debe disponer del tamaño nuevo antes de que pueda crecer la siguiente.

## Requisitos previos

- Copia de seguridad reciente, externa al dispositivo y cuya restauración se haya comprobado.
- Acceso de administrador.
- Sistema GNU/Linux. Las herramientas y opciones disponibles dependen de la distribución y sus versiones; los ejemplos no declaran una versión probada.
- Capacidad adicional ya asignada al disco o volumen virtual y visible para el sistema operativo.
- Espacio sin asignar contiguo al final de la partición que se ampliará.
- Herramientas adecuadas al sistema de archivos y a las capas utilizadas. `growpart` suele distribuirse con `cloud-guest-utils`; `resize2fs` con `e2fsprogs`; `xfs_growfs` con `xfsprogs`; LVM requiere sus herramientas de administración.
- Ventana de mantenimiento si la tabla de particiones no puede releerse en línea o el sistema necesita reiniciarse.

Los ejemplos con `/dev/sda` y `/dev/sda3` son marcadores ilustrativos, no valores universales. No se debe continuar hasta identificar el dispositivo por su modelo o número de serie, la partición, el sistema de archivos y sus capas. En almacenamiento cifrado, RAID o configuraciones distintas a las descritas, el orden debe ajustarse a la topología y a la documentación específica.

## Procedimiento

1. Identifica los dispositivos, montajes y tipos de sistema de archivos. Estos comandos son de consulta; `sudo` permite leer la tabla de particiones y los metadatos de LVM:

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,MODEL,SERIAL
findmnt
sudo parted -l
sudo pvs
sudo vgs
sudo lvs
```

Los últimos tres comandos se aplican solo si el sistema utiliza LVM. Confirma la relación entre disco, partición, RAID, cifrado, PV, LV y punto de montaje. La denominación `/dev/sdX` puede variar entre arranques.

2. Confirma que el espacio libre es contiguo y posterior a la partición, y que el sector inicial no cambia. Si la nueva capacidad del disco todavía no aparece en `lsblk`, la detección depende del bus, el controlador o el hipervisor; no continúes hasta que el sistema operativo muestre el tamaño correcto.

3. Evalúa el cambio de la tabla de particiones con `growpart` en modo de simulación. El comando requiere permisos de administrador y no debe ejecutarse hasta verificar el disco y el número de partición:

```bash
sudo growpart --dry-run /dev/sda 3
```

Si el resultado no muestra exclusivamente la ampliación prevista, detente. Cuando la simulación sea correcta, la ejecución real modifica la tabla de particiones:

```bash
sudo growpart /dev/sda 3
```

Comprueba con `lsblk` que Linux ve el nuevo tamaño de la partición. Si el kernel no puede releer una partición que está en uso, no fuerces la actualización: programa un reinicio o una ventana de mantenimiento y vuelve a comprobar el tamaño.

4. Amplía la capa que contiene el sistema de archivos:

- **LVM sobre la partición ampliada:** `pvresize` actualiza el tamaño reconocido por el volumen físico. Después de confirmar espacio libre suficiente en el grupo, `lvextend --resizefs` aumenta el volumen lógico y solicita el crecimiento del sistema de archivos compatible. Ambos comandos modifican almacenamiento:

```bash
sudo pvresize /dev/sda3
sudo vgs
sudo lvextend --resizefs --size +20G /dev/grupo/volumen
```

`+20G` es un ejemplo de tamaño incremental; el volumen y la cantidad deben corresponder al inventario y a la capacidad libre real. No uses `pvresize` sobre una partición que no sea un PV.

- **Sistema de archivos ext directamente en la partición:** `resize2fs` amplía ext2, ext3 o ext4. En las configuraciones compatibles ext4 puede crecer montado; la utilidad y el kernel deben reconocer previamente el nuevo tamaño:

```bash
sudo resize2fs /dev/sda3
```

- **Sistema de archivos XFS directamente en la partición:** XFS debe estar montado y se especifica su punto de montaje:

```bash
sudo xfs_growfs /punto/de/montaje
```

Estas alternativas no son intercambiables. Si la partición contiene cifrado, RAID u otra capa intermedia, no apliques directamente la utilidad del sistema de archivos a la partición: cada capa debe ampliarse según su propia documentación.

## Verificación

Compara el tamaño del disco, la partición, los volúmenes y el sistema de archivos con el estado previo. Los siguientes comandos son de consulta:

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
df -hT /punto/de/montaje
sudo pvs
sudo vgs
sudo lvs
```

Los comandos de LVM se aplican solo si la configuración los utiliza. Confirma que no haya errores nuevos de E/S en los registros del kernel y que el servicio o las aplicaciones puedan usar el espacio adicional.

## Reversión

Una ampliación no tiene una reversión directa garantizada. Reducir el sistema de archivos y después la partición es otra operación, con restricciones propias; XFS no admite reducción en el lugar. Reducir solo la partición puede truncar los datos.

Si la ampliación produce errores, evita nuevas escrituras. La recuperación puede requerir restaurar la imagen o la copia de seguridad previa; no intentes revertir los límites de forma improvisada.

## Advertencias

- Cambiar la partición incorrecta o modificar su sector inicial puede dejar inaccesibles los datos.
- La presencia de espacio libre en el disco no garantiza que sea contiguo a la partición.
- RAID y LVM no sustituyen una copia independiente de los datos.
- Los comandos que modifican la tabla, el PV, el LV o el sistema de archivos requieren privilegios de administrador y verificación previa de cada dispositivo.
