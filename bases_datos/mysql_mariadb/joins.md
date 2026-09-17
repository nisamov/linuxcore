# Uniones entre varias tablas

Combinación de tablas:
- Join (deben tener el mismo numero de columnas)
Unión de consultas:
- Select
- From
- Union

- INNER: Solo las que coinciden
- LEFT: Dar prioridad a la derecha
- RIGHT: Dar prioridad a la izquierda
- ON: Definir union entre clave principal y clave foranea
- FULL OUTER JOIN: Devuelve todas las filas de ambas tablas
- CROSS JOIN: Relaciones entre todas las tablas (Información cruzada)
- SELF JOIN: Consultarse a si misma la información

```sql
select usuario piso;
-- para juntarla
INNER JOIN tabla1.clave_principal tabla2.clave_foranea;
LEFT JOIN tabla2 ON tabla1.clave_principal 
```

```sql
--Ejemplo pruebas en practica
SELECT d.dep_no, d.dnombre, e.emp_no, e.apellido FROM departamentos d CROSS JOIN empleados e ON d.dep_no=e.dep_no;
```