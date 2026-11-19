# Creación y configuración de archivos Dockerfile

Un `Dockerfile` describe las instrucciones que Docker utiliza para construir una imagen. Este documento explica qué hace cada instrucción y cómo comprobar el resultado.

## Conceptos básicos

Un `Dockerfile` es un archivo de texto que contiene instrucciones para construir una imagen de forma automatizada. Cada instrucción define una operación sobre el sistema de archivos o una configuración que se aplicará al iniciar el contenedor.

Las imágenes están formadas por capas. Las instrucciones que modifican el sistema de archivos, como `RUN`, `COPY` y `ADD`, pueden generar nuevas capas reutilizables mediante la caché de construcción.

## Requisitos previos

- Docker Engine instalado y el cliente disponible en la terminal.
- Permisos para construir imágenes y ejecutar contenedores. Si Docker no permite el acceso sin privilegios, se puede necesitar `sudo` o pertenecer al grupo `docker`.
- Un directorio de trabajo vacío o preparado para el proyecto.
- Conocimiento básico del sistema operativo y de los paquetes usados por la imagen base.

## Crear un Dockerfile

Crea el archivo con un editor de texto. El siguiente ejemplo utiliza Alpine Linux y muestra una variable de entorno al iniciar el contenedor:

```dockerfile
# Imagen base
FROM alpine:3.20

# Variable disponible durante la ejecución
ENV NombreUsuario="UsuarioEjemplo"

# Comando predeterminado
CMD ["sh", "-c", "echo Variable almacenada: $NombreUsuario"]
```

La última instrucción `CMD` usa `exec form` y ejecuta una shell solo para expandir la variable. Evita almacenar secretos en `ENV`: el valor quedaría visible en el archivo, las capas y el historial de la imagen.

## Construir la imagen

Desde el directorio que contiene el `Dockerfile`, ejecuta:

```bash
docker build -t output-ejemplo:1.0 .
```

- `docker build` inicia el proceso de construcción.
- `-t output-ejemplo:1.0` asigna el nombre y la etiqueta a la imagen.
- `.` indica el directorio actual como contexto de construcción.

## Verificar el resultado

Comprueba que la imagen existe:

```bash
docker images output-ejemplo
```

Inicia un contenedor temporal para comprobar el resultado. La opción `--rm` elimina el contenedor al finalizar:

```bash
docker run --rm output-ejemplo:1.0
```

Debería mostrarse un mensaje parecido a:

```text
Variable almacenada: UsuarioEjemplo
```

## Reversión

Para eliminar únicamente el contenedor temporal no hace falta una acción adicional, porque `--rm` lo elimina al terminar.

Para eliminar la imagen creada en el entorno local:

```bash
docker rmi output-ejemplo:1.0
```

La eliminación puede fallar si todavía existe un contenedor creado a partir de la imagen.

## Advertencias

- No uses `FROM scratch` ni una imagen desconocida sin revisar su procedencia cuando la construcción sea reproducible o se vaya a desplegar en producción.
- No copies archivos `.env`, claves privadas ni credenciales al contexto de construcción.
- Construir con un Dockerfile mal diseñado puede instalar paquetes o modificar datos dentro de la imagen, pero no elimina el sistema anfitrión por sí mismo.

## Instrucciones principales de un Dockerfile

