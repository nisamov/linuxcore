# Fundamentos de Bases de Datos y Sistemas Gestores (SGBD)

## Conceptos Fundamentales

Base de Datos (BD): Colección estructurada, organizada y homogénea de datos interrelacionados que almacenan información relevante sobre un dominio específico, garantizando integridad, persistencia y accesibilidad.

**Sistema Gestor de Bases de Datos (SGBD / DBMS)**: Software especializado que actúa como interfaz entre la base de datos, los usuarios y las aplicaciones. Permite la definición, creación, mantenimiento, consulta y administración segura de los datos.

## Lenguajes de Definición y Manipulación de Datos (SQL)

El lenguaje SQL (Structured Query Language) se subdivide en sublenguajes según la naturaleza de sus operaciones:

## Data Definition Language (DDL)

Conjunto de sentencias orientadas a definir, modificar o destruir la estructura y esquema de los objetos de la base de datos.

```sql
/* DDL: Definición de esquemas y estructuras */

-- Gestión de bases de datos
CREATE DATABASE nombre_base_datos;
DROP DATABASE nombre_base_datos;

-- Gestión de objetos / tablas
CREATE TABLE nombre_tabla (
    id_columna INT NOT NULL,
    nombre VARCHAR(18) NOT NULL,
    PRIMARY KEY (id_columna)
);

RENAME TABLE nombre_original TO nombre_nuevo;

ALTER TABLE nombre_tabla DROP COLUMN columna1;
ALTER TABLE nombre_tabla MODIFY columna1 VARCHAR(100);
```

## Data Manipulation Language (DML)

Conjunto de instrucciones enfocadas en la inserción, modificación, eliminación y recuperación de los datos almacenados en las estructuras previa y técnicamente definidas.

```sql
/* DML: Manipulación y consulta de datos */

-- Recuperación de información
SELECT ALL columna1, columna2 FROM nombre_tabla;
SELECT DISTINCT columna1 FROM nombre_tabla;

-- Inserción de datos
INSERT INTO nombre_tabla (columna1, columna2) VALUES ('Valor1', 'Valor2');

-- Eliminación de registros
DELETE FROM nombre_tabla WHERE id = 4354;
```

### Arquitectura ANSI/SPARC (1975)

Estándar de arquitectura en tres niveles para lograr la independencia de los datos respecto a las aplicaciones que los consumen:

- Nivel Interno / Físico: Define cómo se almacenan físicamente los datos en los soportes de almacenamiento (estructuras de archivos, índices, punteros y métodos de acceso).
- Nivel Conceptual: Representa la estructura global de la base de datos completa de forma abstracta, definiendo entidades, atributos, relaciones y restricciones de integridad, de forma independiente del almacenamiento físico.
- Nivel Externo / Vistas: Estructura la forma en que diferentes usuarios o aplicaciones previsualizan la información, permitiendo vistas personalizadas y restringidas de la base de datos conceptual.

### Ventajas del Uso de un SGBD

 Abstracción de Datos y Visión: Ofrece niveles de abstracción adaptados a distintos perfiles de usuario, simplificando la interacción con la estructura interna.

- Control de Redundancia y Inconsistencia: Minimiza la duplicación de datos mediante reglas de normalización e integridad referencial.
- Seguridad y Privacidad: Implementa mecanismos de autenticación, autorización basada en roles y cifrado de datos sensibles.
- Control de Accesos Concurrentes: Garantiza el procesamiento transaccional seguro y multiusuario simultáneo mediante mecanismos de bloqueo y propiedades ACID.

### Modelos de Datos

- Modelo Jerárquico: Organiza los datos en una estructura de árbol invertido (Padre-Hijo). Un nodo hijo solo puede tener un único nodo padre, mientras que un nodo padre puede poseer múltiples nodos hijos.
- Modelo en Red: Evolución del modelo jerárquico que representa la información como nodos de registros interconectados mediante grafos. Permite relaciones de tipo muchos a muchos, donde un registro hijo puede enlazarse a múltiples registros padres.
- Modelo Relacional: Introducido por Edgar F. Codd en la década de 1970. Organiza la información en tablas (relaciones) compuestas por filas (tuplas) y columnas (atributos). Sus pilares son:
- Ausencia de tuplas duplicadas.
- Aplicación de técnicas de normalización para evitar redundancia.
- Identificación unívoca de registros mediante Claves Primarias (Primary Keys) e interconexión mediante Claves Foráneas (Foreign Keys).
- Homogeneidad de tipos de datos en cada columna.

### Modelo Orientado a Objetos

Integra los conceptos de la programación orientada a objetos (clases, herencia, encapsulamiento, métodos) directamente en el motor de persistencia de datos.
