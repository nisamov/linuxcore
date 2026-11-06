# Bucles: WHILE

El bucle `WHILE` permite ejecutar repetidamente un bloque de instrucciones **mientras una condición sea verdadera**.

La condición se comprueba antes de cada iteración. Por tanto, si inicialmente es falsa, el bloque no se ejecutará ninguna vez.

Es importante modificar las variables que intervienen en la condición para evitar crear un bucle infinito.

## Sintaxis general

```sql
WHILE condicion DO
    sentencias;
END WHILE;
```

- `WHILE`: inicia el bucle y establece la condición.
- `DO`: indica el comienzo del bloque de instrucciones.
- `END WHILE`: marca el final del bucle.

**Cuenta atrás**

Comienza en 10 y va decrementando el valor hasta llegar a 1.

```sql
DELIMITER //
SET @x = 10//
BEGIN NOT ATOMIC
    WHILE @x > 0 DO
        SELECT @x AS CUENTA_ATRAS;
        SET @x = @x - 1;
    END WHILE;
END//

DELIMITER ;
```

**Resultado:** se muestran los números del 10 al 1.

Cada `SELECT` genera su propio conjunto de resultados, por lo que se obtienen varias salidas en lugar de una única tabla.

**Acumulación de valores**

Un uso habitual de los bucles es realizar operaciones repetitivas, como sumar una serie de números.

En este caso, se utilizan dos variables:
- `i`: controla las iteraciones del bucle.
- `total`: almacena el resultado acumulado.

```sql
DELIMITER //

BEGIN NOT ATOMIC
    DECLARE i INT DEFAULT 1;
    DECLARE total INT DEFAULT 0;
    WHILE i <= 5 DO
        SET total = total + i;
        SET i = i + 1;
    END WHILE;
    SELECT total AS SUMA_1_A_5; -- 15
END//

DELIMITER ;
```

**Funcionamiento:**

1. Inicialmente, `i = 1` y `total = 0`.
2. Se suma el valor de `i` a `total`.
3. Se incrementa `i` en una unidad.
4. Se repite el proceso mientras `i` sea menor o igual que 5.
5. Al finalizar, se muestra el resultado acumulado.

Resultado:

```text
SUMA_1_A_5
-----------
15
```

# Bucles: FOR

El bucle `FOR` permite ejecutar un bloque de instrucciones recorriendo un rango numérico determinado.

A diferencia de `WHILE`, no es necesario incrementar o decrementar manualmente el contador: el propio bucle se encarga de actualizarlo en cada iteración.

Es especialmente útil cuando conocemos de antemano cuántas veces queremos repetir una operación.

## Sintaxis general

```sql
FOR variable IN inicio..fin DO
    sentencias;
END FOR;
```

- `FOR`: inicia el bucle.
- `variable`: contador que se utiliza durante las iteraciones.
- `IN`: indica el rango que se recorrerá.
- `inicio..fin`: establece los límites del recorrido.
- `DO`: comienza el bloque de instrucciones.
- `END FOR`: finaliza el bucle.

**Recorrido ascendente**

Recorre los números del 1 al 5, incrementando automáticamente el contador.

```sql
DELIMITER //

FOR i IN 1..5 DO
    SELECT i AS NUMERO;
END FOR//

DELIMITER ;
```
**Resultado:** 1, 2, 3, 4, 5.

**Recorrido descendente (REVERSE)**

La palabra clave `REVERSE` invierte el sentido del recorrido, haciendo que el contador disminuya automáticamente.

```sql
DELIMITER //

FOR i IN REVERSE 1..5 DO
    SELECT i AS NUMERO;
END FOR//

DELIMITER ;
```

**Resultado:** 5, 4, 3, 2, 1.