| Instrucción   | Descripción                                                                                                                                                                                                    | Ejemplo                                                 |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `FROM`        | Define la imagen base sobre la que se construirá la nueva imagen. Debe ser la primera instrucción de cada etapa, salvo instrucciones `ARG` previas.                                                            | `FROM ubuntu:24.04`                                     |
| `LABEL`       | Añade metadatos a la imagen, como el autor, la versión o una descripción.                                                                                                                                      | `LABEL autor="nombre"`                                  |
| `ENV`         | Define variables de entorno que estarán disponibles durante la construcción y en los contenedores creados a partir de la imagen.                                                                               | `ENV PUERTO=8080`                                       |
| `ARG`         | Declara variables disponibles durante la construcción de la imagen.                                                                                                                                            | `ARG VERSION=1.0`                                       |
| `WORKDIR`     | Establece el directorio de trabajo para las instrucciones posteriores. Si no existe, Docker lo crea.                                                                                                           | `WORKDIR /app`                                          |
| `RUN`         | Ejecuta comandos durante la construcción de la imagen. Sus modificaciones en el sistema de archivos quedan incorporadas a la imagen.                                                                           | `RUN apk add --no-cache curl`                           |
| `COPY`        | Copia archivos o directorios desde el contexto de construcción al sistema de archivos de la imagen.                                                                                                            | `COPY . /app`                                           |
| `ADD`         | Copia archivos y, además, permite descargar recursos mediante URL y extraer automáticamente archivos comprimidos TAR locales. Se recomienda utilizar `COPY` cuando no se necesiten esas funciones adicionales. | `ADD datos.tar.gz /datos`                               |
| `EXPOSE`      | Documenta el puerto en el que está previsto que escuche la aplicación. No publica el puerto por sí mismo.                                                                                                     | `EXPOSE 80`                                             |
| `VOLUME`      | Declara un punto de montaje destinado a almacenar datos que pueden persistir independientemente del ciclo de vida del contenedor.                                                                             | `VOLUME /var/lib/mysql`                                 |
| `USER`        | Establece el usuario con el que se ejecutarán las instrucciones posteriores y el proceso principal del contenedor.                                                                                            | `USER nobody`                                           |
| `ENTRYPOINT`  | Define el ejecutable principal que se iniciará al arrancar el contenedor.                                                                                                                                      | `ENTRYPOINT ["python"]`                                 |
| `CMD`         | Especifica el comando o los argumentos predeterminados que se utilizarán al iniciar el contenedor.                                                                                                             | `CMD ["app.py"]`                                        |
| `HEALTHCHECK` | Define una comprobación periódica para determinar si el contenedor se encuentra en buen estado.                                                                                                               | `HEALTHCHECK CMD curl -f http://localhost/ \|\| exit 1` |

### Consideraciones importantes

- `ARG` está disponible durante la construcción, mientras que `ENV` permanece disponible en el entorno de ejecución del contenedor.
- `EXPOSE` no sustituye a la opción `-p` de `docker run`.
- `ADD` no extrae automáticamente archivos comprimidos descargados desde URL; esa extracción automática se aplica a los archivos TAR locales.
- Para utilizar `HEALTHCHECK`, el comando de comprobación debe estar disponible dentro de la imagen.
- Es recomendable ejecutar las aplicaciones con un usuario sin privilegios de administrador siempre que sea posible.

## Diferencias entre RUN, CMD y ENTRYPOINT

Estas tres instrucciones tienen funciones diferentes y es importante distinguirlas.

| Instrucción  | Cuándo se ejecuta                     | Instrucciones efectivas por etapa               | Comportamiento al utilizar `docker run`                     |
| ------------ | ------------------------------------- | ----------------------------------------------- | ----------------------------------------------------------- |
| `RUN`        | Durante la construcción de la imagen. | Se ejecutan todas las instrucciones declaradas. | No se puede sustituir al iniciar el contenedor.             |
| `CMD`        | Al iniciar el contenedor.             | Solo permanece activa la última instrucción.    | Puede sustituirse proporcionando otro comando o argumentos. |
| `ENTRYPOINT` | Al iniciar el contenedor.             | Solo permanece activo el último `ENTRYPOINT`.   | Puede sustituirse mediante la opción `--entrypoint`.        |

### RUN: ejecución durante la construcción

`RUN` permite ejecutar comandos que preparan el entorno de la imagen.

Se utiliza, por ejemplo, para instalar programas, actualizar paquetes, crear directorios o compilar aplicaciones.

Ejemplo:

```
FROM alpine

RUN apk update
RUN apk add --no-cache python3
RUN mkdir /app
```

Estas operaciones se realizan durante la construcción:

```
docker build -t mi-imagen .
```

Una vez construida la imagen, sus resultados quedan incorporados a ella. No es necesario volver a ejecutar esas instrucciones cada vez que se inicia un contenedor.

### CMD: comando predeterminado del contenedor

`CMD` define el comando que se ejecutará cuando se inicie un contenedor si no se proporciona otro comando que lo sustituya.

Ejemplo:

```
FROM alpine

CMD ["echo", "Hola desde Docker"]
```

Al ejecutar:

```
docker run mi-imagen
```

Se obtiene:

