# Teoría General MariaDB-MySQL

## Políticas de Claves Foráneas (Foreign Key Actions)

Definen la acción que ejecuta el motor de base de datos en la tabla hija cuando se realiza un `DELETE` o `UPDATE` en la tabla padre.

* **NO ACTION**: (Por defecto en MariaDB/InnoDB). No permite borrar o modificar la fila padre si existen referencias en la tabla hija. En el estándar SQL pospone la comprobación hasta el final de la transacción.
* **RESTRICT**: Rechaza la operación de borrado o actualización en la tabla padre de forma inmediata. En MariaDB (motor InnoDB), **`RESTRICT` y `NO ACTION` son exactamente equivalentes**.
* **CASCADE**: Propaga el cambio. Si se elimina o actualiza la fila padre, se eliminan o actualizan automáticamente las filas hijas asociadas.
* **SET NULL**: Establece el valor de la clave foránea en la tabla hija a `NULL` cuando la fila padre es eliminada o modificada. *Requisito:* La columna en la tabla hija debe permitir valores nulos (`NULL`).
* **SET DEFAULT**: Intenta asignar el valor por defecto definido en la columna hija. *Nota:* El motor InnoDB **no soporta** actualmente esta acción y devolverá un error si se intenta definir.

## Propiedades ACID en Sistemas Transaccionales

Garantizan la fiabilidad de las transacciones en un Sistema Gestor de Bases de Datos (SGBD):

* **A - Atomicity (Atomicidad):** Principo de "todo o nada". La transacción es una unidad indivisible. Si falla alguna de sus sentencias, la base de datos revierte todos los cambios realizados hasta el momento mediante el *Undo Log*.
* **C - Consistency (Consistencia):** La transacción debe llevar la base de datos de un estado válido a otro estado válido, respetando todas las reglas de integridad (claves primarias, claves foráneas, restricciones `CHECK`, `UNIQUE`, `NOT NULL`).
* **I - Isolation (Aislamiento):** Asegura que la ejecución concurrente de transacciones resulte en un estado idéntico al que se obtendría si se ejecutaran secuencialmente. Evita interferencias entre transacciones simultáneas mediante bloqueos o MVCC.
* **D - Durability (Durabilidad):** Garantiza que una vez que una transacción ha sido confirmada (`COMMIT`), sus efectos persisten de forma permanente en el almacenamiento no volátil, incluso ante fallos del sistema o cortes de energía (apoyándose en el *Redo Log*).

## Gestión de Transacciones y Autocommit

### Sentencias Principales

* `BEGIN;` o `START TRANSACTION;`: Inicia un bloque de transacción explícito.
* `COMMIT;`: Confirma los cambios realizados en la transacción de forma permanente en disco.
* `ROLLBACK;`: Cancela la transacción y deshace todas las operaciones realizadas desde el inicio del bloque.
* `SAVEPOINT nombre;`: Establece un punto de restauración intermedio dentro de la transacción.
* `ROLLBACK TO SAVEPOINT nombre;`: Revierte las operaciones hasta el punto guardado sin cancelar toda la transacción.

### Configuración de Autocommit

Por defecto, MariaDB trabaja en modo `AUTOCOMMIT = 1` (ON). Cada sentencia individual (`INSERT`, `UPDATE`, `DELETE`) es tratada y confirmada implícitamente como una transacción independiente.

**Métodos para desactivar el AUTOCOMMIT (`autocommit = 0` / `OFF`):**

**A nivel de Sesión (afecta solo a la conexión actual):**
   ```sql
   SET SESSION autocommit = 0; -- o SET SESSION autocommit = OFF;
   ```
**A nivel Global (afecta a nuevas conexiones en ejecución):**
   ```sql
   SET GLOBAL autocommit = 0;
   ```
**A nivel de Servidor Persistente (resiste reinicios):**
   En el fichero de configuración `/etc/mysql/mariadb.conf.d/50-server.cnf`, dentro de la sección `[mysqld]`:
   ```ini
   [mysqld]
   autocommit = 0
   ```

