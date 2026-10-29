# Contenedorización de Aplicaciones en Docker

Docker es una plataforma de código abierto que automatiza el despliegue de aplicaciones dentro de **contenedores software**. A diferencia de las máquinas virtuales tradicionales, Docker utiliza el kernel del sistema operativo anfitrión para aislar procesos, lo que lo hace extremadamente ligero y rápido.

- **Imagen:** paquete estático e inmutable (solo lectura) que contiene todo lo necesario para ejecutar una aplicación: código, dependencias, librerías y configuración del sistema. Es el "plano de construcción" o molde.
- **Contenedor:** instancia aislada en ejecución creada a partir de una imagen. Añade una capa ligera de lectura y escritura sobre la imagen para procesar datos en tiempo de ejecución.

- **redis** es una base de datos NoSQL.

## Arquitectura y conceptos clave

### Los pilares del ecosistema

| Componente | Definición técnica | Analogía |
| :--- | :--- | :--- |
| **Imagen** | Plantilla de solo lectura con las instrucciones para crear un contenedor. Incluye el código de la aplicación, bibliotecas, dependencias y configuraciones. Se construye a partir de un `Dockerfile` o se descarga de un registro como Docker Hub. | La receta o el molde |
| **Contenedor** | Instancia ejecutable de una imagen. Permite crear, iniciar, detener, mover y eliminar contenedores. Está aislado del sistema anfitrión y de otros contenedores. | El plato cocinado |
| **Dockerfile** | Archivo de texto con la serie de instrucciones que Docker sigue para construir una imagen automáticamente. | Los pasos a seguir |
| **Registry** | Servicio de almacenamiento y distribución de imágenes (Docker Hub, GHCR). | La estantería de recetas |
| **Docker Hub** | Registry público por defecto: de aquí se descargan las imágenes que no se encuentran en local. | La red de contenedores |
| **Volumen** | Mecanismo de persistencia de datos fuera del ciclo de vida del contenedor. Los gestiona Docker y se almacenan en una parte del sistema de archivos del anfitrión. Son esenciales para bases de datos, ya que los datos dentro del contenedor se pierden si este se elimina. | El almacén externo |
| **Docker Compose** | Herramienta para definir y ejecutar aplicaciones de varios contenedores. Usa un archivo YAML (`docker-compose.yaml`) para configurar los servicios, redes y volúmenes de la aplicación. | La herramienta de montaje |

### ¿Cómo funciona por debajo? (nivel kernel)

Docker utiliza características nativas del **kernel de Linux** para crear el aislamiento:

- **Namespaces:** aíslan lo que el contenedor puede "ver" (red, procesos, usuarios, puntos de montaje).
- **Control Groups (cgroups):** limitan cuántos recursos puede "usar" (CPU, RAM, E/S).
- **Union File Systems (UnionFS):** permiten crear las capas de las imágenes de forma eficiente mediante el sistema de *copy-on-write*.

## Redes y persistencia

### Gestión de puertos

Los contenedores están aislados de la red del anfitrión por defecto. Para exponerlos se usa el mapeo de puertos:

```sh
docker run -p [puerto_host]:[puerto_contenedor] imagen
```

> **Ejemplo:** `-p 8080:80` significa que al entrar a `localhost:8080` en el navegador, Docker redirige el tráfico al puerto `80` interno del contenedor.

### Persistencia de datos

Los contenedores son **efímeros**: si el contenedor se elimina, los datos generados dentro se pierden. Docker ofrece tres mecanismos de almacenamiento:

| Mecanismo | Dónde se almacena | Uso recomendado |
| :--- | :--- | :--- |
| **Volúmenes** (*volumes*) | Zona del disco administrada por Docker (`/var/lib/docker/volumes/` en Linux). | Producción. Opción oficial recomendada: independiente del sistema anfitrión, segura y fácil de respaldar. |
| **Montajes de enlace** (*bind mounts*) | Carpeta o archivo concreto del anfitrión vinculado a una ruta del contenedor. | Desarrollo. Dependen de la estructura de archivos del anfitrión, ideales para compartir código en tiempo real. |
| **Montajes en memoria** (*tmpfs mounts*) | Solo en la RAM del anfitrión (no en disco). | Información sensible o archivos temporales. No persisten tras apagar el equipo, pero ofrecen máxima velocidad y seguridad. |

## Parámetros y argumentos de `docker run`