```
Hola desde Docker
```

Sin embargo, si se ejecuta:

```
docker run mi-imagen echo "Nuevo mensaje"
```

El comando indicado en `docker run` sustituye al `CMD` predeterminado.

### ENTRYPOINT: proceso principal del contenedor

`ENTRYPOINT` establece el ejecutable principal que se ejecutará al iniciar el contenedor.

Ejemplo:

```
FROM alpine

ENTRYPOINT ["echo", "Hola"]
```

Al ejecutar:

```
docker run mi-imagen
```

El resultado será:

```
Hola
```

Si se añaden argumentos:

```
docker run mi-imagen Docker
```

El resultado será:

```
Hola Docker
```

En este caso, los argumentos proporcionados se añaden al comando establecido mediante `ENTRYPOINT`.

Para sustituir el ejecutable principal se utiliza:

```
docker run --entrypoint sh mi-imagen
```

### Combinación de CMD y ENTRYPOINT

Es habitual combinar ambas instrucciones para establecer un ejecutable fijo y permitir que sus argumentos predeterminados puedan modificarse.

```
FROM alpine

ENTRYPOINT ["echo", "Hola"]
CMD ["mundo"]
```

Comportamiento:

```
docker run mi-imagen
# Hola mundo

docker run mi-imagen Docker
# Hola Docker
```

En este ejemplo:

- `ENTRYPOINT` define el ejecutable y sus argumentos fijos.
- `CMD` proporciona los argumentos predeterminados.
- Los argumentos introducidos en `docker run` sustituyen a los argumentos predeterminados de `CMD`.

## Formas de escribir CMD, RUN y ENTRYPOINT

Las instrucciones que ejecutan comandos pueden utilizar dos formatos principales: *shell form* y *exec form*.

| Formato        | Sintaxis               | Comportamiento                                                                               |
| -------------- | ---------------------- | -------------------------------------------------------------------------------------------- |
| **Exec form**  | `CMD ["echo", "hola"]` | Ejecuta directamente el proceso, sin utilizar un intérprete de comandos de forma automática. |
| **Shell form** | `CMD echo "hola"`      | Ejecuta el comando mediante un intérprete de comandos, normalmente `/bin/sh -c`.             |

### Exec form

Se recomienda este formato para ejecutar aplicaciones y procesos principales.

```dockerfile
CMD ["python3", "app.py"]
```

Sus principales características son:

- Ejecuta directamente el proceso indicado.
- No realiza expansión automática de variables de entorno como `$VARIABLE`.
- Facilita la gestión de señales y del proceso principal del contenedor.

### Shell form

Este formato utiliza un intérprete de comandos.

```dockerfile
CMD ["sh", "-c", "echo Variable almacenada: $NombreUsuario"]
```

Sus principales características son:

- Permite utilizar variables de entorno.
- Admite operaciones propias de la shell, como redirecciones y operadores.
- El proceso se ejecuta mediante un intérprete de comandos.

Aunque se escriba con `exec form`, este ejemplo utiliza una shell explícita para expandir `$NombreUsuario`.

## Variables ARG y ENV

`ARG` se utiliza durante la construcción y `ENV` define valores persistentes en la imagen y en los contenedores creados a partir de ella.

```dockerfile
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ENV USUARIO_APP="invitado"

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

CMD ["sh", "-c", "echo Bienvenido al contenedor, $USUARIO_APP"]
```

`ARG` debe declararse antes de `FROM` si se desea utilizar su valor en la imagen base:

```bash
sudo docker build --build-arg UBUNTU_VERSION=24.04 -t ubuntu-configurable:1.0 .
```

El valor predeterminado de `ENV` se puede sustituir al ejecutar el contenedor:

```bash
sudo docker run --rm -e USUARIO_APP="Administrador" ubuntu-configurable:1.0
```

No se deben utilizar `ARG` ni `ENV` para almacenar contraseñas o claves privadas. Su valor puede quedar visible en el historial, la configuración o las capas de la imagen.

## Ejemplo completo: servidor web con Nginx

A continuación se muestra un ejemplo de cómo construir una imagen que contenga un servidor web Nginx.

### Estructura del proyecto

```
mi-web/
├── Dockerfile
├── .dockerignore
└── web/
    └── index.html
```