## Problemas de Concurrencia y Niveles de Aislamiento

### Problemas o Anomalías de Concurrencia

* **Lectura Sucia (Dirty Read):** Ocurre cuando la Transacción A lee datos modificados por la Transacción B que aún no han sido confirmados (`COMMIT`). Si B realiza un `ROLLBACK`, los datos leídos por A nunca existieron realmente.
* **Lectura No Repetible (Non-repeatable Read):** Ocurre cuando la Transacción A lee una fila, la Transacción B modifica o elimina esa fila y realiza `COMMIT`. Si A vuelve a leer la misma fila, obtiene valores diferentes.
* **Lectura Fantasma (Phantom Read):** Ocurre cuando la Transacción A ejecuta una consulta con un rango de filas (ej. `WHERE edad > 18`), la Transacción B inserta nuevas filas que cumplen ese criterio y hace `COMMIT`. Si A repite la consulta, aparecen filas "fantasma" nuevas.

### Niveles de Aislamiento

Definen el grado de separación entre transacciones concurrentes.

| Nivel de Aislamiento | Lectura Sucia | Lectura No Repetible | Lectura Fantasma |
| :--- | :---: | :---: | :---: |
| **READ UNCOMMITTED** | Permite | Permite | Permite |
| **READ COMMITTED** | Previene | Permite | Permite |
| **REPEATABLE READ** *(Por defecto)* | Previene | Previene | Permite (en SQL estándar)* |
| **SERIALIZABLE** | Previene | Previene | Previene |

> En MariaDB (InnoDB), `REPEATABLE READ` evita también la mayoría de las lecturas fantasmas gracias al mecanismo de lecturas consistentes por fotografías (Snapshots/MVCC) y al *Next-Key Locking*.

### Modificación del Nivel de Aislamiento

*A partir de MariaDB 11, la variable de sistema pasa de llamarse `tx_isolation` a `transaction_isolation`.*

```sql
-- Para la siguiente transacción únicamente:
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- A nivel de Sesión:
SET SESSION transaction_isolation = 'READ-COMMITTED';
-- (Sintaxis antigua: SET SESSION tx_isolation = 'READ-COMMITTED';)

-- A nivel Global:
SET GLOBAL transaction_isolation = 'READ-COMMITTED';
```

En fichero de configuración `/etc/mysql/mariadb.conf.d/50-server.cnf`:
```ini
[mysqld]
transaction-isolation = READ-COMMITTED
```

## Tipos de Control de Concurrencia

Los SGBD aplican dos estrategias para permitir el acceso simultáneo a los datos:

### Bloqueos / Locking

Asume que las colisiones entre transacciones ocurrirán con frecuencia. Bloquea los recursos antes de operar sobre ellos.
* **Tipos de bloqueos:**
  * **Compartido (Shared / Read Lock):** Permite lecturas simultáneas, pero impide escrituras (`SELECT ... LOCK IN SHARE MODE`).
  * **Exclusivo (Exclusive / Write Lock):** Impide lectura y escritura a otras transacciones (`SELECT ... FOR UPDATE`).
* **Niveles de granularidad de bloqueo:**
  * **A nivel de Fila (Row-level):** La mejor opción (usada por InnoDB). Bloquea únicamente el registro afectado, maximizando el rendimiento concurrente.
  * **A nivel de Bloque/Página (Page-level):** Bloquea un conjunto de filas contiguas almacenadas en el mismo bloque físico de disco.
  * **A nivel de Tabla (Table-level):** La opción más restrictiva (usada por MyISAM). Bloquea toda la tabla; paraliza otros accesos concurrentes.

### MVCC - Control de Concurrencia Multiversión

