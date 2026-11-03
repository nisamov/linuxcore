# Enrutamiento desde origen (source routing)

## Funcionamiento

El protocolo IP permite incluir en una cabecera específica del paquete la información necesaria para su enrutamiento, fundamentalmente una lista ordenada de IP de los routers intermedios que deben atravesarse hasta llegar al destino. El destinatario envía su respuesta por esa misma ruta.

Suele emplearse en tareas de verificación y configuración de routers, pero, mal utilizado, permite a un atacante saltarse las reglas de enrutamiento.

## Combinación con IP spoofing

Combinado con el falseamiento de IP (*IP spoofing*), permite al atacante hacerse pasar por otro sistema, enviando paquetes y **recibiendo** las respuestas asociadas.

Una de las principales dificultades del IP spoofing es mantener de forma efectiva la dirección falseada. Para que tenga éxito, hay que dejar fuera de juego momentáneamente a la víctima, por ejemplo mediante un ataque de denegación de servicio. Con *source routing* esto no es necesario.

## Situación actual

El source routing no funciona en Internet porque los proveedores de servicios (ISP) bloquean esos paquetes.
