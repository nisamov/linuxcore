# Protocolo ICMP

ICMP (*Internet Control Message Protocol*) es un protocolo de soporte que sirve, entre otras cosas, para comprobar si hay comunicación entre dos equipos. Los mensajes ICMP van encapsulados dentro de paquetes IP.

## Tipos de mensaje relevantes

Existen varios tipos de mensajes ICMP. En el contexto del escaneo de redes los más interesantes son:

- **Echo Request (tipo 8):** solicitud de eco.
- **Echo Reply (tipo 0):** respuesta al eco.
- **Time Exceeded (tipo 11):** lo envía el router que descarta un paquete porque su TTL ha llegado a 0.

## Formato del mensaje

Un mensaje ICMP tiene los siguientes campos:

- **Type (8 bits):** tipo de mensaje.
- **Code (8 bits):** subtipo dentro del tipo.
- **Checksum (16 bits):** suma de comprobación.
- **Content:** contenido, que depende del tipo de mensaje.

## Clasificación

ICMP no es fiable ni orientado a conexión.