### Contenido del Dockerfile

```
# Imagen base
FROM nginx:alpine

# Metadatos de la imagen
LABEL autor="alumno"

# Copiar los archivos de la página web
COPY web/ /usr/share/nginx/html/

# Documentar el puerto del servidor
EXPOSE 80
```

### Construcción y ejecución

Construir la imagen:

```
docker build -t mi-web .
```

Iniciar el contenedor:

```
docker run -d --name web -p 8080:80 mi-web
```

Una vez iniciado, se puede acceder al servidor desde un navegador:

```
http://localhost:8080
```

En este caso, el puerto `8080` de la máquina anfitriona se comunica con el puerto `80` del contenedor, donde escucha Nginx.

## Ejemplo: aplicación Python

También es posible construir imágenes que contengan aplicaciones desarrolladas en Python.

### Estructura del proyecto

```
mi-aplicacion/
├── Dockerfile
├── requirements.txt
└── app.py
```

### Contenido del Dockerfile

```
# Imagen base
FROM python:3.12-slim

# Directorio de trabajo
WORKDIR /app

# Copiar el archivo de dependencias
COPY requirements.txt .

# Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código
COPY . .

# Documentar el puerto de la aplicación
EXPOSE 5000

# Ejecutar con un usuario sin privilegios de administrador
USER nobody

# Comando predeterminado
CMD ["python", "app.py"]
```

### Aprovechamiento de la caché de capas

En este ejemplo se copia primero `requirements.txt` y posteriormente el resto del código.

Esta organización permite aprovechar la caché de Docker:

- Si se modifica `app.py`, Docker puede reutilizar la capa en la que se instalaron las dependencias.
- Si se modifica `requirements.txt`, será necesario volver a ejecutar la instalación de paquetes.
- Si no se modifican los archivos ni las instrucciones anteriores, Docker puede reutilizar las capas almacenadas en caché.

De esta manera, se evita repetir operaciones innecesarias durante la construcción de la imagen.

**Nota:** el usuario `nobody` debe disponer de los permisos necesarios para leer los archivos y acceder a los directorios utilizados por la aplicación. Si necesita escribir datos, habrá que configurar los permisos correspondientes.

## Archivo .dockerignore

El archivo `.dockerignore` permite indicar qué archivos y directorios deben excluirse del contexto de construcción.

Su utilización ayuda a:

- Reducir la cantidad de información enviada al proceso de construcción.
- Disminuir los tiempos de construcción.
- Evitar incorporar archivos innecesarios a la imagen.
- Reducir el riesgo de incluir información sensible.

Ejemplo de contenido:

```
.git
node_modules
*.log
.env
__pycache__
```

En este ejemplo se excluyen:

- `.git`: directorio de configuración del repositorio.
- `node_modules`: dependencias de proyectos Node.js.
- `*.log`: archivos de registro.
- `.env`: archivos que pueden contener variables sensibles.
- `__pycache__`: archivos temporales generados por Python.

Docker seguirá utilizando los archivos necesarios para construir la imagen, siempre que no estén excluidos por las reglas del archivo.

## Capas y caché de construcción

Las imágenes de Docker se organizan mediante capas que representan los cambios realizados sobre el sistema de archivos y la configuración de la imagen.

Cuando Docker construye una imagen, puede reutilizar operaciones anteriores mediante la caché.

### Funcionamiento de la caché

Si una instrucción y los elementos de los que depende no han cambiado, Docker puede reutilizar el resultado almacenado.

Por ejemplo:

```
FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y curl

COPY . /app
```

Si únicamente se modifica el contenido que se copia en `/app`, Docker puede reutilizar las operaciones anteriores.

### Buenas prácticas

Para aprovechar mejor la caché:

- Colocar primero las instrucciones que cambian con menor frecuencia.
- Copiar e instalar las dependencias antes de copiar el código de la aplicación.
- Dejar para el final las instrucciones relacionadas con los archivos que cambian habitualmente.
- Evitar ejecutar operaciones innecesarias durante la construcción.

### Agrupación de comandos RUN

Es posible agrupar varios comandos en una única instrucción `RUN` mediante `&&`.

Ejemplo:

```
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
```

Esto permite ejecutar varias operaciones dentro de una misma instrucción y reducir la cantidad de capas del sistema de archivos.

