# VLAN: segmentación de redes Ethernet

Una VLAN (*Virtual Local Area Network*) separa lógicamente dominios de difusión en una infraestructura Ethernet compartida. La norma IEEE 802.1Q añade una etiqueta a las tramas para identificar la VLAN entre switches compatibles. La segmentación ayuda a organizar la red, pero por sí sola no cifra el tráfico ni sustituye las reglas de acceso.

## Puertos de acceso y troncales

- **Puerto de acceso:** transporta normalmente tráfico de una sola VLAN y conecta dispositivos finales.
- **Puerto troncal:** transporta varias VLAN etiquetadas entre switches, routers, hipervisores o puntos de acceso.
- **VLAN nativa:** en algunas configuraciones, el tráfico sin etiqueta de una troncal se asigna a una VLAN nativa. Ambos extremos deben coincidir y no se debe confiar en esa configuración como control de seguridad.

La etiqueta 802.1Q incluye un identificador de VLAN de 12 bits; los identificadores utilizables y reservados dependen de la norma y del fabricante. MTU, etiquetado y funciones disponibles deben comprobarse en todos los equipos del trayecto.

## Diseño y controles

Las VLAN deben diseñarse según función y nivel de confianza, por ejemplo, para gestión, usuarios, servidores, invitados y dispositivos IoT. Deben documentarse los flujos que necesitan comunicarse y aplicarse controles de capa 3 mediante un router o cortafuegos. Los puertos no utilizados deben configurarse de forma segura, las VLAN permitidas en cada troncal deben limitarse y debe evitarse el transporte de VLAN innecesarias.

Una VLAN mal configurada, un puerto de acceso asignado a la red equivocada o una troncal excesivamente permisiva pueden unir segmentos que debían permanecer separados. La VLAN no debe utilizarse como única barrera entre sistemas sensibles; deben añadirse autenticación, filtrado y monitorización.

## Cambios y verificación

Antes de modificar un switch, la configuración debe guardarse, el puerto de administración debe identificarse y los extremos de cada enlace troncal deben coordinarse. Un cambio incorrecto puede interrumpir la conectividad. Desde cada segmento deben verificarse la asignación de VLAN, el direccionamiento, los servicios esperados y el bloqueo de las comunicaciones no autorizadas. Para la sintaxis específica debe consultarse la guía del fabricante.
