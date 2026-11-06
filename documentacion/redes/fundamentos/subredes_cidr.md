# Subredes IPv4 y CIDR

Una subred IPv4 es un bloque de direcciones definido por una dirección de red y una máscara. CIDR (*Classless Inter-Domain Routing*) representa la máscara como un prefijo `/n`, donde `n` indica cuántos bits identifican la red.

## Máscara y tamaño del bloque

En una subred convencional, los bits iniciales de la máscara son `1` (red) y los restantes son `0` (hosts). Si el prefijo es `/n`, quedan `32 - n` bits para direcciones de host. El bloque contiene $2^{32-n}$ direcciones; en la mayoría de subredes se reservan la dirección de red y la de difusión, por lo que hay $2^{32-n}-2$ direcciones de host utilizables.

La fórmula de hosts no se aplica de forma ordinaria a `/31`, usado en enlaces punto a punto según RFC 3021, ni a `/32`, que identifica una sola dirección.

## Ejemplo de cálculo

Para `192.168.10.0/26`:

- La máscara es `255.255.255.192`.
- El bloque contiene 64 direcciones, porque $2^{32-26}=64$.
- El rango va de `192.168.10.0` a `192.168.10.63`.
- La dirección de red es `192.168.10.0` y la de difusión `192.168.10.63`.
- En una LAN convencional, las direcciones asignables son `192.168.10.1` a `192.168.10.62`.

El tamaño del bloque en el último octeto es `256 - 192 = 64`; los límites de subred comienzan en múltiplos de 64. Para prefijos menores que `/24`, el cálculo puede afectar a otros octetos y conviene convertir la máscara a binario o usar una calculadora verificada.

## Planificación de subredes

- La cantidad actual y futura de dispositivos por segmento debe estimarse.
- Debe elegirse un bloque privado que no se solape con redes locales, VPN o sedes conectadas.
- Las subredes deben asignarse por función o nivel de confianza, y deben documentarse la puerta de enlace, DHCP y las direcciones reservadas.
- Debe comprobarse que cada bloque esté alineado con el tamaño del prefijo y que no existan solapamientos.
- Las rutas y reglas de cortafuegos entre segmentos deben revisarse.

Las direcciones privadas definidas por RFC 1918 son `10.0.0.0/8`, `172.16.0.0/12` y `192.168.0.0/16`. Su uso privado no garantiza que dos redes conectadas no se solapen; el plan de direccionamiento debe documentarse antes de crear túneles o interconexiones.
