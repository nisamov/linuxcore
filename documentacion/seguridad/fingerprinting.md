# Fingerprinting

El fingerprinting es la fase de reconocimiento que sigue al footprinting. Realiza una **búsqueda activa** de información, es decir, requiere interacción con los dispositivos de la organización investigada, por lo que puede ser detectada.

## Información que se busca

- Sistemas operativos y sus versiones.
- Puertos abiertos y servicios que están a la escucha.
- Usuarios y grupos definidos en los sistemas.

Existen herramientas para realizarlo de forma automatizada.

## Escaneo de la topología de la red

Se realiza un mapeo de la red para descubrir:

- Direcciones MAC.
- Direcciones IP internas.
- Topología de la red.
- Puertos abiertos.
- Servidores.
- Tipos de dispositivos.
- Tecnologías empleadas.

Hay dos tipos de rastreo: el rastreo ICMP, que utiliza el protocolo ICMP, y el rastreo TCP/UDP, que utiliza los protocolos TCP y UDP.

## Rastreo ICMP

Se envía una solicitud de eco (*Echo Request*) a una dirección IP y se espera un tiempo prudencial a recibir la respuesta (*Echo Reply*). Si hay respuesta, existe una máquina con esa IP. El proceso se automatiza realizando peticiones de eco a un rango de direcciones IP.

A través del campo TTL del paquete IP de respuesta se puede deducir el sistema operativo de la máquina objetivo, ya que cada sistema operativo define un valor inicial de TTL por defecto diferente. Como cada router intermedio resta una unidad, el valor recibido es el inicial menos el número de saltos.

### Herramientas de rastreo ICMP

- **Traceroute (tracert en Windows):** envía una solicitud de eco al destino en un paquete IP con TTL=1, luego con TTL=2, y así sucesivamente hasta que el paquete alcanza su destino. Cada router que descarta el paquete responde con un mensaje ICMP de tipo 11, lo que permite conocer las IP de los routers intermedios y cuántos saltos hay hasta el destino.
- **Nmap:** tiene versión con interfaz gráfica (Zenmap). Realiza rastreos ICMP, TCP y UDP.
- **hping3:** permite hacer rastreos ICMP, TCP y UDP, y fabricar paquetes a medida.

## Rastreo TCP y UDP

Establece comunicación con puertos TCP y UDP para:

- Buscar servicios en ejecución o a la escucha.
- Identificar las aplicaciones de los servicios.
- Determinar el sistema operativo del sistema objetivo.

Esta información permite encontrar formas de acceso explotando servicios con vulnerabilidades conocidas y no corregidas. Las herramientas habituales son Nmap y hping3.

### Exploración TCP

Consiste en enviar segmentos TCP a un destino (IP y puerto) y, según la respuesta recibida, concluir si hay un programa atendiendo ese puerto.

- Se envía **SYN** y se recibe **RST+ACK**: no hay programa.
- Se envía **SYN** y se recibe **SYN+ACK**: hay programa.
- Se envía **FIN** y se recibe **RST+ACK**: no hay programa.
- Se envía **FIN** y no se recibe respuesta: hay programa.
- Se envía un segmento **sin flags** y se recibe **RST+ACK**: no hay programa.
- Se envía un segmento **sin flags** y no se recibe respuesta: hay programa.

En los casos en que no hay respuesta, la conclusión es una suposición: la ausencia de respuesta también puede deberse a un cortafuegos que descarta el tráfico, por lo que en rigor el puerto está *abierto o filtrado*.

### Efecto de un cortafuegos

Un cortafuegos filtra paquetes IP y segmentos TCP/UDP. Si se configura una regla `DROP`, el sistema no responde con ningún segmento TCP, lo que dificulta saber qué puertos están abiertos.

### Exploración UDP

UDP no envía acuses de recibo, a diferencia de TCP, por lo que no tiene por qué recibirse respuesta. Por tanto, un escaneo de puertos UDP **no es fiable**.

- Sin respuesta: se supone que hay programa atendiendo.
- Respuesta ICMP de puerto no alcanzable: no hay programa.
