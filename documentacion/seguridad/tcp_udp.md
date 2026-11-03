# Protocolos TCP y UDP

## Clasificación de protocolos

- **Protocolo fiable:** aquel que informa al emisor de si el paquete fue entregado.
- **Protocolo orientado a conexión:** aquel que requiere establecer una conexión (permanente o semipermanente) antes de empezar a comunicarse, con el fin de garantizar que los mensajes llegan al destinatario en el mismo orden en que salieron del emisor.

IP, ICMP y UDP no son fiables ni orientados a conexión. TCP es fiable y orientado a conexión. HTTP es un protocolo de aplicación que se apoya en TCP y no ofrece por sí mismo ninguna de las dos propiedades.

## Puertos y conexiones

TCP y UDP incorporan el concepto de **puerto**. Cada puerto se identifica con un número de 16 bits (entre 0 y 65535). En cada equipo se vincula un programa a un número de puerto concreto, de forma que ese programa procesa los datos que lleguen a ese puerto y posiblemente responde algo. Solo puede haber un programa vinculado a cada puerto simultáneamente.

Una conexión TCP (o UDP) viene definida por un cuarteto: **IP local, puerto local, IP remota y puerto remoto**. Una misma máquina no puede establecer simultáneamente dos o más conexiones con esos cuatro parámetros idénticos.

## Protocolo UDP

UDP no ofrece acuses de recibo, ni orden, ni conexión. Su segmento es muy sencillo: puerto de origen, puerto de destino, longitud, suma de comprobación y datos.

## Protocolo TCP

TCP garantiza fiabilidad y orientación a conexión mediante:

- Un mecanismo para establecer una conexión y otro para finalizarla.
- Números de secuencia en cada segmento.
- Acuses de recibo (ACK).
- Un búfer de recepción en cada extremo para almacenar temporalmente los segmentos y reordenarlos en caso de que lleguen desordenados antes de entregarlos a la aplicación.

### Campos de un segmento TCP

- **Source Port:** puerto de origen desde el que se envía el segmento.
- **Destination Port:** puerto de destino al que se envía el segmento.
- **Sequence Number:** número del byte que viaja en primera posición en el campo de datos de este segmento.
- **Acknowledgement Number:** indica cuál es el siguiente byte que se espera recibir, confirmando que todos los anteriores se recibieron correctamente.
- **Window Size:** cantidad de bytes que el otro extremo puede enviar sin esperar confirmación.
- **Flags:** campos de 1 bit.
- **Data:** datos que se envían en el segmento.

### Flags de interés

- **PSH (*Push*):** indica al otro extremo que este segmento debería ser procesado por la aplicación tan pronto como sea posible.
- **ACK (*Acknowledgement*):** indica que el campo Acknowledgement Number de este segmento contiene información relevante.
- **RST (*Reset*):** indica que se ha recibido un segmento inesperado y que la conexión debe reiniciarse.
- **SYN:** se utiliza para solicitar la apertura de una conexión.
- **FIN:** se utiliza para señalizar el cierre de la conexión.

### Window Size

Sería un desperdicio de ancho de banda que, en las redes actuales (*full-duplex*), una comunicación entre dos extremos funcionara como un partido de tenis, con un único segmento TCP en el cable cada vez. Para evitarlo existe el campo Window Size, que indica la cantidad de bytes que el otro extremo puede enviar sin tener que esperar el acuse de lo enviado anteriormente.

El servidor tiene un búfer por cada conexión (el cliente tiene uno análogo) en el que almacena los segmentos recibidos que esperan a ser procesados por la aplicación asociada. Cada vez que envía un segmento al otro extremo, le informa de la cantidad máxima de bytes que puede recibir sin que se desborde el búfer.

**Ejemplo:**

- El servidor tiene un búfer de 40 bytes. En el establecimiento de la conexión envía Window Size = 40 en el segmento con SYN.
- Recibe 15 bytes, pero está demasiado ocupado para procesarlos o responder con un ACK. El búfer tiene 15 bytes ocupados.
- Recibe otros 10 bytes. Procesa 20 (los 15 que ya tenía y 5 de los 10 recién llegados). Envía un acuse de recibo de todo lo recibido hasta el momento (el número de secuencia del primer segmento aún no confirmado más 25) y pone Window Size = 40 - 5 = 35. Así informa de que, como máximo, puede recibir 35 bytes sin tener que esperar confirmaciones.

### Establecimiento de una conexión

Cada extremo decide aleatoriamente el número de secuencia inicial (ISN) que va a utilizar y lo envía al otro extremo en un segmento con el bit SYN a 1. El proceso consta de tres segmentos:

- El cliente envía un segmento con SYN.
- El servidor responde con un segmento con SYN y ACK.
- El cliente envía un segmento con ACK.

### Finalización de una conexión

Cada extremo señaliza el cierre de su sentido de la comunicación enviando un segmento con el flag FIN, que el otro extremo confirma con un ACK. Una conexión también puede cerrarse de forma abrupta mediante un segmento con el flag RST.
