# Reemplazar un disco

Este procedimiento resume las comprobaciones y operaciones habituales para sustituir un disco independiente, un miembro de RAID por software `mdadm` o un dispositivo usado por LVM. Las operaciones de inicialización y sustitución pueden sobrescribir datos; el método debe corresponder al almacenamiento identificado.

## Requisitos previos

- Copia de seguridad externa y restauración probada. RAID y LVM no sustituyen una copia independiente.
- Sistema GNU/Linux. Las órdenes de RAID y LVM dependen de la implementación y sus versiones; los ejemplos no declaran una versión probada.
- Inventario de particiones, sistemas de archivos, UUID, montajes, RAID, LVM, cifrado y dependencias de arranque.
- Identificación del disco antiguo por modelo, número de serie o WWN, no solo por su nombre `/dev/sdX`.
- Repuesto compatible en interfaz, formato sectorial y capacidad utilizable. En RAID, el repuesto debe cumplir las condiciones de la implementación y ofrecer al menos la capacidad requerida por el miembro sustituido.
- Ventana de mantenimiento y acceso alternativo si el disco contiene el sistema o el equipo no admite intercambio en caliente.

Antes de una reconstrucción RAID, los miembros restantes deben estar identificados y su estado debe ser compatible con la redundancia del nivel utilizado. Si el disco presenta errores físicos y no existe una copia válida, la prioridad es preservar y recuperar los datos, no iniciar una reconstrucción que pueda forzar a los demás miembros.

## Procedimiento

1. Recopila el inventario antes de retirar dispositivos. Estos comandos son de consulta; los de LVM y RAID se aplican solo cuando existen esas capas:

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,MODEL,SERIAL,WWN
findmnt
sudo pvs
sudo vgs
sudo lvs
sudo mdadm --detail /dev/md0
```

Comprueba que `/dev/md0`, si aparece, es el arreglo correcto y anota qué particiones lo componen. Relaciona el dispositivo lógico con el número de serie físico. No continúes si hay ambigüedad sobre cuál es el disco que se va a retirar.

2. Detén ordenadamente los servicios que utilizan el almacenamiento y desmonta los sistemas de archivos cuando corresponda. Apaga el equipo salvo que el fabricante confirme que el dispositivo y la controladora admiten intercambio en caliente.

3. Sustituye el disco conforme a las instrucciones del fabricante. Al volver a detectar el almacenamiento, identifica el repuesto por su número de serie y comprueba su capacidad antes de particionarlo o incorporarlo a una capa existente.

4. Continúa por la rama que corresponda:

- **Disco independiente:** crea en el repuesto el diseño de particiones y sistemas de archivos que requiere el sistema, usando la documentación de la distribución o el inventario. La creación de un sistema de archivos destruye los datos previos del destino. Restaura los datos desde una copia comprobada y actualiza las referencias basadas en UUID si los identificadores nuevos no coinciden con la configuración existente. No hay un comando universal seguro de particionado o formateo para todos los usos.

- **Miembro de RAID por software `mdadm`:** este ejemplo aplica únicamente a un miembro de un arreglo conocido y a un repuesto ya particionado con una partición compatible. Confirma el estado del arreglo y la identidad de ambas particiones mediante `mdadm --detail` y `lsblk`. Las siguientes operaciones modifican el arreglo; `--fail` se utiliza solo si el miembro antiguo todavía figura activo:

```bash
sudo mdadm --manage /dev/md0 --fail /dev/particion_antigua
sudo mdadm --manage /dev/md0 --remove /dev/particion_antigua
sudo mdadm --manage /dev/md0 --add /dev/particion_nueva
```

No ejecutes estas órdenes con nombres de ejemplo ni sobre un arreglo distinto. Si el miembro ya está marcado como fallido, no repitas `--fail`; sigue con la retirada solo si el estado del arreglo lo permite. La incorporación inicia la reconstrucción y puede reducir el rendimiento. Mantén el sistema bajo observación hasta que `mdadm --detail /dev/md0` indique que la sincronización terminó y que el arreglo está sano. En arreglos de controladora, RAID distintos o configuraciones con metadatos especiales, utiliza el procedimiento del fabricante o de la implementación correspondiente.

- **PV de LVM todavía legible:** la migración requiere espacio libre suficiente en otro PV del mismo grupo. Si el repuesto tiene una partición de destino vacía y previamente identificada, `pvcreate` inicializa metadatos LVM en ella; esta operación modifica el dispositivo:

```bash
sudo pvcreate /dev/particion_nueva
sudo vgextend grupo /dev/particion_nueva
sudo pvmove /dev/particion_antigua /dev/particion_nueva
```

Comprueba que `pvmove` terminó y que `pvs` ya no muestra extensiones asignadas en el PV antiguo. Solo entonces retira el PV antiguo del grupo y elimina su etiqueta LVM:

```bash
sudo vgreduce grupo /dev/particion_antigua
sudo pvremove /dev/particion_antigua
```

Estos comandos requieren privilegios de administrador y alteran metadatos de almacenamiento. No inicialices una partición que contenga datos que deban conservarse. Si el PV antiguo ya no es legible o el grupo carece de espacio suficiente, este método no puede recuperar por sí solo sus datos: restaura desde una copia o consulta un procedimiento de recuperación.

5. Si se sustituyó el disco de arranque, restaura también las particiones de arranque, la configuración EFI, el cargador, el cifrado y las referencias de montaje según el esquema documentado de la distribución. El procedimiento varía con el firmware (UEFI o BIOS), el esquema de particiones y las capas instaladas; no existe una secuencia universal de comandos.

## Verificación

Comprueba el estado del dispositivo, los volúmenes, el sistema de archivos y los puntos de montaje:

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,MODEL,SERIAL
findmnt
sudo pvs
sudo vgs
sudo lvs
sudo mdadm --detail /dev/md0
```

Omite los comandos de LVM o RAID que no correspondan. Confirma que los datos y aplicaciones estén disponibles, que los registros del kernel no muestren nuevos errores de E/S y que el equipo pueda arrancar si el disco reemplazado contenía componentes de inicio. En RAID, espera a que concluya la reconstrucción antes de considerar restaurada la redundancia.

## Reversión

Conserva el disco antiguo sin borrar hasta verificar el repuesto y la restauración. La reversión deja de ser equivalente cuando el nuevo almacenamiento ya recibe escrituras: volver al anterior podría perder cambios recientes.
Si el estado nuevo falla, detén las escrituras y decide entre restaurar la copia de seguridad o recuperar el disco original, teniendo en cuenta cuál contiene los datos más recientes.

## Advertencias

- La identificación incorrecta del dispositivo puede destruir datos de un disco sano.
- `pvcreate`, `pvremove`, las operaciones de `mdadm` y la creación de sistemas de archivos modifican metadatos o contenido.
- Un reemplazo RAID solo restablece tolerancia a fallos si el nivel ofrece redundancia y el arreglo termina la reconstrucción.
- No retires un disco con el equipo encendido salvo que todo el hardware y la configuración admitan intercambio en caliente.
- El borrado de archivos o el formateo rápido no garantizan la sanitización del disco antiguo; aplica el método aprobado para el medio y la política local.
