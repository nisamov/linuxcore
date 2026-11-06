# Replicación y alta disponibilidad en MariaDB

La replicación de MariaDB copia cambios desde un servidor principal a uno o más servidores réplica. Puede mejorar la disponibilidad de lectura y facilitar recuperación, pero no es por sí sola una solución completa de alta disponibilidad.

## Replicación y componentes

La replicación binlog tradicional registra cambios en el servidor principal y los aplica en réplicas. Puede ser asíncrona, semisíncrona o utilizar GTID (*Global Transaction ID*) según la versión y configuración. En replicación asíncrona, una réplica puede presentar retraso y perder transacciones recientes si el principal falla antes de transmitirlas.

El diseño debe especificar topología, versión compatible, formato de binlog, identidad de servidores, GTID, retención de registros, cifrado del canal y cuentas dedicadas con permisos mínimos. La replicación no debe utilizar la cuenta administrativa general.

## Alta disponibilidad

Un sistema de alta disponibilidad requiere detectar fallos, decidir qué nodo pasa a ser principal, redirigir clientes, evitar dos primarios activos y recuperar el nodo anterior de forma segura. Puede usar un gestor de clúster o una solución de proxy y coordinación compatible con la plataforma.

La elección y configuración dependen del RPO/RTO, del número de nodos, de la latencia y de la versión de MariaDB. El *failover* no es automático por el hecho de tener réplicas. El procedimiento debe documentar cómo confirmar el estado, promover una réplica y volver a incorporar el nodo anterior sin divergencia.

## Seguridad, verificación y recuperación

- Las conexiones entre nodos deben restringirse mediante firewall y TLS.
- Las credenciales y certificados deben protegerse, y los secretos deben rotarse según la política.
- El retraso, el estado de los hilos, el espacio de binlogs y los errores de aplicación deben monitorizarse.
- Deben realizarse copias independientes y probarse la recuperación a un punto temporal.
- Las conmutaciones deben ensayarse en laboratorio y deben definirse criterios de interrupción y reversión.

Una promoción puede provocar pérdida o divergencia de datos si no se verifica qué transacciones recibió cada nodo. El cambio de rol durante un incidente no debe forzarse sin seguir el procedimiento aprobado y conservar los registros necesarios.
