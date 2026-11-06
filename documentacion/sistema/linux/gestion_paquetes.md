# Gestión de paquetes y repositorios en Linux

Un gestor de paquetes instala, actualiza y elimina software manteniendo metadatos de versiones y dependencias. Los repositorios son fuentes configuradas desde las que se obtienen paquetes y actualizaciones.

## Gestores habituales

| Familia | Gestor común | Formato habitual |
| --- | --- | --- |
| Debian y Ubuntu | APT (`apt`) | `.deb` |
| Fedora y RHEL | DNF (`dnf`) | `.rpm` |
| Arch Linux | Pacman (`pacman`) | Paquetes de Pacman |

Los comandos y flujos de actualización pueden variar por versión y distribución. Para sistemas de producción debe consultarse la documentación oficial correspondiente.

## Buenas prácticas

- Deben utilizarse repositorios oficiales o proveedores cuya identidad y firma puedan verificarse.
- Las fuentes de paquetes añadidas deben revisarse y las que ya no sean necesarias deben eliminarse.
- Las actualizaciones deben realizarse en una ventana de mantenimiento y deben revisarse los cambios que afecten a servicios o dependencias.
- Los scripts de instalación descargados no deben ejecutarse sin revisar su origen y contenido.
- Debe evitarse la mezcla de repositorios de versiones distintas de la distribución, ya que puede provocar conflictos o reemplazar bibliotecas críticas.
- El motivo de los paquetes instalados manualmente debe registrarse y el software que ya no se utilice debe eliminarse.

## Actualización, verificación y reversión

Antes de una actualización amplia, debe realizarse un respaldo recuperable y comprobarse el espacio en disco, las dependencias y los avisos del proveedor. Después deben verificarse las versiones, el estado de los servicios y los registros. La reversión no siempre es posible con un simple downgrade; el mecanismo de recuperación debe definirse según el sistema, por ejemplo, mediante una imagen, una instantánea compatible o una reinstalación desde medios confiables.

Una firma válida del repositorio demuestra que el paquete fue firmado por una clave reconocida, no que el software sea infalible. La verificación de origen debe complementarse con la revisión de cambios y la gestión de vulnerabilidades.
