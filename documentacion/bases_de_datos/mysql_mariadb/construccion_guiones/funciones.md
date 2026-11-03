# Funciones

Una función recibe parámetros, devuelve un único valor con `RETURN` y se usa dentro de cualquier consulta.

## Conceptos

* `RETURNS tipo` indica el tipo del valor devuelto.
* Si lleva `DECLARE`, `IF` u otras sentencias, el cuerpo va entre `BEGIN` y `END`.
* `DETERMINISTIC` indica que con los mismos parámetros siempre devuelve el mismo resultado.
* `READS SQL DATA` indica que lee datos de tablas sin modificarlos.
* `CREATE OR REPLACE` es propio de MariaDB; en MySQL se usa antes `DROP FUNCTION IF EXISTS nombre;`.
* Se define primero y se llama después.

## Función suma

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION suma(x INT, y INT) RETURNS INT
BEGIN
    RETURN x + y;
END//
DELIMITER ;
```

### Llamadas

Se puede llamar en un `SELECT`, guardando el resultado en una variable o anidando funciones.

```sql
SELECT suma(15, 2);                -- 17
SET @resultado = suma(15, -5);     -- 10
SELECT @resultado;
SELECT suma(suma(10, 5), 15);      -- 30
```

## Función esBisiesto

Un año es bisiesto si es divisible entre 4 y no entre 100, o si es divisible entre 400.

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION esBisiesto(anyo INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;      -- Variable local (sin @)
    IF (anyo % 4 = 0 AND anyo % 100 != 0) OR (anyo % 400 = 0) THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;
    RETURN resultado;
END//
DELIMITER ;
```

```sql
SELECT esBisiesto(2024);   -- 1 (TRUE)
SELECT esBisiesto(1900);   -- 0 (FALSE): divisible entre 100 pero no entre 400
SELECT esBisiesto(2000);   -- 1 (TRUE)
SELECT esBisiesto(2026);   -- 0 (FALSE)
```

## Función esDivisible

Si el resto de la división es cero, el primer número es divisible entre el segundo. Con divisor 0 el resto es `NULL` y la función devuelve `FALSE`.

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION esDivisible(digit INT, digit2 INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado2 BOOLEAN;
    IF (digit % digit2 = 0) THEN
        SET resultado2 = TRUE;
    ELSE
        SET resultado2 = FALSE;
    END IF;
    RETURN resultado2;
END//
DELIMITER ;
```

### Comprobación de llamadas

```sql
SELECT esDivisible(4, 2);     -- TRUE
SELECT esDivisible(2, 2);     -- TRUE
SELECT esDivisible(15, -3);   -- TRUE
SELECT esDivisible(8, 3);     -- FALSE
```

## Función hayHuecos

Función que consulta una tabla. Si hay menos filas que el id máximo, falta algún id. `SELECT ... INTO` guarda el resultado de la consulta en variables locales, y `IFNULL` evita un `NULL` cuando la tabla está vacía.

Necesita la tabla `bd_juego.plataforma` con la columna `id_plataforma`. Para probarla:

```sql
CREATE DATABASE IF NOT EXISTS bd_juego;
CREATE TABLE IF NOT EXISTS bd_juego.plataforma (
    id_plataforma INT PRIMARY KEY,
    nombre VARCHAR(50)
);
INSERT INTO bd_juego.plataforma VALUES (1, 'PC'), (2, 'PS5'), (4, 'Switch');
```

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION hayHuecos() RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE v_contador INT DEFAULT 0;
    DECLARE v_maxid INT DEFAULT 0;
    SELECT COUNT(*), IFNULL(MAX(id_plataforma), 0)
      INTO v_contador, v_maxid
      FROM bd_juego.plataforma;
    RETURN v_contador < v_maxid;
END//
DELIMITER ;
```

```sql
SELECT hayHuecos();   -- 1 con los datos de prueba (3 filas, id máximo 4)
```