También ayuda a evitar que los archivos temporales de instalación permanezcan en una capa independiente.

**Importante:** no todas las instrucciones de un Dockerfile generan una capa del sistema de archivos. Por ejemplo, `ENV`, `LABEL`, `WORKDIR`, `CMD` y `EXPOSE` modifican principalmente la configuración o los metadatos de la imagen.

## Comandos útiles de construcción

| Comando                                          | Descripción                                                                  |
| ------------------------------------------------ | ---------------------------------------------------------------------------- |
| `docker build -t nombre:etiqueta .`              | Construye una imagen y le asigna un nombre y una etiqueta.                   |
| `docker build -f ruta/Dockerfile -t nombre .`    | Construye una imagen utilizando un Dockerfile situado en otra ubicación.     |
| `docker build --no-cache -t nombre .`            | Construye la imagen sin reutilizar la caché.                                 |
| `docker build --build-arg VAR=valor -t nombre .` | Proporciona un valor a una variable `ARG` declarada en el Dockerfile.        |
| `docker images`                                  | Muestra las imágenes disponibles localmente.                                 |
| `docker history imagen`                          | Muestra el historial de las capas y las instrucciones asociadas a la imagen. |
| `docker ps`                                      | Muestra los contenedores que se encuentran en ejecución.                     |
| `docker ps -a`                                   | Muestra todos los contenedores, incluidos los detenidos.                     |

## Construcción multietapa (Multi-stage build)

La construcción multietapa permite utilizar diferentes imágenes durante el proceso de construcción de una aplicación.

Su principal objetivo es separar el entorno de compilación del entorno de ejecución.

De esta forma, la imagen final puede contener únicamente los archivos necesarios para ejecutar la aplicación, sin incorporar todas las herramientas utilizadas durante su compilación.

### Ejemplo con Go

```
# Primera etapa: compilación
FROM golang:alpine AS builder

WORKDIR /src

COPY . .

RUN go build -o /out/app .


# Segunda etapa: imagen final
FROM alpine

# Copiar únicamente el ejecutable generado
COPY --from=builder /out/app /usr/local/bin/app

# Comando de inicio
CMD ["app"]
```

En este ejemplo:

1. La primera etapa utiliza una imagen que contiene las herramientas necesarias para compilar el proyecto.
2. Se compila la aplicación y se genera el ejecutable `/out/app`.
3. La segunda etapa parte de una imagen más ligera.
4. Mediante `COPY --from=builder` se copia únicamente el ejecutable generado.
5. La imagen final no necesita incluir el entorno de compilación.

Esto permite reducir el tamaño de la imagen y evitar incorporar herramientas innecesarias en el entorno de producción.

## Diferencia práctica entre RUN y CMD: construir frente a ejecutar

Una forma sencilla de comprender la diferencia entre `RUN` y `CMD` consiste en imaginar que se está preparando una caja de herramientas para realizar un trabajo.

### RUN: preparación del entorno

`RUN` representa las operaciones necesarias para preparar la imagen.

Se ejecuta durante el proceso de construcción (`docker build`) y permite instalar programas, crear directorios, configurar el entorno o compilar código.

Ejemplo:

```
RUN apk add --no-cache python3
```

Esta instrucción instala Python dentro de la imagen.

El resultado queda incorporado a la imagen y no es necesario repetir la instalación cada vez que se inicia un contenedor.

### CMD: ejecución de la aplicación

`CMD` establece qué proceso se ejecutará de forma predeterminada cuando se inicie un contenedor.

Ejemplo:

```
CMD ["python3", "app.py"]
```

Esta instrucción indica que, al iniciar el contenedor, se ejecutará el archivo `app.py` mediante Python.

Si se utiliza otro comando al ejecutar `docker run`, se sustituirá el comando predeterminado de `CMD`.

Por ejemplo:

```
docker run mi-imagen sh
```

En este caso, se ejecutará `sh` en lugar del comando predeterminado, siempre que no exista un `ENTRYPOINT` que modifique ese comportamiento.

**Diferencia fundamental:**

- `RUN` prepara la imagen durante su construcción.
- `CMD` establece el comando predeterminado para iniciar el contenedor.
- `ENTRYPOINT` define el proceso principal que se ejecutará al iniciar el contenedor.

