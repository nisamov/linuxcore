# Gestión de volúmenes (persistencia de datos)

Los contenedores son efímeros: al eliminarlos se pierde todo lo que escribieron en su sistema de ficheros. Para que los datos sobrevivan se montan almacenamientos externos al contenedor. Los dos mecanismos principales son los **bind mounts** y los **named volumes**.

## Bind Mounts

Es un mapeo directo de un fichero o directorio concreto de la máquina (host) a una ruta dentro del contenedor.

Permiten editar el código fuente en la máquina y ver los cambios reflejados al instante, sin reconstruir la imagen. Por eso son habituales en entornos de desarrollo.

Con Docker CLI:

```sh
docker run -d \
    --name mi-web \
    -v $(pwd)/html:/usr/local/apache2/htdocs/ \
    httpd:latest
```

> En un bind mount la ruta de origen debe ser una ruta absoluta (de ahí el uso de `$(pwd)`).

Con Docker Compose:

```yaml
services:
  web:
    image: httpd:latest
    volumes:
      - ./html:/usr/local/apache2/htdocs/
```

Para que el contenedor solo pueda leer los datos (sin modificarlos) se añade `:ro` al final:

```sh
-v $(pwd)/html:/usr/local/apache2/htdocs/:ro
```

Características:

- Si la ruta de origen no existe, Docker (con `-v`) la crea como directorio vacío.
- Lo que haya en la ruta del contenedor queda oculto por el contenido del host.
- Los permisos son los del sistema de ficheros del host, lo que puede dar problemas de usuario/propietario.

> Dependen de la estructura de carpetas del equipo. Si se mueve el proyecto o se ejecuta en otro servidor con rutas distintas, podría fallar. Son menos portables.

## Named Volumes

Es la forma estándar y recomendada para producción. En lugar de indicar una ruta del disco, se le da un nombre al volumen. Docker se encarga de crear una carpeta interna (`/var/lib/docker/volumes/`) y gestionarla, por lo que solo es necesario conocer su nombre.

Con Docker CLI:

```sh
# Docker crea el volumen 'db_data' si no existe
docker run -d \
    --name mi-base-datos \
    -e MYSQL_ROOT_PASSWORD=secreto \
    -v db_data:/var/lib/mysql \
    mysql:8.0
```

Con Docker Compose:

```yaml
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: secreto
    volumes:
      - db_data:/var/lib/mysql

# Declaración del volumen al final del archivo
volumes:
  db_data:
```

> Para saber la ruta de montaje de un volumen: `sudo docker volume inspect nombre_volumen`.

Ventajas:

- **Gestión**: Docker administra los permisos y la ubicación.
- **Portable**: funciona igual en Linux y en Windows, sin depender de rutas del host.
- **Persistente**: los datos se conservan aunque el contenedor se elimine.
- **Compartible**: varios contenedores pueden montar el mismo volumen.
- **Inicialización**: si el volumen está vacío, se rellena con el contenido que la imagen tenga en esa ruta.

Inconvenientes:

- Al estar en una carpeta interna de Docker, no es cómodo editar sus ficheros directamente desde el host.
