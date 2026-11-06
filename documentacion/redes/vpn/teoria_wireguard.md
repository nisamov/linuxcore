# VPN con WireGuard: conceptos y configuración entre equipos propios

WireGuard es una VPN de capa 3 que crea interfaces de red cifradas entre pares. Utiliza claves públicas para identificar pares, claves privadas que deben mantenerse secretas y una lista de prefijos permitidos que también determina qué tráfico se enruta por cada par.

## Componentes y planificación

- **Interfaz:** dispositivo virtual que recibe una dirección IP y participa en el enrutamiento.
- **Par:** equipo remoto identificado mediante su clave pública.
- **Endpoint:** dirección IP o nombre DNS y puerto UDP donde se encuentra un par accesible.
- **AllowedIPs:** prefijos asociados al par; influyen en la selección de rutas y deben planificarse sin solapamientos accidentales.
- **PersistentKeepalive:** opción para mantener una asignación NAT activa cuando un extremo lo necesita; no es necesaria en todos los diseños.

Antes de configurarla, deben definirse las direcciones de túnel, redes internas permitidas, puertos UDP, rutas y reglas de firewall. También debe confirmarse que las redes locales de ambos extremos no se solapan y que existe autorización para administrar cada dispositivo.

## Ejemplo conceptual de configuración

Este fragmento utiliza valores de documentación y marcadores; no es una configuración lista para producción. La clave privada debe generarse localmente con las herramientas oficiales de WireGuard y guardarse con permisos restrictivos. Esa clave no debe compartirse ni incluirse en un repositorio.

```ini
[Interface]
Address = 10.77.0.1/24
ListenPort = 51820
PrivateKey = <CLAVE_PRIVADA_LOCAL>

[Peer]
PublicKey = <CLAVE_PUBLICA_DEL_PAR>
AllowedIPs = 10.77.0.2/32
Endpoint = <DIRECCION_DEL_PAR>:51820
```

El ejemplo representa un extremo; el par necesita su propia configuración coherente y, si corresponde, una regla de cortafuegos que permita el tráfico UDP del túnel. No abras el reenvío IP ni anuncies rutas a redes internas sin revisar primero la política de acceso.

## Verificación y mantenimiento

El estado del túnel debe verificarse con las herramientas de WireGuard; también deben comprobarse el último intercambio de claves y las rutas autorizadas. La resolución de nombres, la MTU y el acceso a los servicios requeridos deben probarse sin exponer más subredes de las necesarias.

Las claves deben rotarse cuando exista sospecha de exposición, los pares que ya no se utilicen deben eliminarse y las copias de configuración deben protegerse. WireGuard cifra el túnel, pero la seguridad también depende de los equipos finales, el firewall, las rutas y la gestión de claves.
