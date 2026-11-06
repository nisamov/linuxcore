# Teoría de systemd: unidades, dependencias y objetivos

`systemd` es un sistema de inicio y gestor de servicios usado por numerosas distribuciones Linux. Administra unidades, resuelve dependencias y activa recursos del sistema durante el arranque o bajo demanda.

## Tipos de unidad

- **Service (`.service`):** proceso o servicio del sistema.
- **Socket (`.socket`):** punto de escucha que puede activar un servicio cuando llega una conexión local.
- **Target (`.target`):** grupo lógico de unidades que representa un estado o etapa del sistema.
- **Mount y automount:** montajes de sistemas de archivos, permanentes o activados bajo demanda.
- **Timer (`.timer`):** activación programada de otra unidad.
- **Path (`.path`):** activación cuando cambia una ruta vigilada.

Las unidades pueden depender de otras unidades mediante relaciones como `Wants=`, `Requires=`, `After=` y `Before=`. Las dependencias de orden no implican por sí solas que una unidad requiera otra; distingue entre orden y requisito.

## Objetivos y ciclo de vida

Un *target* agrupa unidades relacionadas; `multi-user.target` suele representar un sistema multiusuario sin entorno gráfico, mientras que `graphical.target` añade componentes gráficos cuando están instalados. Los nombres disponibles y el objetivo predeterminado dependen de la distribución.

Las unidades pueden habilitarse para activarse en el arranque, iniciarse en el momento o quedar enmascaradas para impedir su activación. Los permisos administrativos necesarios y los efectos varían según la operación.

## Buenas prácticas operativas

- Se recomienda dar preferencia a las unidades proporcionadas por paquetes; para cambios locales deben utilizarse las rutas de configuración de administrador y los *drop-ins* documentados.
- El contenido de una unidad debe revisarse antes de ejecutarla como root.
- La configuración y el estado pueden consultarse con `systemctl cat nombre.service` y los registros del journal.
- Después de editar unidades, los cambios deben validarse con las herramientas de systemd y debe comprobarse el estado del servicio.
- Antes de modificar servicios de red o arranque, deben conservarse copias de configuración y un método de recuperación.

Una unidad mal configurada puede causar fallos de arranque o interrupción del servicio. Los cambios deben realizarse en una ventana planificada y probarse primero en un sistema no productivo.
