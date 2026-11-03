# Protocolo Ethernet

## Formato de una trama

- **Destination MAC Address (6 bytes):** dirección MAC del dispositivo destinatario.
- **Source MAC Address (6 bytes):** dirección MAC del equipo remitente.
- **EtherType:** indica el protocolo del mensaje encapsulado en el payload de la trama. Por ejemplo, IPv4 es 0x0800, IPv6 es 0x86DD y ARP es 0x0806.
- **Payload (46 a 1500 bytes):** carga de datos de la trama.
- **CRC Checksum:** CRC32 del resto de la trama. El destinatario calcula el CRC32 de la trama recibida y lo compara con este campo. Si no coincide, la trama llegó corrupta.

## Dirección MAC

Todo dispositivo de red tiene una tarjeta de red con una dirección MAC (*Medium Access Control*), que debe ser única dentro de su red (en el sentido de nivel 2 del modelo OSI).

## Nivel físico

A nivel físico (nivel 1 de OSI), la trama va precedida por:

- **Preámbulo:** siete bytes con el valor 10101010.
- **Start Of Frame:** un byte con el valor 10101011.

Además, hay un símbolo que indica el fin de la trama, necesario entre otros motivos porque no existe en la cabecera un campo que indique la longitud del payload o de la trama.

## Encapsulación de IP en una trama

Un equipo que envía un paquete IPv4 debe encapsularlo en el campo de datos de una trama propia de la capa de enlace de datos (nivel 2 de OSI). Si el paquete no cabe en una trama, debe fragmentarlo.

Al rellenar el campo Destination MAC Address, el equipo necesita conocer la MAC del destinatario de la trama:

- Si el equipo destinatario está en la misma red que el remitente, se pone la MAC del destinatario.
- Si está en otra red, se pone la MAC de la puerta de enlace predeterminada.
