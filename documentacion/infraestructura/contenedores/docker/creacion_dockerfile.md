# Creación de Archivo Dockerfile

Para llevar a cabo la creación de un Dockerfile, es necesario comprender que es un archivo de texto con la serie de instrucciones que Docker sigue para construir una imagen automáticamente. Cada instrucción genera una **capa** de la imagen.

## Instrucciones

Crear un archivo Dockerfile. `nano Dockerfile`
Editar el archivo y otorgarle la siguiente estructura:

```Dockerfile
# Definicion de la imagen base sobre la que se construirá el contenido
FROM alpine

# Declaración de variables
ENV NombreUsuario="UsuarioEjemplo"

# Uso de variables declaradas localmente
CMD echo "Variable Almacenada: $NombreUsuario"
```

> **Nota:** un `Dockerfile` solo puede tener un `CMD` efectivo. Si hay varios, **solo se ejecuta el último**. Por eso en este ejemplo se deja una única instrucción `CMD`.

Construir la imagen. `docker build -t output-ejemplo .`

* **docker build:** Es el comando para construir imágenes
* **-t output-ejemplo:** La opción `-t` sirve para etiquetar (tag) o nombrar la imagen. Nombrada "output-ejemplo".
* **.:** Indica el contexto de la construccion, donde se encuentra el Dockerfile y otros archivos necesarios (es el directorio actual).

Verificar contenedor. `docker images` (debería aparecer "output-ejemplo").

Probar contenedor. `docker run output-ejemplo`

Si todo ha sido montado correctamente, se verá en la terminal el mensaje con el valor de la variable.

## Instrucciones principales del Dockerfile

| Instrucción | Descripción | Ejemplo |
| :--- | :--- | :--- |
| `FROM` | Imagen base sobre la que se construye. Es siempre la primera instrucción (salvo `ARG`). | `FROM ubuntu:24.04` |
| `LABEL` | Metadatos de la imagen (autor, versión, descripción). | `LABEL autor="nombre"` |
| `ENV` | Define variables de entorno persistentes. | `ENV PUERTO=8080` |
| `ARG` | Variable disponible solo durante la construcción. | `ARG VERSION=1.0` |
| `WORKDIR` | Establece el directorio de trabajo para las instrucciones siguientes (lo crea si no existe). | `WORKDIR /app` |
| `RUN` | Ejecuta un comando **durante la construcción** y guarda el resultado en una capa. | `RUN apk add --no-cache curl` |
| `COPY` | Copia archivos del contexto de construcción a la imagen. | `COPY . /app` |
| `ADD` | Como `COPY`, pero además descomprime `.tar` locales y admite URLs. Preferir `COPY` salvo necesidad. | `ADD datos.tar.gz /datos` |
| `EXPOSE` | **Documenta** el puerto que usa la aplicación. No lo publica: para eso hace falta `-p`. | `EXPOSE 80` |
| `VOLUME` | Declara un punto de montaje para datos persistentes. | `VOLUME /var/lib/mysql` |
| `USER` | Usuario con el que se ejecutarán las instrucciones y el contenedor (evitar `root`). | `USER appuser` |
| `ENTRYPOINT` | Comando fijo que se ejecuta al iniciar el contenedor. | `ENTRYPOINT ["python"]` |
| `CMD` | Comando (o argumentos) por defecto al iniciar el contenedor; se puede sustituir desde `docker run`. | `CMD ["app.py"]` |
| `HEALTHCHECK` | Comprueba periódicamente si el contenedor funciona correctamente. | `HEALTHCHECK CMD curl -f http://localhost/ \|\| exit 1` |

## `RUN` vs `CMD` vs `ENTRYPOINT`

| Instrucción | Cuándo se ejecuta | Cuántas se aplican | Se puede sobrescribir en `docker run` |
| :--- | :--- | :--- | :--- |
| `RUN` | Al **construir** la imagen | Todas (una capa cada una) | No |
| `CMD` | Al **iniciar** el contenedor | Solo la última | Sí (se reemplaza) |
| `ENTRYPOINT` | Al **iniciar** el contenedor | Solo la última | Solo con `--entrypoint` |

Si se combinan, `CMD` aporta los argumentos por defecto de `ENTRYPOINT`:

```Dockerfile
FROM alpine
ENTRYPOINT ["echo", "Hola"]
CMD ["mundo"]
```

```sh
docker run imagen            # Hola mundo
docker run imagen Docker     # Hola Docker
```

### Formas de escribir `CMD`, `RUN` y `ENTRYPOINT`

| Forma | Sintaxis | Comportamiento |
| :--- | :--- | :--- |
| **exec** (recomendada) | `CMD ["echo", "hola"]` | Ejecuta el proceso directamente, sin shell. No expande variables (`$VAR`). |
| **shell** | `CMD echo "hola $VAR"` | Se ejecuta mediante `/bin/sh -c`, por lo que **sí** expande variables. |

> Por eso en el ejemplo anterior se usa la forma *shell* para mostrar `$NombreUsuario`.

## Ejemplo completo: servidor web con Nginx

Estructura del proyecto:

```text
mi-web/
├── Dockerfile
├── .dockerignore
└── web/
    └── index.html
```

```Dockerfile
FROM nginx:alpine
LABEL autor="alumno"
COPY web/ /usr/share/nginx/html/
EXPOSE 80
```

```sh
docker build -t mi-web .
docker run -d --name web -p 8080:80 mi-web
# Abrir en el navegador: http://localhost:8080
```

## Ejemplo: aplicación Python

```Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
USER nobody
CMD ["python", "app.py"]
```

> Se copia primero `requirements.txt` y después el resto del código para aprovechar la **caché de capas**: si el código cambia pero las dependencias no, Docker no vuelve a instalarlas.

## Archivo `.dockerignore`

Indica qué archivos **no** se envían al contexto de construcción (acelera el `build` y evita incluir datos sensibles):

```text
.git
node_modules
*.log
.env
Dockerfile
.dockerignore
```

## Capas y caché

* Cada instrucción (`RUN`, `COPY`, `ADD`...) crea una capa de solo lectura.
* Si una instrucción y todo lo anterior no ha cambiado, Docker reutiliza la capa en caché.
* Colocar primero lo que cambia poco (dependencias) y al final lo que cambia mucho (código).
* Encadenar comandos en un único `RUN` reduce el número de capas:

```Dockerfile
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
```

## Comandos útiles de construcción

| Comando | Descripción |
| :--- | :--- |
| `docker build -t nombre:etiqueta .` | Construye la imagen con nombre y versión (`:1.0`, `:latest`). |
| `docker build -f ruta/Dockerfile .` | Usa un Dockerfile con otro nombre o ubicación. |
| `docker build --no-cache -t nombre .` | Construye ignorando la caché. |
| `docker build --build-arg VAR=valor -t nombre .` | Pasa un valor a un `ARG`. |
| `docker history [imagen]` | Muestra las capas y los comandos que crearon la imagen. |

## Construcción multietapa (*multi-stage build*)

Permite compilar en una imagen y copiar solo el resultado a una imagen final más pequeña:

```Dockerfile
# Etapa 1: compilación
FROM golang:1.22 AS builder
WORKDIR /src
COPY . .
RUN go build -o app

# Etapa 2: imagen final ligera
FROM alpine
COPY --from=builder /src/app /usr/local/bin/app
CMD ["app"]
```
