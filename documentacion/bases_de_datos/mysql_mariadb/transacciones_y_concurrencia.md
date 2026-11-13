# Transacciones y control de concurrencia

## Propiedades ACID

Garantizan la fiabilidad de las transacciones en un SGBD.

- **A, Atomicity (atomicidad)**: principio de "todo o nada". La transacción es una unidad indivisible; si falla alguna sentencia, se revierten todos los cambios mediante el *Undo Log*.
- **C, Consistency (consistencia)**: la transacción lleva la base de datos de un estado válido a otro válido, respetando las reglas de integridad (claves primarias, foráneas, `CHECK`, `UNIQUE`, `NOT NULL`).
- **I, Isolation (aislamiento)**: la ejecución concurrente de transacciones produce el mismo estado que si se ejecutaran secuencialmente, evitando interferencias mediante bloqueos o MVCC.
- **D, Durability (durabilidad)**: tras un `COMMIT`, los efectos persisten de forma permanente aunque haya fallos o cortes de energía (apoyándose en el *Redo Log*).

## Sentencias de transacción

- `BEGIN;` o `START TRANSACTION;`: inicia una transacción explícita.
- `COMMIT;`: confirma los cambios de forma permanente.
- `ROLLBACK;`: cancela la transacción y deshace todo desde el inicio.
- `SAVEPOINT nombre;`: crea un punto de restauración intermedio.
- `ROLLBACK TO SAVEPOINT nombre;`: revierte hasta ese punto sin cancelar toda la transacción.

## Autocommit

Por defecto MariaDB trabaja con `AUTOCOMMIT = 1`: cada sentencia (`INSERT`, `UPDATE`, `DELETE`) se confirma implícitamente como una transacción independiente.

Formas de desactivarlo:

```sql
-- Solo en la sesión actual
SET SESSION autocommit = 0;

-- Global (afecta a las conexiones nuevas)
SET GLOBAL autocommit = 0;
```

De forma persistente, en `/etc/mysql/mariadb.conf.d/50-server.cnf`:

```ini
[mysqld]
autocommit = 0
```

## Problemas de concurrencia

- **Lectura sucia (dirty read)**: la transacción A lee datos modificados por B que aún no tienen `COMMIT`. Si B hace `ROLLBACK`, A ha leído datos que nunca existieron.
- **Lectura no repetible (non-repeatable read)**: A lee una fila, B la modifica o elimina y hace `COMMIT`; si A la vuelve a leer, obtiene valores distintos.
- **Lectura fantasma (phantom read)**: A ejecuta una consulta sobre un rango (por ejemplo `WHERE edad > 18`), B inserta filas que cumplen el criterio y hace `COMMIT`; si A repite la consulta, aparecen filas nuevas.

## Niveles de aislamiento

| Nivel | Lectura sucia | Lectura no repetible | Lectura fantasma |
| :--- | :---: | :---: | :---: |
| READ UNCOMMITTED | Permite | Permite | Permite |
| READ COMMITTED | Previene | Permite | Permite |
| REPEATABLE READ (por defecto) | Previene | Previene | Permite en SQL estándar |
| SERIALIZABLE | Previene | Previene | Previene |

En MariaDB (InnoDB), `REPEATABLE READ` evita también la mayoría de las lecturas fantasma gracias a las lecturas consistentes por snapshots (MVCC) y al *Next-Key Locking*.

### Cambiar el nivel de aislamiento

A partir de MariaDB 11, la variable `tx_isolation` pasa a llamarse `transaction_isolation`.

```sql
-- Solo para la siguiente transacción
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- A nivel de sesión
SET SESSION transaction_isolation = 'READ-COMMITTED';
-- Sintaxis antigua: SET SESSION tx_isolation = 'READ-COMMITTED';

-- A nivel global
SET GLOBAL transaction_isolation = 'READ-COMMITTED';
```

De forma persistente, en `50-server.cnf`:

```ini
[mysqld]
transaction-isolation = READ-COMMITTED
```

## Estrategias de control de concurrencia

### Bloqueos (locking)

Asume que las colisiones serán frecuentes, así que bloquea los recursos antes de operar con ellos.

Tipos de bloqueo:

- **Compartido (shared / read lock)**: permite lecturas simultáneas pero impide escrituras. `SELECT ... LOCK IN SHARE MODE`.
- **Exclusivo (exclusive / write lock)**: impide lectura y escritura a otras transacciones. `SELECT ... FOR UPDATE`.

Granularidad:

- **Fila (row-level)**: la mejor opción, la usa InnoDB. Bloquea solo el registro afectado y maximiza la concurrencia.
- **Bloque o página (page-level)**: bloquea filas contiguas almacenadas en el mismo bloque físico.
- **Tabla (table-level)**: la más restrictiva, la usa MyISAM. Paraliza el resto de accesos concurrentes.

### MVCC (control de concurrencia multiversión)

Asume que las colisiones son raras. No aplica bloqueos de lectura: crea versiones temporales (*snapshots*) de los datos en el *Undo Log*, de modo que los lectores no bloquean a los escritores ni al revés.

- **A nivel de fila**: ideal, mantiene el historial de cambios por registro.
- **A nivel de bloque o tabla**: menos eficiente, porque obliga a copiar áreas mayores.
