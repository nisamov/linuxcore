# Estructuras condicionales

Forma general:

```sql
IF condicion THEN
    sentencias;
ELSEIF otra_condicion THEN
    sentencias;
ELSE
    sentencias;
END IF;
```

Se evalúa de arriba abajo y se ejecuta solo la primera rama verdadera. Si una comparación incluye `NULL`, no es verdadera ni falsa, y se pasa a la siguiente rama (o al `ELSE`).

Como el `IF` contiene varios `;`, hay que cambiar el delimitador (ver [delimitador.md](delimitador.md)).

## Comparar dos números

```sql
SET @num1 = 1;
SET @num2 = 7;
SET @test = NULL;

DELIMITER //
IF @num1 = @num2 THEN
    SET @test = 'Salida1';              -- Son iguales
ELSEIF @num1 > @num2 THEN
    SET @test = 'Salida2';              -- El primero es mayor
ELSEIF @num1 < @num2 THEN
    SET @test = 'Salida3';              -- El primero es menor
ELSE
    SET @test = 'Salida por defecto';   -- Solo si alguno es NULL
END IF//
DELIMITER ;

SELECT @test;   -- Salida3
```

### Con NULL entra en el ELSE

```sql
SET @num1 = NULL;

DELIMITER //
IF @num1 = @num2 THEN
    SET @test = 'Salida1';
ELSEIF @num1 > @num2 THEN
    SET @test = 'Salida2';
ELSEIF @num1 < @num2 THEN
    SET @test = 'Salida3';
ELSE
    SET @test = 'Salida por defecto';
END IF//
DELIMITER ;

SELECT @test;   -- Salida por defecto
```

## Rango con OR

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @NUM = 245;
    IF @NUM < 100 OR @NUM > 200 THEN
        SELECT 'ERROR, EL NUMERO ESTÁ FUERA DE RANGO' AS RESULTADO;
    ELSE
        SELECT 'SE ENCUENTRA EN EL RANGO' AS RESULTADO;
    END IF;
END //
DELIMITER ;
```

Criterio: de 0 a 4 suspenso, de 5 a 7 bien, de 8 a 9 notable, 10 matrícula de honor. Esta versión solo sirve con notas enteras, porque una nota como 4.5 no entraría en ningún rango.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @NOTA = 4;
    IF @NOTA >= 0 AND @NOTA <= 4 THEN
        SELECT 'SUSPENSO' AS RESULTADO;
    ELSEIF @NOTA >= 5 AND @NOTA <= 7 THEN
        SELECT 'BIEN' AS RESULTADO;
    ELSEIF @NOTA >= 8 AND @NOTA <= 9 THEN
        SELECT 'NOTABLE' AS RESULTADO;
    ELSE
        SELECT 'MATRICULA DE HONOR' AS RESULTADO;
    END IF;
END //
DELIMITER ;
```

Como se entra en la primera condición verdadera, no hace falta repetir el límite inferior. Funciona también con decimales. `AS RESULTADO` pone nombre a la columna que muestra el `SELECT`.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @NOTA = 6.5;
    IF @NOTA < 5 THEN SELECT 'SUSPENSO' AS RESULTADO;
    ELSEIF @NOTA < 8 THEN SELECT 'BIEN' AS RESULTADO;
    ELSEIF @NOTA < 10 THEN SELECT 'NOTABLE' AS RESULTADO;
    ELSE SELECT 'MATRICULA DE HONOR' AS RESULTADO;
    END IF;
END //
DELIMITER ;
```
