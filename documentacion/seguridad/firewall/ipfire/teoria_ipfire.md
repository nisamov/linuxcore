# IPFire: conceptos y configuración inicial

IPFire es una distribución Linux especializada en cortafuegos y encaminamiento. Se instala en un equipo o máquina virtual que separa redes con distintos niveles de confianza. Su interfaz web facilita administrar servicios, reglas y actualizaciones desde una red de gestión autorizada.

## Zonas de red

IPFire asigna interfaces a zonas identificadas por colores. En instalaciones comunes, **RED** conecta con una red no confiable o el proveedor; **GREEN** representa la red interna confiable. **BLUE** suele reservarse para dispositivos inalámbricos y **ORANGE** para una zona de servicios publicados. La disponibilidad y el uso de cada zona dependen del hardware, la versión y el diseño de red.

Las zonas no reemplazan el análisis de riesgo. El diseño debe definir los flujos requeridos entre redes y denegar los que no sean necesarios. La interfaz de administración debe permanecer en una zona restringida y no exponerse directamente a Internet.

## Planificación e instalación

Antes de la instalación, deben consultarse los requisitos vigentes del proyecto IPFire, verificarse la compatibilidad del hardware y prepararse una copia de la configuración de red. Para las zonas previstas deben reservarse interfaces físicas distintas y documentarse el direccionamiento. En una máquina virtual, los adaptadores virtuales y sus redes deben definirse antes del primer arranque.

La instalación sobre un disco seleccionado puede borrar sus datos. El dispositivo debe comprobarse cuidadosamente y cualquier información necesaria debe respaldarse antes de confirmar. La imagen debe descargarse únicamente desde el sitio oficial y su suma de comprobación o firma debe verificarse con los datos publicados por el proyecto.

Durante el asistente inicial:

- Se selecciona la distribución de interfaces y se asigna cada zona al adaptador previsto.
- Se configura el direccionamiento, la puerta de enlace y DNS según el diseño aprobado.
- Se establecen credenciales administrativas únicas y se almacenan en un gestor seguro.
- Se actualiza el sistema y se restringe el acceso al panel de administración.
- Se aplican reglas mínimas y se prueba el tráfico permitido y denegado desde equipos de cada zona.

## Operación segura

- IPFire debe mantenerse actualizado y los avisos del proyecto deben revisarse.
- Los respaldos de configuración deben exportarse y conservarse en una copia protegida fuera del equipo.
- Los cambios de reglas deben registrarse con motivo, responsable y fecha de revisión.
- Los registros y la disponibilidad deben monitorizarse, y la restauración de la configuración debe probarse.
- Debe verificarse que ninguna regla exponga servicios de administración a redes no confiables.

La interfaz, los nombres de menús y las opciones cambian entre versiones. El procedimiento debe seguir la documentación oficial de IPFire correspondiente a la versión instalada, y los cambios deben probarse en laboratorio antes de su despliegue en producción.
