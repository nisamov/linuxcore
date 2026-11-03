# ICMP Redirect

## Funcionamiento

Es un mecanismo por el que un router informa a un equipo de que debe actualizar su información de enrutamiento porque podría enviar sus paquetes de una manera más directa. Por ejemplo, un equipo envía un paquete a un destino a través de un router y este, al darse cuenta de que existe otro router de la misma red que lo comunica mejor, reenvía el paquete y envía al origen un mensaje ICMP Redirect indicando la IP del router al que debe enviar en el futuro esos paquetes.

## Ataque

Este mecanismo puede pervertirse para hacer creer a un equipo víctima que puede enviar sus mensajes a un destino de forma más directa, logrando así que los paquetes que envía pasen por un equipo controlado por el atacante.

- El ataque debe mantenerse en el tiempo, porque de lo contrario el equipo víctima volverá a comunicarse como lo hacía antes.
- La víctima puede ser tanto un equipo como un router.

Si el ataque tiene éxito, el atacante recibe los paquetes que la víctima envía a cierto destino. Puede optar por:

- **Descartar el paquete**, negando a la víctima la posibilidad de comunicarse.
- **Espiar todo paquete** que pase por sus manos y transmitirlo a su destino. En este caso se trata de un ataque *medio* man-in-the-middle, porque el atacante puede leer lo que la víctima envía, pero no lo que recibe como respuesta.
- **Fingir ser el destinatario** del mensaje y responder haciéndose pasar por él.

## Situación actual

Ni Windows con su cortafuegos activado, ni Linux (incluso sin cortafuegos) son vulnerables a mensajes ICMP Redirect fuera de contexto, pero lo serían ante ataques bien sincronizados.

## Mitigación

Para hacer que un equipo sea invulnerable a ICMP Redirect, se puede configurar el sistema para que ignore por completo este tipo de mensajes.

**En Windows**, mediante la clave de registro:

```ps1
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\EnableICMPRedirect = 0
```

**En Linux**, poniendo a 0 el parámetro `accept_redirects`:

```sh
# Para todas las interfaces
sysctl -w net.ipv4.conf.all.accept_redirects=0

# Para una interfaz concreta (por ejemplo, eth0)
sysctl -w net.ipv4.conf.eth0.accept_redirects=0
```

Con `sysctl -w` el cambio no es persistente: para mantenerlo tras reiniciar hay que añadir el parámetro a `/etc/sysctl.conf` o a un fichero de `/etc/sysctl.d/`.
