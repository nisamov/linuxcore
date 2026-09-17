Por defecto MariaDB aplica una politica:
ON DELETE NO ACTION y ON UPDATE NO ACTION

- NO ACTION: No permite borrar la fila padre
- SET NULL: Intenta poner valor null en la clave foranea
- CASCADE: Elimina en cascada las filas que referencian a la eliminada
- RESTRICT: Sinónimo de NO ACTION (Mismo comportamiento)
- SET DEFAULT: Intentar poner valor por defecto en la columna

- Atomicity: una transacción debe ser indivisible.
- Consistency: una transacción debe hacer transitar la base de datos desde un estado inicial consistente a otro final consistente. - Definición de consistente: una base de datos está en un estado consistente cuando se respetan todas las restricciones de integridad impuestas sobre ella.
- Isolation (Aislamiento): permite a una transacción aislarse de cambios que puedan producir otras transacciones que se están ejecutando simultáneamente.
- Durability: Propiedad que garantiza que los cambios que produce una transacción una vez confirmada, se escriben de manera permanente en la base de datos.

En un SGBD transaccional existen dos sentencias para terminar una transacción:

COMMIT; Confirma los cambios, es decir, que se escriban de forma permanente en la BBDD.
ROLLBACK; Deshacer la transacción. Nada se escribe, como si nunca se hubiera ejecutado.
La configuración por defecto, en MariaDB es AUTOCOMMIT. Esto quiere decir que toda sentencia lleva detrás un COMMIT implícito.

Para desactivar autocommit en MariaDB hay dos formas:
 - A nivel de sesión (conexión): SET SESSION autocommit=off;
 - A nivel de servidor: SET GLOBAL autocommit=off;
 - A nivel de servidor permanente (resiste reinicios):
   /etc/mysql/mariadb.conf.d/50-server.cnf
   En sección [mysqld] escribir autocommit=off

Niveles de aislamiento de transacciones
Read uncommitted
Una transacción con este nivel de aislamiento verá los cambios efectuados por otras transacciones simultáneas todavía no confirmadas.

Read committed
Una transacción con este nivel de aislamiento no puede ver los cambios que realiza otra transacción concurrente todavía no confirmada.

Repeatable read
Una transacción con este nivel de aislamiento garantiza lecturas repetibles, aunque sigue siendo vulnerable a lecturas fantasma.

Serializable
Es el nivel de aislamiento más alto. El estándar ANSI/SQL lo define como uno que logra que la ejecución de varias transacciones concurrentes produzcan el mismo resultado que si se ejecutaran de forma secuencial (una detrás de otra).

Cómo establecer en MariaDB el nivel de aislamiento de una transacción

El nivel de aislamiento por defecto en MariaDB es REPEATABLE READ.

Se puede cambiar:
 - A nivel de conexión
    SET SESSION tx_isolation='READ-COMMITTED';
 - A nivel de servidor
    SET GLOBAL tx_isolation='READ-COMMITTED';
 - A nivel de servidor, de forma permanente
    En el fichero de configuración
        transaction-isolation='READ-COMMITTED'
 - Para la siguiente transacción
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

A partir de MariaDB 11, tx_isolation se llama transaction_isolation.

Tipos de control de concurrencia en una base de datos

Los diseñadores de sistemas gestores de bases de datos pueden optar a la hora de gestionar el acceso simultáneo de varios usuarios a los mismos datos por estas dos aproximaciones.

 - Visión pesimista: bloqueos
     Esos bloqueos pueden ser:
           - a nivel de fila (lo ideal)
           - a nivel de bloque
           - a nivel de tabla (lo peor)

           bloque: un bloque es un conjunto de filas adyacentes físicamente

 - Visión optimista: haciendo copias temporales de los datos afectados por ese acceso simultáneo

      Esas copias pueden ser:
           - a nivel de fila (lo ideal)
           - a nivel de bloque
           - a nivel de tabla (lo peor)