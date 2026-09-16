## Bloque A: Creación y Preparación de los Discos Virtuales

### Paso 1: Crear los archivos que simularán los discos duros
Creamos dos archivos de 1 GB rellenos de ceros en tu carpeta personal.


```bash
dd if=/dev/zero of=~/disco1.img bs=1M count=1024
dd if=/dev/zero of=~/disco2.img bs=1M count=1024
```

### Paso 2: Asociar los archivos a dispositivos de bucle (loop devices)

Engañamos al sistema operativo para que reconozca estos archivos como si fuesen discos físicos conectados por hardware.

```bash
sudo losetup -fP ~/disco1.img
sudo losetup -fP ~/disco2.img
```

### Paso 3: Identificar los nombres asignados por el sistema

Comprobamos qué nombres de dispositivo de tipo loop nos ha asignado Linux.

```bash
lsblk

```

> Para los siguientes pasos, supondremos que el comando te ha devuelto los nombres `/dev/loop3` y `/dev/loop4`. Si en tu pantalla salen otros números (como `loop0` y `loop1`), sustitúyelos en los comandos de abajo.

### Paso 4: Aplicar particionado GPT al primer disco virtual (/dev/loop3)

Entramos al menú interactivo de fdisk:

```bash
sudo fdisk /dev/loop3
```

Dentro de la herramienta, introduce secuencialmente estas teclas pulsando **Intro** después de cada una:

1. `g` ➔ Crea una nueva tabla de particiones GPT.
2. `n` ➔ Crea una nueva partición (Pulsa **Intro**, **Intro** e **Intro** para aceptar todos los valores por defecto).
3. `t` ➔ Cambia el tipo de partición. Escribe el código `29` (Linux RAID) y pulsa **Intro**.
4. `w` ➔ Guarda los cambios y cierra el programa.

### Paso 5: Aplicar particionado GPT al segundo disco virtual (/dev/loop4)

Repetimos exactamente la misma acción en el segundo dispositivo:

```bash
sudo fdisk /dev/loop4
```

Introduce la misma secuencia de teclas: `g` ➔ `n` (**Intro**, **Intro**, **Intro**) ➔ `t` ➔ `29` ➔ `w`.

---

## Bloque B: Creación y Configuración del RAID 1

### Paso 6: Verificar las particiones resultantes

Al usar dispositivos loop, las particiones añaden una letra `p`. Asegúrate con `lsblk` de que existan estos dos dispositivos:

* `/dev/loop3p1`
* `/dev/loop4p1`

### Paso 7: Crear el arreglo RAID 1

Unimos ambas particiones virtuales en el dispositivo RAID espejo definitivo denominado `/dev/md0`.

```bash
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/loop3p1 /dev/loop4p1

```

### Paso 8: Verificar que el RAID esté activo

Comprobamos que el sistema ha sincronizado el arreglo de manera correcta.

```bash
cat /proc/mdstat
```

También puedes comprobar el estado de salud detallado con:

```bash
sudo mdadm --detail /dev/md0
```

### Paso 9: Crear el sistema de archivos (Formatear)

Damos formato al nuevo dispositivo RAID utilizando el sistema de archivos estándar de Linux (ext4).

```bash
sudo mkfs.ext4 /dev/md0
```

### Paso 10: Montar el RAID en el sistema

Creamos un directorio en el sistema que servirá de acceso y montamos el RAID allí para empezar a guardar archivos.

```bash
sudo mkdir /mnt/raid
sudo mount /dev/md0 /mnt/raid

```

Comprobamos que el almacenamiento está disponible y montado con éxito:

```bash
df -h | grep /mnt/raid

```

---

## Bloque C: Persistencia (Opcional pero Recomendado)

### Paso 11: Configurar el montaje automático en el arranque

Para evitar que se desmonte al reiniciar el equipo, buscamos el identificador único (UUID) del RAID:

```bash
sudo blkid /dev/md0
```

Copia el código UUID largo que aparece en pantalla y añádelo en una línea nueva al final del archivo `/etc/fstab` (puedes editarlo con `sudo nano /etc/fstab`):

```text
UUID=<UUID> /mnt/raid ext4 defaults 0 0

```

### Paso 12: Guardar la configuración de mdadm

Guardamos la estructura para que el sistema recuerde cómo reconstruir este RAID en los próximos arranques.

```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
```