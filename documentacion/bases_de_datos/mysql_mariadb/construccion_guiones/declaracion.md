# Declaración de variables

Hay dos tipos de variables: las de sesión, que empiezan por `@`, y las locales, que se declaran con `DECLARE` dentro de un bloque.

## Variables de sesión

Empiezan por `@`, no se declaran ni llevan tipo (lo toma del valor asignado) y viven mientras dure la conexión. Se crean y modifican con `SET`.

```sql
-- Almacenar información en memoria
SET @nombre = 'NombreUsuario';   -- Texto (entre comillas simples)
SET @digito = 1234567890;        -- Entero
SET @decimal = 1.89;             -- Número con decimales (punto, no coma)
SET @fecha = '2026-04-30';       -- Fecha en formato AAAA-MM-DD

-- Mostrar por consola el contenido almacenado
SELECT @nombre;
SELECT @nombre, @digito, @decimal, @fecha;
```

### Cambiar el valor

Se puede usar el propio valor de la variable. `NULL` significa "sin valor".

```sql
SET @digito = @digito + 3;
SET @fecha = NULL;
SELECT @digito, @fecha;
```

### Dentro de un bloque

```sql
DELIMITER //
BEGIN NOT ATOMIC
    SET @nombre = 'usuario1';
    SET @anyos = '2342';
    SET @float = 1.89;          -- Número flotante (decimales)
    SET @fecha = '2002-04-03';  -- Año-Mes-Día
    SELECT @nombre, @anyos, @float, @fecha;
END //
DELIMITER ;
```

Se llaman de sesión porque siguen existiendo tras terminar el bloque, pero desaparecen al cerrar la conexión.

### Variables preparadas para los condicionales

```sql
SET @num1 = 1;
SET @num2 = 7;
SET @test = NULL;
```

## Variables locales

Se declaran con `DECLARE`, sin arroba, al principio del bloque, indicando el tipo. Solo existen dentro del `BEGIN ... END` donde se declaran. Se les puede dar un valor inicial con `DEFAULT`.

```sql
DELIMITER //
BEGIN NOT ATOMIC
    DECLARE PRECIO DECIMAL(6,2) DEFAULT 50.30;
    DECLARE UNIDADES INT DEFAULT 4;
    SELECT PRECIO * UNIDADES AS TOTAL;   -- 201.20
END //
DELIMITER ;
```

Fuera del bloque, `PRECIO` y `UNIDADES` ya no existen. Los tipos disponibles están en [tipos_y_operaciones.md](tipos_y_operaciones.md).

## Diferencias entre ambos tipos

- Sesión: lleva `@`, no se declara, no lleva tipo y dura toda la conexión.
- Local: no lleva `@`, se declara con `DECLARE` y tipo, y solo vive dentro de su bloque.