## Uso de scripts de inicio (start.sh)

En determinados proyectos se utilizan scripts de inicio para ejecutar tareas de inicialización antes de arrancar la aplicación principal.

Por ejemplo, un archivo `start.sh` puede encargarse de configurar el entorno, preparar directorios o realizar comprobaciones antes de iniciar el servicio.

### Ejemplo de estructura

```
mi-proyecto/
├── Dockerfile
└── start.sh
```

### Ejemplo de start.sh

```
#!/bin/sh

set -e

echo "Iniciando la aplicación..."

exec "$@"
```

En este ejemplo:

- `#!/bin/sh` indica que el script debe ejecutarse mediante el intérprete `sh`.
- `set -e` hace que el script termine si alguno de sus comandos devuelve un error.
- `exec "$@"` sustituye el proceso del script por el comando recibido como argumento.

### Ejemplo de Dockerfile

```
FROM alpine

# Copiar el script de inicio
COPY start.sh /start.sh

# Corregir posibles finales de línea y otorgar permisos
RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh

# Configurar el script como punto de entrada
ENTRYPOINT ["/start.sh"]

# Comando predeterminado
CMD ["sh", "-c", "echo Aplicación iniciada"]
```

Al ejecutar el contenedor, Docker inicia `start.sh`, que posteriormente ejecuta el comando definido en `CMD`.

El uso de `ENTRYPOINT` permite que el script se ejecute como parte del arranque del contenedor, mientras que `CMD` proporciona los argumentos predeterminados.

## Mantener un contenedor en ejecución

Un contenedor permanece en ejecución mientras su proceso principal siga activo.

Cuando dicho proceso termina, el contenedor también finaliza.

Por este motivo, no es recomendable utilizar comandos artificiales para mantener un contenedor activo si su aplicación principal ya ha terminado.

### Uso de sleep infinity

El siguiente comando mantiene un contenedor activo indefinidamente:

```
docker run -d mi-imagen sleep infinity
```

Sin embargo, si el Dockerfile contiene:

```
CMD ["./start.sh"]
```

El comando `sleep infinity` sustituye a `CMD`.

Por tanto, si `start.sh` estaba definido únicamente mediante `CMD`, no se ejecutará.

El contenedor permanecerá activo, pero las tareas de inicialización del script no se habrán realizado.

**Importante:** si existe un `ENTRYPOINT`, el comportamiento cambia. El comando proporcionado en `docker run` sustituye a `CMD`, pero se pasa como argumento a `ENTRYPOINT`, salvo que se utilice `--entrypoint` para sustituirlo.

### Uso de tail -f /dev/null

Otra forma de mantener un contenedor activo es utilizar:

```
tail -f /dev/null
```

Este comando permanece en ejecución y evita que el contenedor finalice.

Sin embargo, no inicia ni supervisa la aplicación principal. Por tanto, no es una solución adecuada para mantener servicios en funcionamiento en un entorno de producción.

Puede resultar útil en determinados escenarios de depuración, pero lo recomendable es que el proceso principal del contenedor corresponda al servicio que se desea ejecutar.

## Errores habituales al ejecutar scripts en Docker

Al ejecutar scripts de inicio puede aparecer un error similar al siguiente:

```
standard_init_linux.go: exec user process caused:
no such file or directory
```

Uno de los motivos habituales es que el archivo se haya editado en Windows y utilice finales de línea `CRLF`, mientras que el entorno Linux espera normalmente finales de línea `LF`.

También puede deberse a otros problemas, como una ruta incorrecta, un intérprete inexistente o una directiva *shebang* incorrecta.

### Solución mediante dos2unix

En imágenes basadas en Debian o Ubuntu se puede instalar la herramienta `dos2unix`:

```
RUN apt-get update && \
    apt-get install -y --no-install-recommends dos2unix && \
    dos2unix /start.sh && \
    rm -rf /var/lib/apt/lists/*
```

Esta herramienta convierte los finales de línea del archivo al formato Unix.

### Solución mediante sed

Si se utiliza Alpine o se desea evitar instalar herramientas adicionales, se puede utilizar:

```
RUN sed -i 's/\r$//' /start.sh
```

Para garantizar también que el archivo tenga permisos de ejecución:

```
RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh
```
