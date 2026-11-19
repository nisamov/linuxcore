# Glosario de comandos de Docker

Esta guía reúne los comandos principales para gestionar contenedores, imágenes, redes y volúmenes. Los comandos que modifican el sistema pueden requerir permisos de administrador.

## Gestión de contenedores

| Comando | Descripción |
|---|---|
| `docker run imagen` | Crea e inicia un contenedor a partir de una imagen. Descarga la imagen si no existe localmente. |
| `docker ps` | Lista los contenedores en ejecución. |
| `docker ps -a` | Lista todos los contenedores, incluidos los detenidos. |
| `docker start contenedor` | Inicia un contenedor detenido. |
| `docker stop contenedor` | Detiene un contenedor en ejecución enviando una señal al proceso principal. |
| `docker rm contenedor` | Elimina un contenedor detenido. |
| `docker rm -f contenedor` | Fuerza la eliminación de un contenedor en ejecución. |
| `docker container prune` | Elimina todos los contenedores detenidos. Pide confirmación antes de borrar. |
| `docker logs contenedor` | Muestra los registros generados por el proceso del contenedor. |
| `docker inspect contenedor` | Muestra la configuración detallada del contenedor en formato JSON. |
| `docker exec -it contenedor comando` | Ejecuta un comando dentro de un contenedor en ejecución. |

### Opciones frecuentes de `docker run`

| Opción | Descripción |
|---|---|
| `-d`, `--detach` | Ejecuta el contenedor en segundo plano. |
| `--name nombre` | Asigna un nombre fácil de reconocer. |
| `--rm` | Elimina el contenedor automáticamente al detenerse. Es útil para pruebas temporales. |
| `-it` | Combina entrada estándar interactiva y pseudoterminal. |
| `-p puerto_host:puerto_contenedor` | Publica un puerto del contenedor en el anfitrión. |
| `--network red` | Conecta el contenedor a una red existente. |
| `-v origen:destino` | Monta un volumen o un directorio del anfitrión. |
| `-e CLAVE=valor` | Define una variable de entorno. |
| `--env-file ruta` | Lee variables de entorno desde un archivo. |
| `--restart política` | Define cuándo debe reiniciarse el contenedor. |

Las políticas `no`, `on-failure`, `unless-stopped` y `always` controlan el reinicio automático. `unless-stopped` evita reiniciar contenedores detenidos manualmente.

## Ejemplo de contenedor interactivo

El siguiente comando descarga Alpine si es necesario, crea un contenedor interactivo e inicia una shell:

```bash
sudo docker run -it --name laboratorio alpine sh
```

Dentro del contenedor se pueden ejecutar comandos como `ls`, `pwd`, `whoami` y `exit`. Cuando termina el proceso principal, el contenedor se detiene.

Para volver a una sesión existente:

```bash
sudo docker start laboratorio
sudo docker exec -it laboratorio sh
```

## Gestión de imágenes

| Comando | Descripción |
|---|---|
| `docker images` | Lista las imágenes disponibles localmente. También existe `docker image ls`. |
| `docker pull imagen:etiqueta` | Descarga una imagen desde un registro. |
| `docker rmi imagen` | Elimina una imagen que no esté utilizando ningún contenedor, aunque esté detenido. |
| `docker image prune -a` | Elimina todas las imágenes que no estén en uso. Puede liberar mucho espacio. |
| `docker build -t nombre:etiqueta ruta` | Construye una imagen desde un `Dockerfile`. |

El punto final indica el contexto de construcción:

```bash
sudo docker build -t mi-app:1.0 .
```

La opción `-t` asigna nombre y etiqueta a la imagen construida.

## Gestión de redes

Las redes personalizadas permiten aislar aplicaciones y resolver contenedores por nombre mediante DNS interno.

| Comando | Descripción |
|---|---|
| `docker network create nombre` | Crea una red bridge definida por el usuario. |
| `docker network ls` | Lista las redes disponibles. |
| `docker network inspect nombre` | Muestra la configuración y los contenedores conectados. |
| `docker network connect red contenedor` | Conecta un contenedor en ejecución a una red. |
| `docker network disconnect red contenedor` | Desconecta un contenedor de una red. |
| `docker network rm nombre` | Elimina una red sin contenedores conectados. |
| `docker network prune` | Elimina las redes que no estén en uso. |

Ejemplo de comunicación entre contenedores:

```bash
sudo docker network create red_app
sudo docker run -d --name db --network red_app mariadb
sudo docker run -it --rm --network red_app alpine ping -c 3 db
```

## Gestión de volúmenes

| Comando | Descripción |
|---|---|
| `docker volume create nombre` | Crea un volumen gestionado por Docker. |
| `docker volume ls` | Lista los volúmenes existentes. |
| `docker volume inspect nombre` | Muestra detalles, incluida la ubicación real en el anfitrión. |
| `docker volume rm nombre` | Elimina un volumen no utilizado. |
| `docker volume prune` | Elimina los volúmenes huérfanos que no estén en uso. |

Ejemplo:

```bash
sudo docker volume create datos_db
sudo docker run -d --name db \
  -e MARIADB_ROOT_PASSWORD=ClaveEjemplo \
  -v datos_db:/var/lib/mysql \
  mariadb
```

El valor anterior es ficticio y solo sirve para prácticas. En un entorno real se debe proporcionar el secreto mediante un mecanismo seguro y no incorporarlo al historial ni a un repositorio.

## Comprobación y diagnóstico

```bash
sudo docker ps -a
sudo docker inspect contenedor
sudo docker logs contenedor
sudo docker port contenedor
sudo docker stats
```

- `docker inspect` muestra configuración, red, variables y montajes.
- `docker logs` permite diagnosticar errores y mensajes de las aplicaciones.
- `docker port` indica las publicaciones de puertos configuradas.
- `docker stats` muestra uso actual de CPU, memoria y red.
