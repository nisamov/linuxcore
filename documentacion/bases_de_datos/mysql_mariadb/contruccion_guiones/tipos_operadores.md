# Tipos de datos y operaciones

## Tipos de datos

- `SIGNED`: enteros con signo (positivos y negativos).
- `UNSIGNED`: enteros sin signo (solo positivos).
- `DECIMAL(n,d)`: `n` es el total de cifras y `d` cuántas son decimales. `DECIMAL(5,2)` admite hasta `999.99`.
- `CHAR`: texto (en columnas existe también `VARCHAR`, de longitud variable).
- `DATE`: fecha, formato `AAAA-MM-DD`.
- `DATETIME`: fecha y hora, formato `AAAA-MM-DD HH:MM:SS`.
- `TIME`: hora, formato `HH:MM:SS`.

## Conversión con CAST

Sintaxis: `CAST(valor AS tipo)`. Si el valor tiene más decimales de los que permite el tipo, se redondea.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SELECT CAST('3.14159' AS DECIMAL(5,2));   -- 3.14
    SELECT CAST('25' AS SIGNED);              -- 25
    SELECT CAST('2026-04-30' AS DATE);        -- 2026-04-30
END //
DELIMITER ;
```

## Cálculos

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @A = 10;
    SET @B = 7;
    SELECT @A + @B;     -- 17
    SELECT @A - @B;     -- 3
    SELECT @A * @B;     -- 70
    SELECT @A / @B;     -- 1.4286 (división con decimales)
    SELECT @A DIV @B;   -- 1 (división entera)
    SELECT @A MOD @B;   -- 3 (resto; equivale a @A % @B)
END //
DELIMITER ;
```

## Concatenación

Se usa `CONCAT`. Si algún valor es `NULL`, el resultado completo es `NULL`.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @NOM = 'EjemploNombre';
    SET @AP1 = 'ApEjemplo1';
    SET @AP2 = 'ApEjemplo2';
    SELECT CONCAT(@NOM, ' ', @AP1, ' ', @AP2) AS NOMBRE_COMPLETO;
    -- Variante con separador: ignora los valores NULL
    SELECT CONCAT_WS(' ', @NOM, @AP1, @AP2) AS NOMBRE_COMPLETO;
END //
DELIMITER ;
```
