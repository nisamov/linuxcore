# Ataques basados en fragmentación IPv4

Estos ataques aprovechan la forma en que IPv4 fragmenta y reensambla los paquetes cuando atraviesan redes con MTU distintas.

## Tiny Fragment

Se aprovecha de que el tamaño mínimo de un fragmento IP puede ser tan pequeño que no llegue a albergar una cabecera TCP completa.

- Se envía un segmento TCP con SYN=0 y ACK=1 dentro de un paquete IP con MF=1. Un filtro sin estado (*stateless*) lo deja pasar porque no parece una petición de nueva conexión.
- A continuación se envía otro fragmento con un offset superpuesto, de forma que, cuando el destinatario reconstruye el paquete original, sobrescribe la cabecera TCP que llegó en el primer fragmento con los valores SYN=1 y ACK=0.

El resultado es un segmento TCP de establecimiento de conexión que ha podido atravesar el filtro sin ser detectado.

Otra variante consiste en enviar un primer fragmento de 8 bytes que contiene solo el puerto de origen, el de destino y el número de secuencia. El sistema de filtrado no tiene la cabecera completa y no puede aplicar sus reglas ni a este ni a los siguientes fragmentos. En el siguiente fragmento llega el resto de la cabecera (flags y demás).

### Protección

Los sistemas de filtrado pueden descartar los paquetes con offset 0 y tamaño inferior a 40 bytes (20 de cabecera IP y 20 de cabecera TCP), para garantizar que una cabecera TCP nunca quede fragmentada. En principio, los sistemas actuales ya no son vulnerables a este ataque.

## Teardrop

Algunas implementaciones de TCP/IP no eran capaces de reensamblar paquetes cuyos fragmentos se superponían, lo que provocaba el bloqueo del sistema. Es, por tanto, un ataque de denegación de servicio. Los sistemas actuales ya no son vulnerables.
