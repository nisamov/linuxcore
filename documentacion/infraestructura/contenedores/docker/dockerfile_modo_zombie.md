# Dockerfile: mantener servicios activos

Cuando el proceso principal definido por `CMD` o `ENTRYPOINT` termina, Docker detiene el contenedor. Este comportamiento puede producir la parada inmediata de una imagen que instala servicios con `RUN` pero no mantiene activo su proceso principal.

## Requisitos previos

- Docker Engine instalado y accesible.
- Permisos para construir imágenes y ejecutar contenedores.
- Un script de inicio separado del `Dockerfile`.
- Conocimiento de los servicios que debe arrancar la aplicación.

## Preparar el script de inicio

Crea `start.sh` con permisos de ejecución previstos dentro del contenedor:

```bash
#!/bin/bash
set -e

echo "Iniciando servicios..."

service ssh start
service apache2 start

sleep 2
echo "Servicios iniciados"

tail -f /dev/null
```

El script inicia los servicios y mantiene el proceso principal activo. `tail -f /dev/null` espera indefinidamente y evita que el script llegue al final.

Este método sirve para laboratorios y depuración. Para producción se recomienda ejecutar un único proceso supervisado por Docker o utilizar un gestor de procesos apropiado.

## Configurar el Dockerfile

```dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server apache2 dos2unix && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh

RUN dos2unix /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
```

Este ejemplo modifica el sistema durante la construcción e instala servicios. `dos2unix` convierte finales de línea `CRLF` a `LF`; los archivos editados en Windows pueden producir errores como `exec user process caused: no such file or directory` si conservan finales de línea incompatibles.

## Construir y ejecutar

Desde el directorio que contiene el `Dockerfile` y `start.sh`:

```bash
sudo docker build -t laboratorio-servicios:1.0 .
sudo docker run -d --name laboratorio laboratorio-servicios:1.0
```

## Verificación

Comprueba que el contenedor permanece activo:

```bash
sudo docker ps
sudo docker logs laboratorio
sudo docker exec -it laboratorio bash
```

Dentro del contenedor, consulta los servicios:

```bash
service ssh status
service apache2 status
```

## Reversión

Detén y elimina el contenedor de prueba:

```bash
sudo docker rm -f laboratorio
```

Para eliminar también la imagen local:

```bash
sudo docker rmi laboratorio-servicios:1.0
```

## Advertencias

- `docker run ... sleep infinity` sobrescribe `CMD` y hace que el contenedor quede activo sin iniciar los servicios definidos en `start.sh`.
- No usar `tail -f /dev/null` como sustituto de supervisión en producción.
- Ejecutar varios servicios mediante `service` dentro de un contenedor puede ocultar errores y dificultar el registro de logs.
- Los scripts deben conservar finales de línea `LF`, permisos de ejecución y rutas absolutas válidas.
