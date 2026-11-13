# Fundamentos de Bases de Datos y SGBD

## Conceptos fundamentales

**Base de Datos (BD)**: colección estructurada, organizada y homogénea de datos interrelacionados que almacenan información relevante sobre un dominio específico, garantizando integridad, persistencia y accesibilidad.

**Sistema Gestor de Bases de Datos (SGBD / DBMS)**: software especializado que actúa como interfaz entre la base de datos, los usuarios y las aplicaciones. Permite la definición, creación, mantenimiento, consulta y administración segura de los datos.

## Arquitectura ANSI/SPARC (1975)

Arquitectura en tres niveles para lograr la independencia de los datos respecto a las aplicaciones que los consumen:

- **Nivel interno / físico**: cómo se almacenan físicamente los datos (estructuras de archivos, índices, punteros y métodos de acceso).
- **Nivel conceptual**: estructura global de la base de datos de forma abstracta (entidades, atributos, relaciones y restricciones de integridad), independiente del almacenamiento físico.
- **Nivel externo / vistas**: cómo cada usuario o aplicación ve la información, mediante vistas personalizadas y restringidas del nivel conceptual.

## Ventajas del uso de un SGBD

- **Abstracción de datos**: niveles de abstracción adaptados a distintos perfiles de usuario, que simplifican la interacción con la estructura interna.
- **Control de redundancia e inconsistencia**: minimiza la duplicación mediante normalización e integridad referencial.
- **Seguridad y privacidad**: autenticación, autorización basada en roles y cifrado de datos sensibles.
- **Control de accesos concurrentes**: procesamiento transaccional seguro y multiusuario mediante bloqueos y propiedades ACID.

## Modelos de datos

- **Jerárquico**: estructura de árbol invertido (padre-hijo). Un hijo solo tiene un padre; un padre puede tener varios hijos.
- **En red**: evolución del jerárquico. Representa la información como registros interconectados en forma de grafo y permite relaciones muchos a muchos (un hijo puede tener varios padres).
- **Relacional**: introducido por Edgar F. Codd en la década de 1970. Organiza la información en tablas (relaciones) formadas por filas (tuplas) y columnas (atributos). Sus pilares son:
  - Ausencia de tuplas duplicadas.
  - Normalización para evitar redundancia.
  - Identificación unívoca de registros mediante claves primarias e interconexión mediante claves foráneas.
  - Homogeneidad de tipos de datos en cada columna.
- **Orientado a objetos**: integra conceptos de la programación orientada a objetos (clases, herencia, encapsulamiento, métodos) directamente en el motor de persistencia.

## Sublenguajes de SQL

SQL (Structured Query Language) se divide según la naturaleza de sus operaciones.

### DDL (Data Definition Language)

Define, modifica o destruye la estructura y el esquema de los objetos de la base de datos.

```sql
-- Gestión de bases de datos
CREATE DATABASE nombre_base_datos;
DROP DATABASE nombre_base_datos;

-- Gestión de tablas
CREATE TABLE nombre_tabla (
    id_columna INT NOT NULL,
    nombre VARCHAR(18) NOT NULL,
    PRIMARY KEY (id_columna)
);

RENAME TABLE nombre_original TO nombre_nuevo;

ALTER TABLE nombre_tabla DROP COLUMN columna1;
ALTER TABLE nombre_tabla MODIFY columna1 VARCHAR(100);
```

### DML (Data Manipulation Language)

Inserta, modifica, elimina y recupera los datos almacenados en las estructuras ya definidas.

```sql
-- Recuperación de información
SELECT ALL columna1, columna2 FROM nombre_tabla;
SELECT DISTINCT columna1 FROM nombre_tabla;

-- Inserción de datos
INSERT INTO nombre_tabla (columna1, columna2) VALUES ('Valor1', 'Valor2');

-- Eliminación de registros
DELETE FROM nombre_tabla WHERE id = 4354;
```
