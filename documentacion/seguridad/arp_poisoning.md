# ARP poisoning

También conocido como **ARP spoofing**. Es una técnica para situarse en medio de la comunicación en una red local con switch y poder hacer sniffing.

## Funcionamiento

Un atacante situado en la misma LAN engaña a una víctima haciéndole creer que él tiene la dirección MAC de otro equipo de la red, al que se llama *objetivo*, de forma que las tramas lleguen al atacante en lugar de al objetivo.

El ataque consiste en enviar respuestas ARP de manera constante a la víctima para que crea que la IP del objetivo está asociada a la MAC del atacante. Así, la víctima encapsula los paquetes IP dirigidos a esa IP en tramas dirigidas al atacante. Hay que enviarlas de forma continuada porque las entradas de la caché ARP caducan o se actualizan.

## Man in the middle completo

Con el ataque anterior, los mensajes que el objetivo envía a la víctima no pasan por el atacante. Para lograr un auténtico ataque *man in the middle*, hay que lanzar otro ataque simultáneo con los papeles de víctima y objetivo intercambiados.

Es frecuente elegir la puerta de enlace como objetivo y así espiar el tráfico que la víctima envía hacia fuera de la red, que suele ser el tráfico más interesante.

## Herramienta

En Linux se utiliza `arpspoof`, del paquete `dsniff`:

```sh
arpspoof [-i interfaz] [-c own|host|both] [-t víctima] [-r] host
```

Los corchetes indican que el parámetro es opcional.

- `-i`: interfaz a utilizar.
- `-c`: limpieza que se realiza al terminar el ataque. Si no se especifica, es `own` por defecto.
- `-t`: IP de la víctima. Se puede poner más de una. Si no se especifica, todos los equipos de la red son objetivo.
- `-r`: ataca a la víctima y al objetivo para capturar el tráfico en ambos sentidos.
- `host`: IP del equipo cuya identidad se suplanta (el objetivo).

## Protección

- Establecer entradas ARP estáticas, por ejemplo para la puerta de enlace en cada equipo.
- Cifrar las comunicaciones para que, aunque se intercepten, no se puedan leer.
- Usar switches con inspección dinámica de ARP (*Dynamic ARP Inspection*) y seguridad de puertos.
- Monitorizar la red para detectar cambios anómalos en la asociación entre IP y MAC.
