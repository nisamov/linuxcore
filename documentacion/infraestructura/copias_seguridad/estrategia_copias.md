# Estrategia de copias de seguridad 3-2-1

La regla 3-2-1 es una guía de resiliencia: conservar al menos tres copias de los datos, en dos tipos o ubicaciones de almacenamiento, con una copia fuera de la ubicación principal. No reemplaza un análisis de riesgos ni garantiza una recuperación si las copias no se pueden restaurar.

## Definir objetivos

- **RPO (Recovery Point Objective):** cantidad máxima de datos que se acepta perder, expresada como intervalo de tiempo.
- **RTO (Recovery Time Objective):** tiempo objetivo para recuperar un servicio o conjunto de datos.
- **Alcance:** datos, aplicaciones, configuración, claves y dependencias necesarias para reconstruir el servicio.
- **Retención:** periodos de conservación, borrado y requisitos legales o de negocio.

## Diseño de copias

- Los datos, responsables y dependencias deben identificarse y clasificarse.
- La frecuencia y retención deben elegirse de acuerdo con RPO/RTO y la capacidad disponible.
- Las copias deben mantenerse en medios o dominios de fallo diferentes; al menos una debe aislarse frente a modificaciones desde producción.
- Las copias deben cifrarse y las claves de recuperación deben conservarse en un lugar independiente y controlado.
- Las ejecuciones y los fallos deben supervisarse, y las credenciales de los repositorios deben protegerse.

La variante **3-2-1-1-0** añade una copia aislada o inmutable y cero errores no verificados mediante pruebas de recuperación. La terminología puede variar, pero el principio clave es no depender de una única cuenta, equipo, ubicación o clave.

## Pruebas de restauración

Una tarea completada no demuestra que los datos sean recuperables. Deben programarse restauraciones de muestra y simulacros completos, y validarse la integridad, los permisos, las dependencias, los tiempos y la coherencia de las aplicaciones. El procedimiento, las personas responsables y las lecciones aprendidas deben documentarse.

Una restauración puede sobrescribir datos si se utiliza una ruta equivocada. Primero debe probarse en un destino aislado y conservarse el estado actual; antes de restaurar sobre producción se requiere aprobación.
