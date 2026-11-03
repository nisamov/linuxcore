# El delimitador

El cliente termina cada sentencia al encontrar `;`. Un bloque (`BEGIN`, `IF`, `WHILE`, una función) contiene varios `;` y se cortaría a la mitad, así que se cambia el delimitador mientras se escribe el bloque y se restaura al final.

* Las líneas sin sangría (fuera del bloque) terminan con el delimitador `//`.
* Las líneas con sangría (dentro del bloque) terminan con `;`.
* Al terminar se restaura con `DELIMITER ;` (con un espacio entre `DELIMITER` y `;`).

## Bloque BEGIN NOT ATOMIC

Permite ejecutar varias sentencias como un bloque sin crear antes un procedimiento o una función.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SELECT 'Hola' AS SALUDO;
    SELECT 'Adiós' AS SALUDO;
END //
DELIMITER ;
```

## Sentencias fuera de un bloque

Las sentencias sueltas, como un `SET` o un `SELECT`, no necesitan cambiar el delimitador.

```sql
SET @a = 2026;
SELECT @a;
```

## IF con delimitador

Cuando el `IF` va suelto (sin `BEGIN NOT ATOMIC`), cada línea sin sangría termina en `//`, incluido el `END IF`. Es bisiesto si es divisible entre 4 y no entre 100, o si es divisible entre 400.

```sql
DELIMITER //
SET @a = 2026//
IF (@a % 4 = 0 AND @a % 100 != 0) OR (@a % 400 = 0) THEN
    SELECT 'Bisiesto' AS RESULTADO;
ELSE
    SELECT 'No Bisiesto' AS RESULTADO;
END IF//
DELIMITER ;
```

## WHILE con delimitador

```sql
DELIMITER //
SET @x = 10//
WHILE @x > 0 DO
    SET @x = @x - 1;
    SELECT @x;
END WHILE//
DELIMITER ;
```

## Función con delimitador

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION suma(x INT, y INT) RETURNS INT
BEGIN
    RETURN x + y;
END//
DELIMITER ;

SELECT suma(3, 4);   -- 7
```
