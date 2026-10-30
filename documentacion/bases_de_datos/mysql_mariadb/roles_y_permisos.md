
# Gestión de Roles y Permisos en Base de Datos

En lugar de configurar los privilegios de cada usuario individualmente, las mejores prácticas dictan **crear roles y asignarles permisos**.
Posteriormente, estos roles se otorgan a los usuarios, lo que centraliza, automatiza y facilita la administración de la seguridad.

## Creación de Roles

```sql
-- Crear un único rol
CREATE ROLE 'trabajador';
-- Crear un rol solo si no existe previamente
CREATE ROLE IF NOT EXISTS 'trabajador';
-- Crear múltiples roles a la vez
CREATE ROLE 'ministro', 'suplente', 'ejecutivo', 'juez';
```

## Asignación de Permisos y Roles (GRANT)

```sql
-- 1. Asignar permisos específicos a un rol (ej. sobre todas las tablas de bd_general)
GRANT SELECT, INSERT ON bd_general.* TO 'trabajador';
-- 2. Asignar el rol a un usuario concreto
GRANT 'trabajador' TO 'usuario1'@'localhost'; 
```

## Activación de Roles

Por defecto, cuando un usuario inicia sesión, sus roles pueden estar inactivos, es necesario activarlos:

```sql
-- Activar un rol solo para la sesión actual
SET ROLE 'trabajador'; 
-- Activar todos los roles asignados al usuario en la sesión actual
SET ROLE ALL;
-- Hacer que el rol se active automáticamente cada vez que el usuario inicie sesión
SET DEFAULT ROLE 'trabajador' FOR 'usuario1'@'localhost';
```

## Revocación y Eliminación (REVOKE y DROP)

```sql
-- Quitar un permiso específico a un rol o usuario
REVOKE INSERT ON bd_general.* FROM 'trabajador';
-- Quitar un rol a un usuario
REVOKE 'trabajador' FROM 'usuario1'@'localhost'; 
-- Eliminar un rol de la base de datos por completo
DROP ROLE 'trabajador'; 
```

## Comprobación de Permisos

```sql
-- Ver los permisos y roles asignados a un usuario
SHOW GRANTS FOR 'usuario1'@'localhost';
-- Ver los permisos exactos que tiene un rol
SHOW GRANTS FOR 'trabajador';
```

## Ejemplos practicos

```sql
--Permitir borrar tabla al usuario vendedor
GRANT DELETE ON marketplace.order TO 'vendedor'; -- Dentro de la base de datos marketplace, tabla order (pedido)
-- Permitir lista basica de administracion
GRANt SELECT, INSERT, SHOW DATABASES, UPDATE, DELETE, ALTER, CREATE, DROP ON marketplace.* TO 'administrador'; -- Permite administrar generalmente un base de datos
```

## Tabla General de Permisos (Privilegios)

| Privilegio | Nivel de Aplicación | Descripción de lo que permite hacer |
| --- | --- | --- |
| **Privilegios de Datos (DML)** |  |  |
| `SELECT` | Tablas / Columnas | Leer o consultar registros de una tabla. |
| `INSERT` | Tablas / Columnas | Insertar nuevos registros en una tabla. |
| `UPDATE` | Tablas / Columnas | Modificar registros existentes. |
| `DELETE` | Tablas | Eliminar registros de una tabla. |
| `SHOW DATABASES` | Tablas / Columnas | Mostrar las bases de datos seleccionadas. |
| **Privilegios de Estructura (DDL)** |  |  |
| `CREATE` | Bases de datos / Tablas | Crear nuevas bases de datos o tablas. |
| `ALTER` | Tablas | Modificar la estructura de una tabla (añadir columnas, cambiar tipos). |
| `DROP` | Bases de datos / Tablas | Eliminar bases de datos o tablas completas. |
| `INDEX` | Tablas | Crear o eliminar índices en una tabla. |
| `CREATE VIEW` | Vistas | Crear nuevas vistas. |
| `SHOW VIEW` | Vistas | Ver el código fuente (consulta) de una vista. |
| **Privilegios de Ejecución** |  |  |
| `EXECUTE` | Procedimientos / Funciones | Ejecutar procedimientos almacenados y funciones. |
| `CREATE ROUTINE` | Procedimientos / Funciones | Crear rutinas (procedimientos o funciones). |
| `ALTER ROUTINE` | Procedimientos / Funciones | Modificar o eliminar rutinas existentes. |
| **Privilegios de Administración** |  |  |
| `ALL PRIVILEGES` | Global / Base de datos | Otorga **todos** los permisos disponibles (excepto `GRANT OPTION`). |
| `GRANT OPTION` | Global / Base de datos | Permite al usuario otorgar a otros los permisos que él mismo posee. |
| `CREATE USER` | Global | Crear, modificar, renombrar o eliminar usuarios de la base de datos. |
| `RELOAD` | Global | Usar la sentencia `FLUSH` (vaciar cachés, recargar privilegios). |
| `SHUTDOWN` | Global | Apagar el servidor de la base de datos. |
