# Protocolo IPv4

Los datagramas UDP, los segmentos TCP y los mensajes ICMP van encapsulados dentro de un paquete IP. IP no es fiable ni orientado a conexión.

## Estructura del paquete

El paquete IPv4 consta de una cabecera de 20 bytes, unas opciones de 0 a 40 bytes y los datos que transporta. El tamaño total del paquete puede llegar a 65535 bytes. Entre los campos de la cabecera están la dirección IP de origen (*source*), la de destino (*destination*), el protocolo encapsulado, el TTL y los campos de fragmentación.

### Campo TTL

El emisor del paquete escribe un valor en el campo TTL (*Time To Live*). Cada vez que el paquete llega a un router, este reduce el TTL en una unidad. El router que pone el TTL a 0 descarta el paquete y envía un mensaje ICMP de tipo 11 (*Time Exceeded*) a la IP que figuraba como origen del paquete.

### Campo Protocol

Cada protocolo que puede ir encapsulado en un paquete IP se identifica con un código único definido por IANA. Por ejemplo, 1 es ICMP, 6 es TCP y 17 es UDP.

## Fragmentación

### MTU

Cada tipo de red tiene un tamaño máximo para los datos que puede transportar una trama. Ese valor se llama **MTU** (*Maximum Transfer Unit*).

- Ethernet (802.3): 1500 bytes.
- Wi-Fi (802.11): 2304 bytes.
- Gigabit Ethernet (802.3ab): hasta 9000 bytes.

IPv4 (y también IPv6) permite interconectar redes con MTU diferentes. Si un paquete pasa de una red con cierta MTU a otra con mayor MTU, no hay problema. Si debe pasar a una red con una MTU más pequeña, el router que conecta ambas redes **fragmenta** el paquete en tantos paquetes como sea necesario para que ninguno supere la MTU de la red a la que entra.

### Campos relevantes

- **Flags (3 bits):**
  - El primer bit está reservado y debe valer siempre 0.
  - El segundo es **DF** (*Don't Fragment*): indica a los routers que no deben fragmentar el paquete. Si no cabe en la MTU del siguiente segmento de red, el router lo descarta.
  - El tercero es **MF** (*More Fragments*): indica que vienen más fragmentos después de este.
- **Identification (16 bits):** combinado con los campos *source*, *destination* y *protocol*, constituye un identificador único. Todos los fragmentos de un mismo paquete llevan el mismo valor, lo que ayuda al receptor a reconstruir el paquete original.
- **Fragment offset (13 bits):** número, expresado en bloques de 8 bytes, que indica la posición del primer bloque de datos de este fragmento respecto al paquete original sin fragmentar.

El valor máximo del offset es 2^13 - 1 = 8191, que multiplicado por 8 da 65528. Este valor es mayor que la máxima carga de datos de un paquete IPv4 (65535 - 20 = 65515 bytes, descontando la cabecera de 20 bytes), por lo que todo paquete puede fragmentarse sin que el campo offset se quede corto, incluso en el caso extremo de fragmentos de 8 bytes.

### Cálculo de fragmentos

Cada fragmento lleva una cabecera de la misma longitud que la del paquete original (20 bytes), por lo que la carga máxima de cada uno es MTU menos 20. Según el estándar, la carga de todos los fragmentos, salvo el último, debe ser múltiplo de 8. Si (MTU menos cabecera) no es divisible entre 8, se usa el múltiplo de 8 inmediatamente inferior.

**Ejemplo:** un paquete con una carga de 8540 bytes y una cabecera de 20 bytes (longitud total 8560) llega a un router y debe pasar a una red Ethernet con MTU de 1500 bytes. La carga máxima por fragmento es 1500 - 20 = 1480, que es divisible entre 8 (185 bloques). Se divide en seis fragmentos con el mismo valor de Identification (por ejemplo, 0xA023):

```txt
Fragmento 1: DF=0, MF=1, offset 0, carga 1480, longitud total 1500.
Fragmento 2: DF=0, MF=1, offset 185, carga 1480, longitud total 1500.
Fragmento 3: DF=0, MF=1, offset 370, carga 1480, longitud total 1500.
Fragmento 4: DF=0, MF=1, offset 555, carga 1480, longitud total 1500.
Fragmento 5: DF=0, MF=1, offset 740, carga 1480, longitud total 1500.
Fragmento 6: DF=0, MF=0, offset 925, carga 1140, longitud total 1160.
```

La carga total es 8540 bytes y el total de bytes enviados es 8660 (8540 más seis cabeceras de 20 bytes).

**Ejercicio resuelto:** un router debe enrutar un paquete IPv4 de longitud total 4070 bytes (cabecera de 20 bytes) por una interfaz con MTU de 1370 bytes.

- La carga original es 4070 - 20 = 4050 bytes.
- La carga máxima por fragmento sería 1370 - 20 = 1350, pero no es divisible entre 8, así que se usa el múltiplo de 8 inferior: 1344 bytes (168 bloques).
- Se divide en **4 paquetes**: tres con 1344 bytes de carga y uno con los 18 bytes restantes (4050 - 3 x 1344 = 18).
- Longitudes totales: 1364, 1364, 1364 y 38 bytes.
- Offsets: 0, 168, 336 y 504. MF=1 en los tres primeros y MF=0 en el último.
