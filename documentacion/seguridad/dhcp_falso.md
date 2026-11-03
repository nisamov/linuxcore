# Suplantación de servidor DHCP

Es un ataque de monitorización en el que el atacante se hace pasar por un servidor DHCP para engañar a otros equipos de la red y hacerles creer que él es la puerta de enlace.

## Funcionamiento

- Cuando un equipo se conecta a la red, difunde una solicitud DHCP para obtener su configuración (IP, máscara, puerta de enlace, DNS, etc.).
- El atacante, que está en la misma red local, responde antes que el servidor legítimo con una configuración en la que la puerta de enlace (o el servidor DNS) es una máquina suya.
- Los equipos que aceptan esa respuesta envían su tráfico hacia el exterior a través del atacante, que puede espiarlo o modificarlo.

## Protección

Los switches gestionables disponen de la función **DHCP snooping**, que es una medida defensiva: solo permite respuestas DHCP procedentes de las bocas marcadas como de confianza, donde está el servidor legítimo.
