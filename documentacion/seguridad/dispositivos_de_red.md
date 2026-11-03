# Dispositivos de red

## Conceptos

- **Colisión:** tiene lugar cuando más de un dispositivo intenta enviar una trama al mismo tiempo.
- **Dominio de colisión:** porción de red en la que puede ocurrir una colisión.
- **Dominio de broadcast:** porción de red en la que cualquier equipo puede alcanzar a otro mediante un mensaje de difusión (*broadcast*).

## Tipos de dispositivos

- **Repetidor:** amplifica la señal, que pierde potencia con la distancia.
- **Hub:** conecta varios dispositivos entre sí.
- **Bridge (puente):** conecta dos redes que son distintas a nivel de capa de enlace de datos. Por ejemplo, una red Wi-Fi con una red Ethernet.
- **Switch (conmutador):** conecta varios dispositivos entre sí, pero de forma más inteligente que un hub.
- **Router:** comunica redes que son distintas a nivel de capa de red.

## Diferencias entre hub y switch

Cuando un hub recibe una trama por una boca, la difunde por todas las demás. Por tanto, todos los equipos conectados a un hub comparten dominio de colisión y también de difusión.

Un switch lee la dirección MAC de destino de la trama entrante y la saca por una única boca: la que lo conecta con el dispositivo destinatario. Este conocimiento de la red a nivel 2 lo adquiere durante su funcionamiento, anotando en una tabla en su RAM la MAC de origen de cada trama y la boca por la que le llega.

- Cuando un switch se apaga, los datos de su RAM se pierden, por lo que un switch recién arrancado debe volver a aprender desde cero qué boca lo comunica con cada MAC.
- Si recibe una trama destinada a una MAC y todavía no sabe por qué boca transmitirla, la difunde por todas las bocas salvo la de entrada. Hasta que es capaz de asociar una MAC de destino a una boca, se comporta como un hub.
- Un switch que lleva tiempo funcionando y conoce a fondo su red hace **microsegmentación**, ya que cada una de sus bocas es un dominio de colisión en sí misma.
- Si además es *full-duplex*, la posibilidad de colisiones es nula: todos los equipos conectados pueden hablar al mismo tiempo.

## Resumen por dispositivo

- **Repetidor:** nivel OSI 1, 2 bocas, 1 dominio de colisión y 1 de broadcast.
- **Hub:** nivel OSI 1, N bocas, 1 dominio de colisión y 1 de broadcast.
- **Bridge:** nivel OSI 2, 2 bocas, 2 dominios de colisión y 1 de broadcast.
- **Switch:** nivel OSI 2, N bocas, N dominios de colisión y 1 de broadcast.
- **Router:** nivel OSI 3, N bocas, N dominios de colisión y N de broadcast.

En bridge, switch y router, si son *full-duplex*, el número de dominios de colisión efectivo es 0, es decir, no hay posibilidad de colisión.
