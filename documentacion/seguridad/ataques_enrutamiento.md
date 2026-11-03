# Ataques a protocolos de enrutamiento y túnel ICMP

## Ataques a protocolos de enrutamiento

Si los routers utilizan enrutamiento dinámico, se intercambian información para actualizar las rutas mediante protocolos como:

- RIP
- OSPF
- BGP

Explotando vulnerabilidades presentes en estos dispositivos o protocolos es posible redirigir el tráfico hacia un determinado equipo, de modo que pase por un sistema controlado por el atacante o se pierda por el camino.

## ICMP tunneling

Consiste en ocultar tráfico dentro de mensajes ICMP con el fin de dificultar que pueda ser bloqueado por cortafuegos intermedios o detectado por sistemas de detección de intrusos o SIEM.

La herramienta **Loki** encapsula y desencapsula tráfico entre dos extremos de esta manera.

Como medida de detección, conviene vigilar mensajes ICMP anómalos, por ejemplo con un tamaño o una frecuencia inusuales, o con contenido que no corresponde a un eco normal.
