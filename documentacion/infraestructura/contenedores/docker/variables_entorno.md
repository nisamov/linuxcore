# Variables de Entorno en Docker

Las **variables de entorno** son pares `CLAVE=valor` disponibles dentro del contenedor para configurar la aplicación sin modificar la imagen (contraseñas, puertos, modos de ejecución, URLs de servicios). Permiten reutilizar la misma imagen en distintos entornos (desarrollo, pruebas, producción).

## Formas de definirlas

| Método | Dónde se define | Cuándo se aplica | Uso recomendado |
| :--- | :--- | :--- | :--- |
| **`ENV`** (Dockerfile) | En el `Dockerfile` | En la construcción **y** en la ejecución | Valores por defecto no sensibles |
| **`ARG`** (Dockerfile) | En el `Dockerfile` | Solo durante la construcción (`docker build`) | Versiones, parámetros de compilación |
| **`-e`** (`docker run`) | Línea de comandos | En la ejecución | Pocas variables, pruebas rápidas |
| **`--env-file`** (`docker run`) | Archivo `.env` | En la ejecución | Muchas variables, separar la configuración |
| **`environment`** (Compose) | `docker-compose.yaml` | En la ejecución | Aplicaciones multicontenedor |
| **`env_file`** (Compose) | Archivo `.env` | En la ejecución | Configuración externa en Compose |

## Con `docker run`

### Parámetro `-e`

Cada variable requiere su propio `-e`:

```sh
docker run -d --name base_datos \
  -e MARIADB_ROOT_PASSWORD=ClaveSegura123 \
  -e MARIADB_DATABASE=tienda \
  -e MARIADB_USER=usuario \
  -e MARIADB_PASSWORD=ClaveUsuario \
  mariadb
```

Si se indica solo el nombre (sin valor), Docker toma el valor de la variable del **anfitrión**:

```sh
export MI_VARIABLE="valor_del_host"
docker run --rm -e MI_VARIABLE alpine printenv MI_VARIABLE
```

### Parámetro `--env-file`

Crear un archivo `.env` donde cada línea tiene el formato `VARIABLE=valor` (sin comillas ni espacios alrededor del `=`):

```sh
# archivo: mariadb.env
MARIADB_ROOT_PASSWORD=ClaveSegura123
MARIADB_DATABASE=tienda
MARIADB_USER=usuario
MARIADB_PASSWORD=ClaveUsuario
```

```sh
docker run -d --name base_datos --env-file mariadb.env mariadb
```

> **Importante:** el archivo `.env` con contraseñas **nunca** debe subirse a un repositorio. Añadirlo a `.gitignore`.

## En el `Dockerfile`

### `ENV`: variables persistentes

```Dockerfile
FROM alpine
ENV NombreUsuario="UsuarioEjemplo"
ENV PUERTO=8080 MODO=produccion
CMD echo "Usuario: $NombreUsuario"
```

Estas variables quedan en la imagen y se pueden **sobrescribir** al crear el contenedor:

```sh
docker run --rm -e NombreUsuario="Otro" imagen
```

### `ARG`: variables solo de construcción

```Dockerfile
FROM alpine
ARG VERSION=1.0
RUN echo "Construyendo versión $VERSION"
```

```sh
docker build --build-arg VERSION=2.0 -t miapp .
```

### Diferencia `ENV` vs `ARG`

| Característica | `ENV` | `ARG` |
| :--- | :--- | :--- |
| Disponible al construir | Sí | Sí |
| Disponible en el contenedor en ejecución | Sí | **No** |
| Se puede cambiar al ejecutar | Sí (`-e`) | No |
| Se puede cambiar al construir | No directamente | Sí (`--build-arg`) |

## Con Docker Compose

```yaml
services:
  db:
    image: mariadb
    environment:
      MARIADB_ROOT_PASSWORD: ClaveSegura123
      MARIADB_DATABASE: tienda
    env_file:
      - mariadb.env
```

También se puede leer una variable del anfitrión o de un archivo `.env` situado junto al `docker-compose.yaml` con la sintaxis `${VARIABLE}`:

```yaml
    environment:
      MARIADB_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
```

## Comprobar las variables de un contenedor

```sh
# Ver todas las variables dentro del contenedor
docker exec [id_o_nombre] env

# Ver una variable concreta
docker exec [id_o_nombre] printenv MARIADB_DATABASE

# Ver las variables con las que se creó (JSON)
docker inspect --format '{{.Config.Env}}' [id_o_nombre]
```
