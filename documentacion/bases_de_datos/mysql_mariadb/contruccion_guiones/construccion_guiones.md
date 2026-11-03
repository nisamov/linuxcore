# Construcción de guiones: programación en bases de datos

## Nota sobre MariaDB y MySQL

Los bloques `BEGIN NOT ATOMIC ... END` y `CREATE OR REPLACE FUNCTION` son propios de MariaDB. En MySQL, el código procedimental solo se puede ejecutar dentro de procedimientos o funciones almacenadas, y para reemplazar una función se usa antes `DROP FUNCTION IF EXISTS nombre;`.

## Errores frecuentes

- Olvidar `DELIMITER ;` al final: el cliente seguirá esperando `//` y los siguientes comandos fallarán.
- Escribir `DELIMITER;` sin espacio: no se reconoce como comando.
- Usar `@` en variables locales de `DECLARE`, o declararlas fuera del principio del bloque.
- Escribir `ELSEID` en lugar de `ELSEIF`, o `CONTACT` en lugar de `CONCAT`.
- Olvidar el `;` después de una sentencia dentro del bloque o el `END IF;` final.
- Escribir comentarios `--TEXTO` sin espacio: en MariaDB el comentario de línea exige `-- TEXTO`.
- Dejar una función sin `BEGIN ... END` cuando lleva `DECLARE` o `IF`.
- Poner `READS` sin `SQL DATA`: la cláusula completa es `READS SQL DATA`.
