# Metadatos, variables de estado y caché de consultas

## Consultas sobre information_schema

```sql
-- Nombre y tipo de la tabla 'user' del esquema 'mysql'
SELECT TABLE_NAME, TABLE_TYPE
FROM information_schema.TABLES
WHERE TABLE_NAME = 'user' AND TABLE_SCHEMA = 'mysql';

-- Nombre, tabla y tipo de las columnas que empiezan por 'TIME_' en todas las bases de datos
-- El "\" hace que el "_" se interprete como carácter literal y no como comodín
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM information_schema.COLUMNS
WHERE COLUMN_NAME LIKE 'TIME\_%';

-- Número de tablas de cada base de datos
SELECT TABLE_SCHEMA AS base_de_datos, COUNT(*) AS numero_de_tablas
FROM information_schema.TABLES
GROUP BY TABLE_SCHEMA;

-- Listar las bases de datos
SELECT SCHEMA_NAME FROM information_schema.SCHEMATA;
```

## Variables y estado del servidor

```sql
-- Cambiar un parámetro
SET GLOBAL max_connections = 250;
SET SESSION wait_timeout = 600;

-- Consultar estado
SHOW GLOBAL STATUS LIKE 'Threads_connected';   -- conexiones abiertas
SHOW GLOBAL STATUS LIKE 'Com_select';          -- total de consultas SELECT procesadas
SHOW GLOBAL STATUS LIKE 'Uptime';              -- tiempo de actividad del servidor

-- Consultar variables
SHOW GLOBAL VARIABLES LIKE 'bind_address';     -- dirección de escucha
SHOW GLOBAL VARIABLES LIKE 'port';             -- puerto de escucha (por defecto 3306)
```

## Procesos activos

```sql
SHOW FULL PROCESSLIST;
DESCRIBE information_schema.PROCESSLIST;
```

## Caché de consultas (query cache)

```sql
-- 16 MB de caché
SET GLOBAL query_cache_size = 16777216;

-- Activarla a nivel global y de sesión
SET GLOBAL query_cache_type = 1;
SET SESSION query_cache_type = 1;

-- Comprobar
SHOW VARIABLES LIKE 'query_cache_type';
SHOW GLOBAL STATUS LIKE 'Qcache_hits';
SHOW GLOBAL STATUS LIKE 'Qcache_queries_in_cache';
```
