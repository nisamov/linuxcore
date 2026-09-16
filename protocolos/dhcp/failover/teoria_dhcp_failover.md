# DHCP Failover

## Parámetros generales

### ISC DHCP

Instalación y activación:

```sh
sudo apt update
sudo apt install isc-dhcp-server
sudo systemctl enable isc-dhcp-server
sudo systemctl start isc-dhcp-server
sudo systemctl status isc-dhcp-server
```

Configuracion de puerto y salida de datos
```sh
sudo nano /etc/default/isc-dhcp-server
```

```conf
# Generalmente se pone enp0s3 (depende de la maquina)
INTERFACESv4=""
INTERFACESv6=""
```


Archivo principal de configuración:
```text
/etc/dhcp/dhcpd.conf
```

> [!NOTE]
> ISC DHCP está fuera de soporte (*End of Life*) desde 2022. Su sucesor es **ISC Kea**.
>
> El mecanismo de **DHCP Failover de ISC DHCP** está diseñado para trabajar con **dos servidores DHCP**: un `primary` y un `secondary`. Esto no significa que una red no pueda tener más de dos servidores DHCP, sino que el protocolo Failover de ISC DHCP solamente sincroniza dos servidores entre sí.

---

## Configuración de un único servidor

Una configuración básica de DHCP puede ser:

```conf
subnet 192.168.1.0 netmask 255.255.255.0 {

    option routers 192.168.1.1;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 8.8.8.8, 8.8.4.4;

    range 192.168.1.10 192.168.1.200;

    max-lease-time 3600;
    default-lease-time 600;
}

host equipoFijo {

    hardware ethernet xx:xx:xx:xx:xx:xx;
    fixed-address 192.168.1.4;
}
```

En esta configuración:

* `subnet` define la red que administra el servidor DHCP.
* `option routers` indica la puerta de enlace que recibirán los clientes.
* `option subnet-mask` indica la máscara de red.
* `option domain-name-servers` indica los servidores DNS que utilizarán los clientes.
* `range` define el rango de direcciones que pueden ser asignadas dinámicamente.
* `max-lease-time` establece el tiempo máximo de una concesión DHCP.
* `default-lease-time` establece el tiempo de concesión utilizado por defecto.
* `host` permite realizar una asignación fija para un equipo concreto mediante su dirección MAC.

---

# DHCP Failover

DHCP Failover permite mantener dos servidores DHCP sincronizados proporcionando redundancia y, opcionalmente, reparto de carga.

La arquitectura básica es:

```text
             Red principal
          ┌────────┴────────┐
    DHCP Primario       DHCP Secundario
     192.168.1.2         192.168.1.3
          └────── Failover ─┘
```

Los dos servidores mantienen información sobre las concesiones DHCP para poder continuar proporcionando servicio cuando uno de ellos deja de estar disponible.

El protocolo de Failover utiliza el **puerto TCP 647** para la comunicación entre ambos servidores.

---

## Configuración del servidor Primary

```conf
failover peer "dhcp-failover" {
    primary;
    address 192.168.1.2;
    port 647;
    peer address 192.168.1.3;
    peer port 647;
    split 128;
    mclt 1800;
    max-response-delay 8;
    max-unacked-updates 2;
    load balance max seconds 3;
}

subnet 192.168.1.0 netmask 255.255.255.0 {
    option routers 192.168.1.1;
    option subnet-mask 255.255.255.0;
    option broadcast-address 192.168.1.255;
    pool {
        failover peer "dhcp-failover";
        range 192.168.1.100 192.168.1.130;
        max-lease-time 3600;
        default-lease-time 600;
    }
}
```

### Parámetros del Failover

* `primary`: Indica que este servidor es el servidor principal de la pareja de Failover.
* `secondary`: Indicador de que el servidor es el secundario.
* `address`: Dirección IP local utilizada por el servidor para la comunicación de Failover: `address 192.168.1.2;`
* `peer address`: Dirección IP del servidor secundario: `peer address 192.168.1.3;`
* `port` / `peer port`: Puerto utilizado para la comunicación entre los servidores DHCP:
    * `port 647;`
    * `peer port 647;`
