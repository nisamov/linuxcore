# Creación de Archivo Dockerfile

Para llevar a cabo la creación de un Dockerfile, es necesario comprender que es un archivo de texto con la serie de instrucciones que Docker sigue para construir una imagen automáticamente.

## Instrucciones

Crear un archivo Dockerfile. `nano Dockerfile`
Editar el archivo y otorgarle la siguiente estructura:

```Dockerfile
# Definicion de la imagen base sobre la que se construirá el contenido
FROM alpine

# Definición el comando que se ejecutará por defecto cuando un contenedor se inicie a partir de la imagen seleccionada
CMD ["echo", "Salida por consola en contenedor"]
```

Construir la imagen. `docker build -t output-ejemplo .`

* **docker build:** Es el comando para construir imágenes
* **-t output-ejemplo:** La opción '-t' sirve para etiquetar (tag) o nombrar la imagen. Nombrada "output-ejemplo".
* **.:** Indica el contexto de la construccion, donde se encuentra el Dockerfile y otros archivos necesarios (es el directorio actual).

Verificar contenedor. `docker images` (debería aparecer "output-ejemplo").

Probar contenedor. `docker run output-ejemplo`

Si todo ha sido montado correctamente, se verá en la terminal el mensaje "Salida por consola en contenedor".
