## Teoría Discos y Particiones

En sistemas GNU/Linux, el almacenamiento se organiza de forma jerárquica para permitir un uso eficiente, flexible y seguro de los discos. Para ello, se utilizan discos físicos, particiones, sistemas de archivos y puntos de montaje.

Esta organización permite separar datos, mejorar el rendimiento y facilitar la administración del sistema.

### Discos, particiones y sistemas de archivos

Un disco es un dispositivo físico de almacenamiento (HDD, SSD, NVMe).  
Una partición es una división lógica de un disco que permite organizar su contenido.  
Sobre cada partición se crea un sistema de archivos, que define cómo se almacenan y recuperan los datos.

Finalmente, las particiones se montan en el sistema mediante un punto de montaje, que es un directorio del árbol de ficheros.

### Particiones habituales en Linux

En un sistema Linux es común separar el almacenamiento en varias particiones, cada una con una función concreta.

* `/` (raíz): contiene el sistema operativo.
* `/home`: almacena los datos de los usuarios.
* `/var`: contiene datos variables como logs o colas.
* `swap`: área de intercambio entre RAM y disco.
* `EFI`: partición especial utilizada para el arranque en sistemas UEFI.

La memoria EFI no es una partición de datos normal, sino una partición especial que almacena los cargadores de arranque del sistema operativo.

```sh
/dev/sda1   efi             510MB
/dev/sda2   ext4    /       8999MB
/dev/sda3   ext4    /home   4999MB
/dev/sda4   ext4    /var    4000MB
/dev/sda5   swap            1000MB
/dev/sda6   ext4    /usr    7330MB
```

### Nomenclatura de dispositivos en Linux

Linux identifica los discos y particiones como archivos especiales dentro del directorio `/dev`.

La sintaxis general es `/dev/sdXN`, donde:

* **sd** indica el tipo de dispositivo de almacenamiento.
* **X** identifica el disco (a, b, c…).
* **N** indica el número de partición.

Ejemplo: `/dev/sda1` corresponde a la primera partición del primer disco SATA/SCSI.

## Prefijos de dispositivos en Linux

| Prefijo | Bus / Interfaz | Nomenclatura completa | Utilización |
|---|---|---|---|
| sd | SATA, SCSI, USB | `sda`, `sdb` | Discos duros y SSD más comunes. |
| hd | IDE / PATA | `hda` | Discos antiguos (obsoletos). |
| vd | VirtIO | `vda` | Discos virtuales en KVM/QEMU. |
| xvd | Xen | `xvda` | Discos virtuales en Xen. |
| nvme | PCIe | `nvme0n1` | SSD NVMe de alta velocidad. |
| mmcblk | eMMC / SD | `mmcblk0` | Tarjetas y memorias integradas. |
| loop | Loopback | `loop0` | Archivos montados como discos. |
| dm- | Device Mapper | `dm-0` | LVM, cifrado y RAID software. |

### Identificador de partición (Número N)

| ID | Tipo | Ejemplo | Descripción |
|---|---|---|---|
| 1–4 | Primarias / extendidas | `sda1` | Limitación histórica del particionado MBR. |
| 5+ | Lógicas | `sda5` | Particiones dentro de una extendida. |

### Nomenclatura moderna NVMe

Los dispositivos NVMe utilizan una nomenclatura distinta debido a su arquitectura.

| Elemento | Significado | Ejemplo |
|---|---|---|
| nvme0 | Controlador | `nvme0` |
| n1 | Namespace | `n1` |
| p1 | Partición | `p1` |
| Completo | Dispositivo final | `nvme0n1p1` |

## Gestión de Volúmenes Lógicos (LVM)

El particionado tradicional es rígido: una vez creadas las particiones, modificarlas es complejo.  
LVM (Logical Volume Manager) surge para solucionar este problema, añadiendo una capa de abstracción.

LVM permite redimensionar volúmenes, unir discos y reorganizar el almacenamiento sin afectar directamente a los datos.

* **Physical Volume (PV)**: disco o partición inicializada para LVM.
* **Volume Group (VG)**: conjunto de uno o más PV.
* **Logical Volume (LV)**: volumen lógico que actúa como una partición tradicional.

### Flujo de trabajo LVM

El proceso de trabajo con LVM sigue un orden lógico:

1. Inicializar dispositivos como volúmenes físicos (PV).
2. Agruparlos en un grupo de volúmenes (VG).
3. Crear volúmenes lógicos (LV).
4. Crear un sistema de archivos.
5. Montar el volumen lógico.

Para que el montaje sea persistente, se registra en `/etc/fstab`.

```sh
Disco/Partición
  --pvcreate--> PV
  --vgcreate--> VG
  --lvcreate--> LV
  --mkfs--> Sistema de archivos
```

### Volúmenes Físicos (PV)

| Comando | Función | Descripción |
|---|---|---|
| pvcreate | Crear PV | Inicializa un dispositivo para LVM. |
| pvdisplay | Detalle | Muestra información detallada. |
| pvs | Resumen | Listado de PV existentes. |
| pvremove | Eliminar | Elimina la etiqueta LVM. |

## Grupos de Volúmenes (VG)

| Comando | Función | Descripción |
|---|---|---|
| vgcreate | Crear VG | Crea un grupo de volúmenes. |
| vgdisplay | Detalle | Muestra información detallada. |
| vgs | Resumen | Listado de VG. |
| vgextend | Ampliar | Añade PV al VG. |
| vgreduce | Reducir | Elimina PV del VG. |
| vgremove | Eliminar | Borra el VG. |

### Volúmenes Lógicos (LV)

| Comando | Función | Descripción |
|---|---|---|
| lvcreate | Crear | Crea un volumen lógico. |
| lvdisplay | Detalle | Muestra información detallada. |
| lvs | Resumen | Listado de LV. |
| lvextend | Ampliar | Aumenta el tamaño. |
| lvreduce | Reducir | Reduce el tamaño (precaución). |
| lvremove | Eliminar | Elimina el LV. |
