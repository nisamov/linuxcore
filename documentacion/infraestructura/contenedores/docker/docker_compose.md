# Docker Compose

Herramienta para definir y ejecutar aplicaciones de **varios contenedores**. Usa un archivo YAML (`docker-compose.yaml` o `compose.yaml`) donde se describen los servicios, redes y volúmenes de la aplicación. Con un solo comando se levanta todo el entorno.

## Estructura básica

```yaml
services:        # Contenedores de la aplicación
  nombre_servicio:
    image: ...
volumes:         # Volúmenes con nombre
  ...
networks:        # Redes personalizadas
  ...
```

> El YAML usa **sangría con espacios** (nunca tabuladores).

## Directivas principales de un servicio

| Directiva | Equivalente en `docker run` | Descripción |
| :--- | :--- | :--- |
| `image` | `imagen` | Imagen a utilizar. |
| `build` | `docker build` | Ruta del contexto para construir la imagen desde un Dockerfile. |
| `container_name` | `--name` | Nombre del contenedor. |
| `ports` | `-p` | Mapeo de puertos `"host:contenedor"`. |
| `environment` | `-e` | Variables de entorno. |
| `env_file` | `--env-file` | Archivo con variables de entorno. |
| `volumes` | `-v` | Volúmenes o bind mounts. |
| `networks` | `--network` | Redes a las que se conecta. |
| `restart` | `--restart` | Política de reinicio. |
| `depends_on` | — | Orden de arranque entre servicios. |
| `command` | comando final | Sustituye el `CMD` de la imagen. |

## Ejemplo completo: WordPress + MariaDB

```yaml
services:
  db:
    image: mariadb
    container_name: wp_db
    restart: unless-stopped
    environment:
      MARIADB_ROOT_PASSWORD: ClaveRoot123
      MARIADB_DATABASE: wordpress
      MARIADB_USER: wpuser
      MARIADB_PASSWORD: ClaveWp123
    volumes:
      - datos_db:/var/lib/mysql
    networks:
      - red_wp

  web:
    image: wordpress
    container_name: wp_web
    restart: unless-stopped
    depends_on:
      - db
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: ClaveWp123
    volumes:
      - datos_web:/var/www/html
    networks:
      - red_wp

volumes:
  datos_db:
  datos_web:

networks:
  red_wp:
```

> `WORDPRESS_DB_HOST: db` funciona porque en una red definida por el usuario los servicios se resuelven por su **nombre**.

## Ejemplo: aplicación con Redis

**Redis** es una base de datos NoSQL en memoria (clave-valor), muy usada como caché.

```yaml
services:
  app:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: redis:alpine
    volumes:
      - datos_redis:/data

volumes:
  datos_redis:
```

## Comandos de Compose

| Comando | Descripción |
| :--- | :--- |
| `docker compose up` | Crea y arranca los servicios (en primer plano). |
| `docker compose up -d` | Igual, en segundo plano. |
| `docker compose up --build` | Reconstruye las imágenes antes de arrancar. |
| `docker compose down` | Detiene y elimina contenedores y redes. |
| `docker compose down -v` | Además elimina los **volúmenes** (se pierden los datos). |
| `docker compose ps` | Lista los contenedores del proyecto. |
| `docker compose logs -f [servicio]` | Muestra los logs en tiempo real. |
| `docker compose exec [servicio] [comando]` | Ejecuta un comando en un servicio en marcha. |
| `docker compose stop` / `start` / `restart` | Detiene, inicia o reinicia los servicios sin eliminarlos. |
| `docker compose pull` | Descarga las imágenes más recientes. |
| `docker compose config` | Valida el archivo y muestra la configuración final. |
