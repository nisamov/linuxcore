# Inserción de datos

La sentencia `INSERT` se utiliza para añadir nuevas filas a una tabla. MariaDB ofrece múltiples variantes para manejar inserciones masivas, conflictos de claves y copias de datos.

## Inserción básica

### Especificando las columnas

Es la forma más segura y recomendada, ya que el orden de los valores no depende de la estructura interna de la tabla. Si una columna se omite, MariaDB asignará su valor por defecto o `NULL`.

```sql
INSERT INTO producto (id, nombre, precio, stock) 
VALUES (1, 'Teclado Mecánico', 85.50, 20);
```

### Sin especificar columnas

Requiere que se proporcionen valores para **todas** las columnas de la tabla exactamente en el mismo orden en el que fueron definidas al crearla.

```sql
INSERT INTO producto 
VALUES (2, 'Ratón Inalámbrico', 25.99, 50, NULL);
```

### Inserción de múltiples filas (Bulk Insert)

Se pueden insertar varios registros en una sola sentencia separando los grupos de valores por comas. Esto es mucho más eficiente que hacer múltiples `INSERT` individuales.

```sql
INSERT INTO producto (id, nombre, precio, stock) VALUES 
(3, 'Monitor 24 pulgadas', 149.90, 15),
(4, 'Cable HDMI', 9.50, 100),
(5, 'Webcam 1080p', 45.00, 30);
```

## Inserción con funciones y valores especiales

Se pueden utilizar funciones integradas de MariaDB directamente en los valores a insertar.

```sql
INSERT INTO pedido (id, fecha_pedido, total, estado) 
VALUES (101, NOW(), 235.40, 'Pendiente');

-- Usando UUID o funciones matemáticas
INSERT INTO registro (codigo_sesion, valor_aleatorio)
VALUES (UUID(), RAND());
```

## Manejo de duplicados y conflictos

Cuando se intenta insertar una fila con un valor que ya existe en una clave primaria (`PRIMARY KEY`) o clave única (`UNIQUE`), el `INSERT` normal falla y devuelve un error. Para evitar que la ejecución se detenga, existen varias alternativas:

### 1. INSERT IGNORE

Si ocurre un error (como un duplicado), MariaDB ignora esa fila específica, emite un *warning* y continúa insertando el resto de las filas.

```sql
-- Si el id 3 ya existe, no hace nada y no da error fatal
INSERT IGNORE INTO producto (id, nombre, precio, stock) 
VALUES (3, 'Monitor 24 pulgadas', 155.00, 10);
```

### 2. INSERT ... ON DUPLICATE KEY UPDATE (Upsert)

Si la fila se inserta sin conflictos, actúa como un `INSERT` normal. Si hay un conflicto de clave primaria o única, actúa como un `UPDATE`, modificando la fila existente con los nuevos valores indicados.

```sql
INSERT INTO producto (id, nombre, precio, stock) 
VALUES (1, 'Teclado Mecánico', 90.00, 25)
ON DUPLICATE KEY UPDATE 
    precio = 90.00, 
    stock = stock + 25; -- Suma al stock existente
```

### 3. REPLACE INTO

Funciona de manera similar a `ON DUPLICATE KEY UPDATE`, pero su comportamiento interno es diferente: si encuentra un duplicado, **elimina (DELETE) la fila antigua por completo** y luego inserta la nueva.

*Nota: Esto puede tener efectos secundarios si hay claves foráneas con borrado en cascada (ON DELETE CASCADE).*

```sql
REPLACE INTO producto (id, nombre, precio, stock) 
VALUES (1, 'Teclado Mecánico v2', 95.00, 30);
```

## Inserción a partir de otras tablas

### INSERT ... SELECT

Permite insertar en una tabla el resultado de una consulta realizada sobre otra (u otras) tablas. Es muy útil para hacer copias de seguridad de datos, migraciones o tablas resumen.

```sql
-- Copiar todos los productos sin stock a una tabla de archivo
INSERT INTO productos_descatalogados (id_original, nombre_producto, ultimo_precio)
SELECT id, nombre, precio 
FROM producto 
WHERE stock = 0;
```

*Nota: En esta sintaxis no se usa la palabra clave `VALUES`.*

## Inserciones con SET

MariaDB soporta una sintaxis alternativa usando `SET` (similar a la sintaxis de `UPDATE`), que puede resultar más legible cuando se insertan pocos valores en tablas con muchas columnas.

```sql
INSERT INTO producto 
SET id = 6, 
    nombre = 'Alfombrilla XL', 
    precio = 15.20, 
    stock = 40;
```