Asume que las colisiones son raras. No aplica bloqueos de lectura; en su lugar, crea versiones/copias temporales (*snapshots*) de los datos en el *Undo Log* para que los lectores no bloqueen a los escritores ni los escritores a los lectores.
* **Granularidad de las copias:**
  * **A nivel de Fila:** Ideal. Mantiene el historial de cambios por registro.
  * **A nivel de Bloque / Tabla:** Menos eficiente al requerir copiar áreas mayores de datos.

## Archivo de Configuración de MariaDB (`50-server.cnf`) y Parámetros Principales

Ruta estándar en sistemas basados en Debian/Ubuntu: `/etc/mysql/mariadb.conf.d/50-server.cnf`  
Todas las variables principales del servidor se definen bajo la sección `[mysqld]`.

### Parámetros de Red y Conexión

```ini
[mysqld]
# Dirección IP en la que el servidor escucha peticiones.
# 127.0.0.1 = Solo conexiones locales (loopback).
# 0.0.0.0 = Escucha en todas las interfaces de red disponibles.
bind-address = 0.0.0.0

# Puerto TCP de escucha (por defecto 3306).
port = 3306

# Número máximo de conexiones simultáneas permitidas (por defecto suele ser 151).
max_connections = 100

# Desactiva la resolución DNS inversa para cada conexión entrante (mejora rendimiento de red).
skip-name-resolve = 1
```

### Parámetros de Codificación y Cotejo

```ini
[mysqld]
# Conjunto de caracteres por defecto (utf8mb4 permite soporte completo para Unicode, emojis, etc.).
character-set-server = utf8mb4

# Regla de ordenación/cotejo (collation) por defecto para el juego de caracteres.
collation-server = utf8mb4_unicode_ci
```

### Parámetros de Diagnóstico y Logs

```ini
[mysqld]
# Habilita el registro de consultas lentas (0 = Desactivado, 1 = Activado).
slow_query_log = 1

# Ruta del archivo donde se guardarán las consultas lentas.
slow_query_log_file = /var/log/mysql/mariadb-slow.log

# Tiempo límite en segundos. Consultas que tarden más de este tiempo se registran en el slow log.
long_query_time = 2

# Registra también las consultas que no utilicen índices, independientemente de su tiempo de ejecución.
log_queries_not_using_indexes = 1

# Ruta del log de errores general del servidor.
log_error = /var/log/mysql/error.log
```

### Parámetros de Rendimiento y Memoria (Engine InnoDB)

```ini
[mysqld]
# Tamaño de la memoria RAM asignada al pool de buffers de InnoDB para caché de datos e índices.
# Es el parámetro clave de rendimiento. En servidores dedicados suele asignarse un 50-70% de la RAM.
innodb_buffer_pool_size = 1G

# Tamaño máximo del paquete de datos o consulta SQL procesable en una sola sentencia.
max_allowed_packet = 64M

# Motor de almacenamiento predeterminado para las nuevas tablas.
default_storage_engine = InnoDB

# Directorio donde se almacenan físicamente los archivos de la base de datos.
datadir = /var/lib/mysql
```

## Tipos de Variables

* Globales: Afectan a todoas
* Sesion: Afectan al usuario conectado
* Dinámicas: Afectan sin tener que reiniciar (se hacen con el comando `SET`)
* Estáticas: Son las del fichero `50-server.cnf`, necesario el reinicio
* Estado: Son solo de consultas

[Más información](https://mariadb.com/docs/server/server-management/variables-and-modes/server-system-variables)

## Ruta de Almacenamiento de Bases de Datos
Ruta de almacenamiento: `/var/lib/mariadb/`
Ruta lógica: `datadir`
```sql
SHOW GLOBAL VARIABLES LIKE 'datadir';
```

`slow_squery_log` (on/off): variable que indica si se guardan o no las variables, por defecto en __off__
`slow_query_log_file` (/var/log/mysqñ): Almacenamiento de rutas delta
`long_query_time` (10s): tiempo de duracion de una consulta hasta que se introduce en rutas delta (todo lo que tarde mas de 10 segundos, va a `slow_query_log_file`)