* `split`: Determina cómo se distribuyen las concesiones entre los dos servidores cuando trabajan en modo **load balance**.
    * `split 128;`: Representa un reparto aproximadamente equilibrado.
    * `split 255;` Favorece al `primary` y no representa un reparto equilibrado de la carga.
* `mclt`: (Maximum Client Lead Time) Es el tiempo máximo durante el cual un servidor puede extender una concesión más allá de lo que el otro servidor conoce en determinadas situaciones de comunicación.
  * `mclt 1800;`: Equivale a: 1800 segundos = 30 minutos, es uno de los mecanismos que permiten controlar las concesiones cuando los dos servidores dejan temporalmente de estar sincronizados.
* `max-response-delay`: Tiempo máximo que un servidor espera una respuesta del otro servidor durante la comunicación de Failover.
* `max-unacked-updates`: Número máximo de actualizaciones de concesiones que pueden quedar sin confirmar por el servidor compañero.
* `load balance max seconds`: Controla durante cuánto tiempo un servidor puede esperar una respuesta del otro servidor cuando ambos están funcionando en modo de balanceo de carga.

## Configuración del servidor Secondary

La configuración del servidor secundario debe utilizar `secondary` y tener invertidas las direcciones de los servidores:

```conf
failover peer "dhcp-failover" {
    secondary;
    address 192.168.1.3;
    port 647;
    peer address 192.168.1.2;
    peer port 647;
    split 128;
    mclt 1800;
    max-response-delay 8;
    max-unacked-updates 2;
    load balance max seconds 3;
}

subnet 192.168.1.0 netmask 255.255.255.0 {
    option routers 192.168.1.1;
    option subnet-mask 255.255.255.0;
    option broadcast-address 192.168.1.255;
    pool {
        failover peer "dhcp-failover";
        range 192.168.1.100 192.168.1.130;
        max-lease-time 3600;
        default-lease-time 600;
    }
}
```

Los dos servidores deben utilizar el mismo nombre para el `failover peer`:

```conf
failover peer "dhcp-failover"
```

y deben definir el mismo rango DHCP dentro del `pool`.

### Hot Standby

Un servidor atiende normalmente las solicitudes mientras el otro permanece preparado para asumir el servicio si el primero falla.

# Estados del Failover

Los servidores mantienen un estado que describe la situación de la relación entre ambos.

* `startup`
* `normal`:
  * Los dos servidores están funcionando y pueden comunicarse y sincronizarse correctamente.
* `communications-interrupted`:
  * Los dos servidores siguen funcionando, pero han perdido temporalmente la comunicación entre ellos, cada servidor puede continuar proporcionando servicio utilizando las concesiones que tiene disponibles.
* `partner-down`:
  * Uno de los servidores determina que su compañero está caído y puede asumir las responsabilidades correspondientes.
  * Este estado debe utilizarse con cuidado, ya que si ambos servidores consideran que el otro está caído puede producirse una situación de **split-brain**, donde ambos intentan administrar las mismas concesiones.
  * Ventajas:
    * Redundancia del servicio DHCP.
    * Mayor disponibilidad.
    * Posibilidad de repartir la carga entre dos servidores.
    * Sincronización de las concesiones entre los servidores.
    * Permite mantener el servicio ante la caída de uno de los servidores.
  * Inconvenientes:
    * Mayor complejidad que un servidor DHCP independiente.
    * Requiere sincronización entre los dos servidores.
    * Hay que comprender los estados del protocolo Failover.
    * Una configuración incorrecta puede provocar conflictos de concesiones.
    * El mecanismo Failover de ISC DHCP está limitado a una pareja de servidores.
    * ISC DHCP está fuera de soporte y para nuevos despliegues debe considerarse **Kea**.
* `potential-conflict`
* `recover`
* `paused`
* `shutdown`

# Comprobaciones

Comprobar la configuración antes de iniciar el servicio:
```bash
sudo dhcpd -t -cf /etc/dhcp/dhcpd.conf
```

Comprobar el estado del servicio:
```bash
sudo systemctl status isc-dhcp-server
```

Consultar los registros:
```bash
sudo journalctl -u isc-dhcp-server
```

Comprobar que el servidor está escuchando:
```bash
sudo ss -lntup | grep :67
```

Para comprobar la comunicación de Failover entre los servidores:
```bash
sudo ss -lntp | grep :647
```
