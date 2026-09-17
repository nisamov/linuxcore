# Gestión de Bases de Datos
## Crear una base de datos
```sql
CREATE DATABASE nombre_bd;
```
## Seleccionar una base de datos
```sql
USE nombre_bd;
```
## Eliminar una base de datos
```sql
DROP DATABASE nombre_bd;
```
## Listar bases de datos
```sql
SHOW DATABASES;
```
# Gestión de Usuarios y Permisos
## Crear usuario
```sql
CREATE USER 'usuario' IDENTIFIED BY 'clave';
```
## Conceder permisos básicos
```sql
GRANT USAGE ON *.* TO 'usuario'@'localhost' IDENTIFIED BY 'clave';
```
## Conceder todos los privilegios sobre una base de datos
```sql
GRANT ALL PRIVILEGES ON nombre_bd.* TO 'usuario'@'localhost';
```
## Actualizar permisos
```sql
FLUSH PRIVILEGES;
```
## Listar usuarios
```sql
SELECT User, Host FROM mysql.user;
```
Listar un usuario específico:
```sql
SELECT User, Host FROM mysql.user WHERE User = 'usuario';
```
## Ver privilegios de un usuario
```sql
SELECT GRANTEE, TABLE_SCHEMA, TABLE_NAME, PRIVILEGE_TYPE
FROM information_schema.table_privileges
WHERE GRANTEE = "'nombre_usuario'@'%'";
```
## Eliminar un usuario
```sql
DROP USER 'nombre_usuario'@'host';
```
# Gestión de Tablas
## Crear tablas
```sql
CREATE TABLE producto (
    nombre VARCHAR(128) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    stock INT NOT NULL,
    id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE pe_incluye_prod (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    PRIMARY KEY (id_pedido, id_producto)
);
```
## Mostrar tablas
```sql
SHOW TABLES IN nombre_bd;
```
## Información de columnas
```sql
DESCRIBE producto;
```
## Añadir una columna
```sql
ALTER TABLE producto ADD COLUMN cod_barras CHAR(13) NULL;
```
## Eliminar columna
```sql
ALTER TABLE producto DROP COLUMN cantidad;
```
## Renombrar columna
```sql
ALTER TABLE producto RENAME COLUMN stock TO cantidad;
```
## Modificar tipo de dato
```sql
ALTER TABLE producto MODIFY COLUMN cantidad DECIMAL(12,2) NOT NULL;
```
## Modificar tipo y nombre simultáneamente
```sql
ALTER TABLE producto CHANGE COLUMN cantidad stock DOUBLE NOT NULL;
```
## Renombrar tabla
```sql
ALTER TABLE producto RENAME TO productos;
```
## Mover tabla entre bases de datos
```sql
ALTER TABLE enciclopedia.productos
RENAME TO tienda.producto;
```
## Eliminar tabla
```sql
DROP TABLE producto;
```
# Claves y Restricciones
## Clave primaria
Eliminar clave primaria:
```sql
ALTER TABLE producto DROP PRIMARY KEY;
```
Añadir clave primaria:
```sql
ALTER TABLE producto ADD PRIMARY KEY (nombre, precio);
```
Clave primaria múltiple:
```sql
PRIMARY KEY (campo1, campo2);
```
## Clave única (UNIQUE)
```sql
ALTER TABLE producto ADD CONSTRAINT u_nombre UNIQUE (nombre);
```
## Clave foránea
```sql
ALTER TABLE producto
ADD CONSTRAINT fk_pp_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id);
```
## Eliminar una clave foránea
```sql
ALTER TABLE producto DROP FOREIGN KEY nombre_constraint;
```
Para conocer el nombre del constraint:
```sql
SHOW CREATE TABLE producto;
```
# Tipos de Datos en MariaDB
## Tipos numéricos
- Enteros (con opción UNSIGNED)
- BIGINT (64 bits)
- INT / INTEGER (32 bits)
- SMALLINT (16 bits)
- TINYINT (8 bits)
- Decimales
- Punto fijo:
- DECIMAL(m, n)

Ejemplo:
- DECIMAL(12,3) → máximo 12 dígitos, 3 decimales.

Punto flotante:
- FLOAT (32 bits)
- DOUBLE (64 bits)
## Tipos de fecha y hora
- DATE → YYYY-MM-DD
- TIME → HH:MM:SS.fffff
- DATETIME → YYYY-MM-DD HH:MM:SS.fffff
## Tipos de texto
- CHAR(n): longitud fija
- VARCHAR(n): longitud variable (hasta n)
- TEXT: hasta 65 535 caracteres
## Tipos binarios
- BLOB: hasta 65 535 bytes
# Comandos de Consulta sobre Metadatos
## Describir tabla
```sql
DESCRIBE nombre_bd.tabla;
```
## Mostrar definición completa de tabla
```sql
SHOW CREATE TABLE nombre_tabla;
```
## Función longitud de una cadena de texto
```sql
SELECT LENGTH('hola'); /*Devuelve 4*/
```
## A una función también puede pasársele como parámetro una columna
```sql
SELECT nombre, LENGTH(nombre) FROM plataforma; /*Muestra el nombre de cada plataforma y la longitud de ese nombre (en caracteres)*/
```
## Función valor absoluto
```sql
SELECT ABS(-5), ABS(3); /*Devuelve 5 y 3*/
```
Función raíz cuadrada
```sql
SELECT SQRT(4); /*Devuelve 2*/
```
## Función resta de fechas (devuelve el resultado en días)
```sql
SELECT DATEDIFF('2025-01-12', '2020-05-25') /*Devuelve la diferencia en días entre esas dos fechas*/
```
## Funcion ABS que los numeros negativos los pasa a positivos, si el digito es positivo, lo deja como está
```sql
SELECT ABS (-17);
```
## Consultas anidadas
Libro más reciente publicado
```sql
SELECT * FROM libro WHERE anyo=(SELECT MAX(anyo) FROM libro);
```
Libro más barato
```sql
SELECT * FROM libro WHERE precio=(SELECT MIN(precio) FROM libro);
```
## Alias
```sql
/*Opcion 1 | los alias solo son usables en el mismo comando en el que son designados*/
SELECT * FROM persona p WHERE NOT EXISTS (SELECT * FROM dirige d WHERE p.id_persona=d.id_persona);
/*Opcion 2*/
SELECT * FROM persona WHERE id_persona NOT IN (SELECT id_persona FROM dirige);
```
## Contar
```sql
/*Mostrar numero de peliculas que hay por país*/
SELECT pais, COUNT(*) FROM pelicula GROUP BY pais;
```
## Agrupar
```sql
/*Mostrar peliculas por pais, que sean posteriores al año 2000 de forma ascendente*/
SELECT pais, COUNT(*) FROM pelicula WHERE anyo>"2000" GROUP BY pais order by pais DESC;
```
## Revisar datos
```sql
/*Mostrar usuario, versión y tiempo actual de conexion del usuario actual*/
SELECT USER(), VERSION(), NOW();
```
## Contraseña
```sql
/*Cambiar clave de usuario*/
ALTER USER 'root'@'localhost' IDENTIFIED BY 'NuevaContraseña';
```
