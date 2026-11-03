# Sniffing

Un *sniffer* es un dispositivo con una tarjeta de red en **modo promiscuo** que monitoriza todo el tráfico que circula por su dominio de colisión. En modo promiscuo, la tarjeta de red eleva a la capa IP el contenido de todas las tramas que detecta en el cable, incluso las que tienen como MAC de destino una distinta a la suya.

Un dominio de colisión es la parte de un segmento de red en la que solo debe haber una trama viajando por el cable en cada instante. Si hubiera varias, se produce una colisión, ambas se corrompen y el mensaje no llega a su destino.

## Sniffing según el tipo de red

**Red Ethernet con hub:** el dominio de colisión es toda la red, por lo que cada trama se difunde a todos los dispositivos conectados, también al atacante. Hacer sniffing es tan trivial como lanzar un programa de captura, por ejemplo Wireshark.

**Red Wi-Fi:** técnicamente hay un dominio de colisión por cada punto de acceso, así que el sniffing es inmediato si la red no utiliza cifrado. Si utiliza WPA (1 o 2), el atacante debe, por un lado, estar dentro de la red (conocer la contraseña) y, por otro, tener el adaptador en modo monitor para capturar el *handshake* que se produce entre el punto de acceso y la víctima cuando esta se conecta, ya que en ese momento se intercambian las claves temporales que usarán para comunicarse de forma cifrada.

**Red Ethernet con switch:** los hubs están en franco desuso y han sido sustituidos por switches. En un switch, cada boca es un dominio de colisión, lo que supone una dificultad añadida para el sniffing, pero no lo impide. En este tipo de redes, el sniffing requiere un ataque de ARP poisoning para situarse en medio de la comunicación (*man in the middle*).

## Cómo dificultar el sniffing

- **Red Wi-Fi:** no se puede impedir que se capture el tráfico, pero el cifrado protege su contenido.
- **Red Ethernet con hub:** no se puede impedir.
- **Red Ethernet con switch:** estableciendo entradas ARP estáticas. En redes grandes es inviable, pero puede ser factible en cada equipo establecer una entrada ARP estática para su puerta de enlace, lo que protege el sentido de la comunicación equipo hacia puerta de enlace.

Como medidas complementarias, el cifrado de las comunicaciones (HTTPS, SSH, VPN) protege el contenido aunque el tráfico sea capturado, y los switches gestionables ofrecen funciones como la inspección dinámica de ARP y la seguridad de puertos.
