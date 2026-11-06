# Centralización y conservación de registros del sistema

La centralización de registros reúne eventos de varios equipos en un servicio controlado. Facilita correlacionar incidentes, reduce la dependencia del disco local y permite aplicar una política uniforme de acceso y conservación.

## Requisitos de diseño

- Deben definirse los eventos que se recopilan, el nivel de detalle y la finalidad.
- Los relojes de los equipos deben sincronizarse y la zona horaria debe registrarse para construir cronologías coherentes.
- El transporte debe protegerse con cifrado y autenticación mutua cuando la solución lo admita.
- El acceso para consultar, exportar o borrar registros debe restringirse.
- Deben determinarse los periodos de conservación, el borrado seguro y los requisitos legales aplicables.
- Deben dimensionarse el almacenamiento, el ancho de banda, la ingestión y las alertas ante pérdida de comunicación.

Los registros pueden incluir nombres de usuario, direcciones IP y otros datos personales o sensibles. La política de la organización debe incluir minimización de datos y control de acceso.

## Flujo y responsabilidades

Una arquitectura habitual incluye agentes o servicios recolectores en los equipos, un canal autenticado, una plataforma central de recepción y almacenamiento, y herramientas de búsqueda o alertas. Las capacidades exactas varían según syslog, journald y la plataforma seleccionada.

La centralización no garantiza por sí sola la integridad. Deben utilizarse controles de acceso, almacenamiento con protección contra alteraciones cuando sea necesario, auditoría de administradores y copias protegidas. Debe impedirse que un equipo comprometido pueda eliminar o modificar retrospectivamente la única copia de sus eventos.

## Verificación y continuidad

La recepción debe probarse desde sistemas representativos, deben validarse las marcas temporales, los campos y las alertas, y deben simularse interrupciones de red en un entorno controlado. La recuperación de eventos en cola, la actualización de agentes y la restauración de la plataforma deben documentarse. La cobertura, la retención y la capacidad deben revisarse periódicamente, sin asumir que la ausencia de eventos demuestra ausencia de actividad.
