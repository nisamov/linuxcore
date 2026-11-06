# Fundamentos y administración inicial de PostgreSQL

PostgreSQL es un sistema gestor de bases de datos relacional y objeto-relacional. Organiza datos en clústeres, bases de datos, esquemas, tablas y otros objetos; los clientes se conectan mediante un servidor que autentica usuarios y ejecuta consultas SQL.

## Conceptos y arquitectura

- **Clúster de base de datos:** directorio de datos administrado por una instancia PostgreSQL; no equivale a un clúster de alta disponibilidad.
- **Base de datos y esquema:** una base contiene esquemas, que agrupan tablas, vistas, funciones y otros objetos.
- **Rol:** identidad que puede iniciar sesión, poseer objetos o recibir privilegios; los roles pueden agruparse mediante membresías.
- **Transacción:** secuencia de operaciones que se confirma o revierte como unidad conforme a las propiedades ACID.
- **WAL (Write-Ahead Logging):** registro previo de cambios que permite recuperación ante fallos y sirve como base para replicación y recuperación a un punto en el tiempo.

## Instalación y acceso

PostgreSQL debe instalarse desde repositorios confiables de la distribución o del proyecto, de acuerdo con la guía de la versión elegida. El nombre del paquete, la unidad systemd, la ubicación de datos y los métodos de autenticación varían según la plataforma.

En instalaciones locales, la escucha debe restringirse a las interfaces necesarias y la autenticación debe configurarse con el método apropiado. El puerto de la base de datos no debe exponerse a redes públicas por defecto. Deben crearse roles nominales con privilegios mínimos y evitarse conexiones de aplicaciones como superusuario.

## Administración básica

La administración inicial incluye la creación de bases y roles, la asignación de privilegios por esquema y objeto, la definición de copias de seguridad, la planificación de actualizaciones y la monitorización de conexiones y almacenamiento. Las contraseñas deben mantenerse en un gestor o almacén de secretos; no deben incluirse en la línea de comandos ni en archivos versionados.

Antes de realizar cambios de esquema o configuración, estos deben probarse en un entorno de ensayo y debe conservarse una copia recuperable. Después de cada cambio deben verificarse las conexiones, los permisos, los registros y los tiempos de respuesta.

## Seguridad y continuidad

Deben aplicarse actualizaciones soportadas, cifrarse las conexiones con TLS cuando atraviesen redes no confiables, restringirse el acceso mediante firewall y revisarse `pg_hba.conf` de acuerdo con la política local. Las copias deben configurarse y las restauraciones deben probarse; una copia no verificada no demuestra que la base pueda recuperarse.

Para alta disponibilidad, las réplicas, los respaldos y los mecanismos de elección o conmutación deben mantenerse separados. La replicación por sí sola no protege frente a borrados propagados ni sustituye a las copias históricas.
