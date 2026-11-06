# Proceso de arranque de Linux, UEFI y GRUB

El arranque de Linux inicializa el hardware, selecciona un sistema operativo y carga el núcleo junto con los componentes necesarios para montar la raíz y ofrecer servicios.

## Etapas generales

- **Firmware:** BIOS heredado o UEFI inicializa el hardware y selecciona un dispositivo de arranque. UEFI puede validar componentes mediante Secure Boot cuando está configurado.
- **Gestor de arranque:** GRUB u otro gestor presenta opciones y carga el kernel y, normalmente, un initramfs.
- **Kernel:** inicializa controladores, memoria y procesos fundamentales; usa el initramfs para acceder a la raíz si es necesario.
- **Sistema de inicio:** el proceso inicial (habitualmente `systemd`) monta sistemas de archivos, activa unidades y llega al objetivo configurado.
- **Servicios y sesión:** se inician servicios del sistema y, según el equipo, una consola o entorno gráfico.

El orden exacto varía por distribución, firmware, cifrado, sistema de archivos y configuración del equipo.

## UEFI, particiones y Secure Boot

UEFI utiliza una partición de sistema EFI (ESP) con cargadores ejecutables. GPT es el esquema de particiones más común en estos equipos. Secure Boot verifica firmas de componentes autorizados según las claves del firmware; no cifra el disco y no reemplaza la protección de la cuenta ni las actualizaciones.

## Diagnóstico y recuperación

Ante un fallo, deben registrarse el mensaje exacto e identificarse el último cambio; las opciones de recuperación documentadas por la distribución deben utilizarse. Editar entradas de GRUB, cambiar el kernel predeterminado o modificar el firmware puede impedir el arranque. La configuración debe respaldarse y deben estar disponibles medios de recuperación. Las particiones EFI no deben borrarse ni el cargador reinstalarse sin confirmar el esquema de discos y el modo de arranque.

Para reducir riesgos, deben mantenerse copias verificadas de los datos, registrarse los cambios de kernel y cargador, y probarse las actualizaciones importantes con acceso a consola.
