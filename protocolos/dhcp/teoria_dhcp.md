# Protocolo DHCP

## DHCP Discover (Descubrimiento)

El cliente final se conecta a la red sin una dirección IP asignada. Para localizar un servidor DHCP disponible, transmite una solicitud en modo difusión (broadcast).

- Dirección IP Origen: 0.0.0.0
- Dirección IP Destino: 255.255.255.255
- Puerto Origen: 68
- Puerto Destino: 67

Descripción técnica: El cliente envía un paquete DHCPDISCOVER a toda la subred física. Incluye su dirección MAC física en el campo chaddr (Client Hardware Address) para que el servidor pueda identificarlo.

## DHCP Offer (Oferta)

Uno o varios servidores DHCP reciben el mensaje DHCPDISCOVER. Cada servidor reserva una dirección IP no asignada de su grupo de direcciones (pool) y envía una propuesta al cliente.

- Dirección IP Origen: IP del servidor DHCP (ej. 192.168.1.1)
- Dirección IP Destino: 255.255.255.255 (o unicast a la IP ofrecida/MAC según la implementación)
- Puerto Origen: 67
- Puerto Destino: 68

Descripción técnica: El servidor responde con un paquete DHCPOFFER que contiene la dirección IP propuesta (yiaddr - Your IP Address), la máscara de subred, el tiempo de concesión (Lease Time), la puerta de enlace predeterminada y los servidores DNS.

## DHCP Request (Solicitud)

El cliente evalúa las ofertas recibidas (generalmente acepta la primera que llega) y notifica formalmente al servidor seleccionado que acepta la dirección propuesta, informando implícitamente a los demás servidores que declina sus ofertas.

- Dirección IP Origen: 0.0.0.0
- Dirección IP Destino: 255.255.255.255
- Puerto Origen: 68
- Puerto Destino: 67

Descripción técnica: El cliente emite un mensaje DHCPREQUEST en broadcast. Incluye la opción Server Identifier para especificar cuál servidor fue elegido. El uso de broadcast permite que los demás servidores liberen las direcciones que habían reservado en sus ofertas.

## DHCP Acknowledgment (Reconocimiento)

El servidor seleccionado confirma el contrato de arrendamiento de la IP (Lease) y finaliza el proceso de configuración.

- Dirección IP Origen: IP del servidor DHCP
- Dirección IP Destino: 255.255.255.255 (o unicast)
- Puerto Origen: 67
- Puerto Destino: 68

Descripción técnica: El servidor envía un paquete DHCPACK ratificando la asignación de la IP y los parámetros de red adicionales. Una vez que el cliente recibe este paquete, vincula la IP a su interfaz de red y puede iniciar comunicaciones en la red IP. Si la IP ya no está disponible, el servidor responderá con un DHCPNAK (Negative Acknowledgment) y el proceso reiniciará desde el paso 1.

## Proceso de Renovación (Lease Renewal)

El tiempo de concesión (Lease Time) determina la validez de la asignación. El cliente busca renovar la dirección mediante el envío de mensajes DHCPREQUEST dirigidos por unicast directamente a su servidor:

- T1 (50% del tiempo de concesión): El cliente envía un DHCPREQUEST por unicast. Si el servidor responde con DHCPACK, el temporizador se reinicia.
– T2 (87.5% del tiempo de concesión): Si el servidor no respondió en T1, el cliente transmite un DHCPREQUEST por broadcast a cualquier servidor DHCP disponible.
- Expiración (100%): Si la concesión vence sin renovación, el cliente debe liberar la IP (DHCPRELEASE) y reiniciar el proceso completo DORA.
