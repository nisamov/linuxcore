# Protocolo ARP

ARP (*Address Resolution Protocol*) permite a un equipo averiguar la dirección MAC de otro a partir de su dirección IP. Es el mecanismo de IPv4; en IPv6 se utiliza ICMPv6.

- **ARP Request:** mensaje en el que un equipo pregunta cuál es la dirección MAC del equipo con una determinada IP.
- **ARP Response:** mensaje en el que el equipo que tiene esa IP comunica su MAC al equipo que preguntó.

## Formato del mensaje

Formato de un mensaje ARP para IPv4 y direcciones MAC de 6 bytes:

- **Hardware Type:** código para cada tipo de red de nivel de enlace de datos. Para Ethernet es 0x0001.
- **Protocol Type:** código para cada tipo de red de nivel 3 de OSI. Es igual que el campo EtherType de Ethernet.
- **Hardware Address Length:** longitud de una dirección MAC en bytes. Para Ethernet es 6.
- **Protocol Address Length:** longitud de una dirección de red en bytes. Para IPv4 es 4.
- **Operation:** 1 para *request* y 2 para *response*.
- **Sender Hardware Address (SHA):** dirección MAC del remitente.
- **Sender Protocol Address (SPA):** dirección de red del remitente.
- **Target Hardware Address (THA):** dirección MAC del destinatario.
- **Target Protocol Address (TPA):** dirección de red del destinatario.

En una red IPv4, la dirección de red es la dirección IP, pero ARP se diseñó para que el protocolo de nivel 3 pudiera ser otro distinto.

## Ejemplo de ARP Request

El equipo con MAC A8:33:33:BB:C1:8E e IP 192.168.202.30 pregunta cuál es la MAC del equipo con IP 192.168.202.254. El mensaje lleva:

- Hardware Type 0x0001 (Ethernet), Protocol Type 0x0800 (IPv4), longitudes 6 y 4 y Operation 0x0001 (request).
- SHA: A8:33:33:BB:C1:8E y SPA: 192.168.202.30.
- THA: 00:00:00:00:00:00, porque se desconoce, y TPA: 192.168.202.254.

La petición va encapsulada en una trama Ethernet cuya MAC de destino es la de *broadcast* (FF:FF:FF:FF:FF:FF), puesto que se desconoce la MAC del destinatario. Toda trama con esa dirección de destino se difunde a todos los equipos de la red, incluso cuando hay un switch.

## Ejemplo de ARP Response

La petición llega a todos los equipos de la red, pero solo responde el que tiene esa IP. El mensaje de respuesta es igual que la petición, pero:

- Operation vale 2.
- Se intercambian las direcciones (IP y MAC) de destino y de origen.
- La MAC que en la petición era 00:00:00:00:00:00 pasa a ser la dirección de origen y toma el valor de la MAC del equipo que responde.

A diferencia de la petición, la trama que encapsula la respuesta ya no usa la dirección de broadcast, porque el emisor conoce la MAC a la que debe enviarla.

## GARP (*Gratuitous ARP*)

Es cuando un equipo difunde su dirección MAC al resto sin que nadie se lo haya pedido. Puede hacerse de dos maneras:

- Mediante una solicitud ARP con SPA = TPA = IP del equipo, THA = 0 y SHA = MAC del equipo.
- Mediante una respuesta ARP con TPA = SPA = IP del equipo y THA = SHA = MAC del equipo.

## Caché ARP

Para reducir el número de consultas ARP, los equipos mantienen en una caché, para cada interfaz de red, la correspondencia entre IP y direcciones MAC de los equipos de su red.

- **Mostrar la tabla en Windows:** `arp -a`
- **Mostrar la tabla en Linux:** `arp` (disponible en el paquete `net-tools`) o `ip neigh`

La caché incluye entradas estáticas y dinámicas:

- **Estáticas:** las establece el administrador del equipo.
- **Dinámicas:** las aprende el equipo mediante peticiones ARP. Se pierden al reiniciar el equipo.

Las entradas dinámicas pueden eliminarse haciendo un *flush* de la caché, que requiere elevación de privilegios:

- En Windows: `arp -d`
- En Linux: `ip -s -s neigh flush all`

En ambos casos se borra la caché de todas las interfaces de red, aunque también es posible borrar solo la de una interfaz concreta.
