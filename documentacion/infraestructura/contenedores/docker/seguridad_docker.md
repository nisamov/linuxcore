# Seguridad de contenedores Docker

Los contenedores comparten el kernel del host. Proporcionan aislamiento útil, pero no equivalen a máquinas virtuales y una configuración excesivamente privilegiada puede exponer el sistema anfitrión.

## Principio de mínimo privilegio

- Los procesos deben ejecutarse como usuarios no privilegiados cuando la imagen lo permita.
- `--privileged`, las capacidades adicionales y los montajes del socket de Docker deben evitarse salvo necesidad justificada.
- La CPU, la memoria y los procesos deben limitarse para reducir el impacto de errores o agotamiento de recursos.
- Se recomienda el uso de sistemas de archivos de solo lectura cuando sea viable y el montaje exclusivo de las rutas imprescindibles.
- El motor Docker y el kernel deben mantenerse actualizados; el acceso al daemon, que concede control elevado sobre el host, debe restringirse.

## Imágenes y cadena de suministro

Se recomienda el uso de imágenes oficiales o de proveedores verificados, fijar versiones o digests cuando la reproducibilidad sea importante y reconstruir periódicamente para incorporar parches. Los paquetes innecesarios deben reducirse, las imágenes deben analizarse en el flujo de desarrollo y las credenciales de registro deben protegerse.

Los secretos no deben copiarse en capas de imágenes, argumentos de construcción, historial del shell ni repositorios. Deben utilizarse mecanismos de secretos adecuados para el entorno de ejecución y concederse acceso únicamente a los servicios que lo necesitan.

## Redes, volúmenes y registros

Solo deben exponerse los puertos necesarios; los servicios internos no deben publicarse en todas las interfaces. Las redes de contenedores deben segmentarse según su función y las reglas de comunicación deben validarse. Los volúmenes persistentes deben protegerse con permisos apropiados, copias de seguridad y cifrado cuando corresponda.

Los eventos del motor y de las aplicaciones deben registrarse, la retención de datos sensibles debe limitarse y los cambios de imagen, privilegios y puertos publicados deben monitorizarse.

## Revisión antes del despliegue

Durante la revisión deben comprobarse el usuario efectivo, las capacidades, los montajes, los secretos, los límites, los puertos y la procedencia de la imagen. Las actualizaciones y la restauración deben probarse en un entorno de ensayo. Los cambios de red, montajes o usuario pueden interrumpir una aplicación; antes del despliegue deben prepararse la reversión y la validación del funcionamiento.
