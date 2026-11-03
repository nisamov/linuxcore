# Bucles: WHILE

Repite el bloque mientras la condición sea verdadera. Hay que modificar la variable dentro del bucle, o no terminará nunca.

Forma general:

```sql
WHILE condicion DO
    sentencias;
END WHILE;
```

## Cuenta atrás

Cada `SELECT` genera su propia tabla de resultado, así que este ejemplo muestra 10.

```sql
DELIMITER //
SET @x = 10//
WHILE @x > 0 DO
    SET @x = @x - 1;
    SELECT @x;
END WHILE//
DELIMITER ;
```

## Acumular un resultado

Para ver un único resultado final, se acumula en una variable y se muestra al terminar.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    DECLARE i INT DEFAULT 1;
    DECLARE total INT DEFAULT 0;
    WHILE i <= 5 DO
        SET total = total + i;
        SET i = i + 1;
    END WHILE;
    SELECT total AS SUMA_1_A_5;   -- 15
END //
DELIMITER ;
```