| Parámetro | Descripción |
| :--- | :--- |
| `-d`, `--detach` | Ejecuta el contenedor en segundo plano e imprime su ID. Esencial para servicios de larga duración (servidores web, bases de datos). |
| `--name [nombre]` | Asigna un nombre personalizado. Si no se indica, Docker genera uno aleatorio. |
| `--rm` | Elimina el contenedor automáticamente cuando se detiene. Útil para contenedores temporales o pruebas y para mantener el sistema limpio. |
| `-it` | Combinación de `-i` (`--interactive`) y `-t` (`--tty`): conecta la terminal al contenedor para interactuar con él. Perfecto para ejecutar una shell dentro de un contenedor. |
| `-p`, `--publish [puerto_host:puerto_contenedor]` | Publica un puerto del contenedor en el anfitrión, haciendo que los servicios del contenedor sean accesibles desde la red local. |
| `--network [nombre_red]` | Conecta el contenedor a una red específica. Permite que los contenedores se comuniquen entre sí usando sus nombres (la red debe crearse antes). |
| `-v`, `--volume [origen:destino]` | Monta un volumen o un directorio local dentro del contenedor. Es la forma principal de hacer que los datos persistan más allá del ciclo de vida del contenedor. |
| `-e`, `--env [VARIABLE=valor]` | Establece una variable de entorno dentro del contenedor (contraseñas y otros parámetros). Cada variable requiere su propio `-e`. |
| `--env-file [ruta_archivo]` | Lee un archivo donde cada línea tiene el formato `VARIABLE=valor` y establece las variables con su contenido. |
| `--restart [política]` | Define qué hace Docker si el contenedor se detiene (ver políticas abajo). |

### Ejemplos de `-v`

```sh
# Volumen gestionado por Docker
sudo docker run -v datos_db:/var/lib/mysql mariadb

# Directorio local del anfitrión (bind mount)
sudo docker run -v /ruta/en/equipo:/usr/share/nginx/html nginx
```

### Políticas de `--restart`

| Política | Comportamiento |
| :--- | :--- |
| `no` | Por defecto. No reinicia el contenedor. |
| `on-failure` | Reinicia solo si finaliza con error. |
| `unless-stopped` | Reinicia siempre, a menos que haya sido detenido manualmente. |
| `always` | Reinicia siempre; también al arrancar el demonio de Docker, aunque se hubiera detenido a mano. |

### Mantener un contenedor activo

`sleep infinity` permite que un contenedor se mantenga activo aunque no tenga ninguna tarea en primer plano en ejecución (evita que se cierre al terminar).

## Comandos de gestión

### Contenedores

| Comando | Descripción |
| :--- | :--- |
| `docker ps` | Lista los contenedores en ejecución. |
| `docker ps -a` | Lista todos los contenedores, incluidos los detenidos. |
| `docker start [id_o_nombre]` | Inicia un contenedor detenido. |
| `docker stop [id_o_nombre]` | Detiene un contenedor en ejecución. |
| `docker rm [id_o_nombre]` | Elimina un contenedor detenido. Los datos guardados en un volumen se conservan; los del propio contenedor se pierden. |
| `docker rm -f [id_o_nombre]` | Fuerza la eliminación, aunque el contenedor esté en ejecución. |
| `docker container prune` | Elimina todos los contenedores detenidos. |
| `docker logs [id_o_nombre]` | Muestra los registros (logs) del contenedor. |
| `docker inspect [id_o_nombre]` | Muestra información detallada del contenedor en formato JSON. |
| `docker exec -it [id_o_nombre] [comando]` | Ejecuta un comando dentro de un contenedor en marcha. `-it` proporciona una terminal interactiva. |

### Imágenes

| Comando | Descripción |
| :--- | :--- |
| `docker images` | Lista las imágenes del sistema local. |
| `docker pull [imagen]` | Descarga una imagen desde un registro. |
| `docker rmi [id_o_nombre_imagen]` | Elimina una imagen del sistema local. |
| `docker image prune -a` | Elimina todas las imágenes que no estén en uso por ningún contenedor. |
| `docker build -t [nombre_imagen] [ruta/al/Dockerfile]` | Construye una imagen a partir de un `Dockerfile`. `-t` permite etiquetarla o nombrarla. Ejemplo: `docker build -t miapp .` si el `Dockerfile` está en el directorio actual. |
