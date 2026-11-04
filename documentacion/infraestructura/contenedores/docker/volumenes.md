# Volúmenes en Docker

Los volúmenes son el mecanismo oficial para **persistir datos** fuera del ciclo de vida del contenedor. Los gestiona Docker y se almacenan en `/var/lib/docker/volumes/` (Linux).

## Comandos de gestión

| Comando | Descripción |
| :--- | :--- |
| `docker volume create [nombre]` | Crea un nuevo volumen para persistir los datos. |
| `docker volume ls` | Lista todos los volúmenes que Docker está gestionando en el sistema. |
| `docker volume inspect [volumen]` | Muestra los detalles del volumen (ruta real en el anfitrión, driver, fecha). |
| `docker volume rm [volumen]` | Elimina un volumen específico, solo si no está siendo usado. |
| `docker volume prune` | Elimina todos los volúmenes que ya no están siendo usados por ningún contenedor. |

## Uso con `docker run`

```sh
# Crear el volumen y usarlo
docker volume create datos_db
docker run -d --name base_datos \
    -e MARIADB_ROOT_PASSWORD=ClaveSegura123 \
    -v datos_db:/var/lib/mysql \
    mariadb
```

Si el volumen no existe, `-v nombre:/ruta` lo crea automáticamente.

### Sintaxis `--mount` (más explícita)

```sh
docker run -d --name base_datos \
    --mount type=volume,source=datos_db,target=/var/lib/mysql \
    mariadb
```

### Solo lectura

```sh
docker run -d -v datos_web:/usr/share/nginx/html:ro nginx
```

## Comprobar la persistencia

```sh
# 1. Crear un contenedor con volumen y escribir un archivo
docker run --rm -v prueba:/datos alpine sh -c "echo 'hola' > /datos/fichero.txt"

# 2. El contenedor ya no existe (--rm), pero el volumen sí
docker volume ls

# 3. Un contenedor nuevo ve los mismos datos
docker run --rm -v prueba:/datos alpine cat /datos/fichero.txt
```

## Copias de seguridad y restauración

```sh
# Backup del volumen a un .tar.gz en el directorio actual
docker run --rm -v datos_db:/origen -v $(pwd):/backup alpine \
    tar czf /backup/backup_datos_db.tar.gz -C /origen .

# Restaurar en un volumen
docker run --rm -v datos_db:/destino -v $(pwd):/backup alpine \
    tar xzf /backup/backup_datos_db.tar.gz -C /destino
```

## Compartir un volumen entre contenedores

```sh
docker run -d --name app1 -v compartido:/datos alpine sleep infinity
docker run -d --name app2 -v compartido:/datos alpine sleep infinity
```

También con `--volumes-from`:

```sh
docker run -d --name app3 --volumes-from app1 alpine sleep infinity
```

## Volúmenes vs bind mounts vs tmpfs

| Característica | Volumen | Bind mount | tmpfs |
| :--- | :--- | :--- | :--- |
| Lo gestiona Docker | Sí | No | Sí |
| Ruta en el anfitrión | `/var/lib/docker/volumes/` | Cualquiera | Memoria RAM |
| Persiste tras apagar el equipo | Sí | Sí | **No** |
| Uso recomendado | Producción, bases de datos | Desarrollo | Datos temporales o sensibles |
| Ejemplo | `-v datos:/ruta` | `-v /home/user/web:/ruta` | `--tmpfs /ruta` |
