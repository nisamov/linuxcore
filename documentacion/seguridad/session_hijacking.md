# Session hijacking

El atacante se apropia de una sesión ya establecida para eludir la fase de autenticación.

## Funcionamiento

Habitualmente el atacante se sitúa en medio de la comunicación (ataque *Man in the Middle*) para, en primer lugar, conocer los números de secuencia que se están usando y, después, introducir paquetes simulando ser el dispositivo original, de modo que los paquetes de respuesta lleguen al atacante.

Otra opción es utilizar un *sniffer* para conocer los números de secuencia de la comunicación y combinarlo con *source routing*, para que las respuestas lleguen al atacante en lugar de a la víctima.

## Blind hijacking

Se basa en intuir las respuestas, concretamente los números ISN (*Initial Sequence Numbers*) que se establecen cuando los dos sistemas inician la conexión TCP. Como los ISN se eligen aleatoriamente, cuanto más predecibles sean, más fácil es este ataque.

## Herramientas

- **Juggernaut** y **Hunt:** herramientas de secuestro de sesiones.
- **dsniff** y **ettercap:** para conexiones cifradas (SSH o SSL).

## Medidas de protección

- Usar números de secuencia iniciales realmente aleatorios.
- Cifrar y autenticar las comunicaciones.
- Evitar el *source routing*.
- Impedir que un atacante pueda situarse en medio de la comunicación.
