# Puertos de red en Linux: funcionamiento, clasificación y servicios

Los puertos de red son identificadores numéricos utilizados por los protocolos de transporte para permitir que un equipo gestione múltiples comunicaciones y servicios de red de forma simultánea.

Gracias a ellos, un mismo dispositivo puede ofrecer diferentes servicios utilizando una única dirección IP. Por ejemplo, un servidor Linux puede alojar un servidor web, un servidor SSH y un servidor DNS al mismo tiempo, cada uno atendiendo las conexiones correspondientes.

Los puertos trabajan principalmente junto a los protocolos **TCP (Transmission Control Protocol)** y **UDP (User Datagram Protocol)**, que permiten identificar el destino de los datos dentro de una comunicación de red.

Es importante entender que un puerto no representa una conexión física ni un servicio por sí mismo. Es un identificador lógico que permite al sistema operativo dirigir los datos hacia el socket correspondiente y, en consecuencia, hacia la aplicación que gestiona esa comunicación.

Un puerto es un número de 16 bits que identifica un punto de comunicación dentro de un equipo.

El rango de estos es de:
```txt
0 - 65535
```

Cada comunicación utiliza una combinación de elementos que permiten identificar su origen y destino:

- **Dirección IP de origen:** identifica el equipo que envía los datos.
- **Puerto de origen:** identifica el extremo de comunicación del emisor.
- **Dirección IP de destino:** identifica el equipo que recibe los datos.
- **Puerto de destino:** identifica el servicio al que se dirigen los datos.
- **Protocolo de transporte:** determina cómo se realiza la comunicación, por ejemplo, mediante TCP o UDP.

Por ejemplo:
```text
Origen:  192.168.1.20:53000
Destino: 192.168.1.10:22
Protocolo: TCP
```

En este escenario, un equipo con dirección IP `192.168.1.20` establece una conexión con el puerto `22` de otro equipo, utilizando TCP.
Normalmente, el puerto `53000` será un puerto temporal asignado al cliente, mientras que el puerto `22` corresponde al servicio SSH del servidor.
Esta combinación permite que un equipo mantenga numerosas comunicaciones simultáneas sin confundir los datos pertenecientes a cada conexión.

## Clasificación de los puertos

La IANA (Internet Assigned Numbers Authority) establece una clasificación oficial de los números de puerto en tres grandes categorías.

| Rango | Denominación | Descripción |
|---|---|---|
| 0 - 1023 | System Ports | Puertos de sistema, también conocidos como puertos bien conocidos. |
| 1024 - 49151 | User Ports | Puertos registrados para aplicaciones y servicios. |
| 49152 - 65535 | Dynamic / Private Ports | Puertos dinámicos o privados, utilizados habitualmente para comunicaciones temporales. |

### Puertos de sistema (0-1023)

Son los denominados *Well-Known Ports*.

Se trata de números de puerto asignados a servicios y protocolos de uso generalizado mediante los procedimientos de registro de IANA.

| Puerto | Protocolo | Servicio |
|---:|---|---|
| 20 | TCP | FTP - Data |
| 21 | TCP | FTP - Control |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP |
| 53 | TCP / UDP | DNS |
| 67 | UDP | DHCP Server (IPv4) |
| 68 | UDP | DHCP Client (IPv4) |
| 80 | TCP | HTTP |
| 110 | TCP | POP3 |
| 123 | UDP | NTP |
| 443 | TCP | HTTPS |
| 647 | TCP / UDP | DHCP Failover (registro IANA) |

No todos los números de este rango están asignados a un servicio.

Además, que un puerto esté registrado no significa que el servicio correspondiente esté activo en el equipo.

En Linux existe una particularidad adicional: tradicionalmente, los puertos inferiores a 1024 se consideran privilegiados. Por defecto, un proceso necesita privilegios de administrador o la capacidad `CAP_NET_BIND_SERVICE` para asociarse a ellos mediante una operación `bind()`.

Esta restricción es independiente de la asignación de puertos realizada por IANA.

### Puertos registrados (1024-49151)

Este rango está destinado a servicios y aplicaciones que necesitan utilizar un número de puerto registrado oficialmente.

| Puerto | Protocolo | Servicio |
|---:|---|---|
| 1433 | TCP | Microsoft SQL Server |
| 3306 | TCP | MySQL |
| 3389 | TCP / UDP | Remote Desktop Protocol (RDP) |
| 5432 | TCP | PostgreSQL |
| 8080 | TCP | HTTP alternativo |
| 8443 | TCP | HTTPS alternativo |

Estos puertos permiten identificar servicios que no necesariamente pertenecen a los protocolos tradicionales de Internet.

También pueden utilizarse para aplicaciones empresariales, bases de datos, servicios internos y sistemas distribuidos.

### Puertos dinámicos y privados (49152-65535)

Este rango está destinado a puertos dinámicos o privados.
Se utilizan habitualmente como puertos de origen en las comunicaciones iniciadas por los clientes.

```txt
Cliente:
192.168.1.20:53000

Servidor:
142.250.184.14:443

Protocolo:
TCP
```

El puerto `53000` es un ejemplo de puerto de origen temporal.

## Diferencias entre TCP y UDP

Los puertos no funcionan de manera independiente del protocolo de transporte.

Los dos protocolos más habituales son TCP y UDP.

### TCP (Transmission Control Protocol)

TCP es un protocolo de transporte orientado a conexión.

Antes de intercambiar datos, los extremos establecen una conexión. TCP proporciona mecanismos para garantizar la entrega ordenada de los datos y gestionar las retransmisiones cuando se producen pérdidas.

- Establecimiento de conexión entre los extremos.
- Entrega fiable de datos.
- Control de flujo.
- Control de congestión.
- Mantenimiento del orden de los datos recibidos.

Se utiliza habitualmente en servicios como SSH, HTTP, HTTPS y conexiones a bases de datos.

### UDP (User Datagram Protocol)

UDP es un protocolo de transporte no orientado a conexión.
A diferencia de TCP, no establece una conexión previa ni garantiza que los paquetes lleguen a su destino o que lo hagan en el mismo orden en el que fueron enviados.

- No necesita establecer una conexión previamente.
- No garantiza la entrega de los datagramas.
- No garantiza el orden de recepción.
- Tiene una estructura de comunicación más sencilla.
- Puede reducir la latencia al evitar determinados mecanismos de TCP.

Se utiliza en servicios como DNS, NTP y determinados protocolos de comunicación en tiempo real.

## Los puertos en Linux

En Linux, los puertos son gestionados mediante el subsistema de red del kernel.
Las aplicaciones utilizan sockets para solicitar al sistema operativo un punto de comunicación.
Un socket permite a un proceso enviar y recibir información mediante un protocolo de transporte determinado.

### Puertos en escucha (LISTEN)

Cuando un servicio está esperando conexiones entrantes, normalmente aparece como un socket TCP en estado `LISTEN`.

Por ejemplo:

```sh
sudo ss -lntp # Muestra los sockets TCP que están escuchando, junto con información adicional sobre los procesos asociados.
```

Para consultar los servicios TCP y UDP:
```sh
sudo ss -lntup
```

### Comprobar si un puerto está siendo utilizado

Linux dispone de varias herramientas para consultar el estado de los puertos.
**Utilizando `ss`:**

```sh
sudo ss -lntup | grep ':647'
```

Permite localizar sockets TCP o UDP relacionados con el puerto 647.
**Utilizando `lsof`:**

```sh
sudo lsof -nP -i :647
```

Muestra los procesos que tienen sockets asociados al puerto indicado.
**Utilizando `fuser`:**

```sh
sudo fuser -v 647/tcp
```

Permite identificar procesos que están utilizando el puerto TCP 647.

**Consultar las asignaciones de servicios:**

```sh
getent services 647/tcp # Consulta la base de datos de servicios del sistema, que normalmente incluye /etc/services.
```
* `/etc/services` es una tabla de correspondencias entre nombres y números de puerto.

### Comprobar los rangos de puertos de Linux

El kernel permite consultar determinados parámetros relacionados con la asignación de puertos.

```bash
sysctl net.ipv4.ip_local_port_range # Consultar el rango de puertos locales utilizado en asignaciones automáticas
```

```bash
sysctl net.ipv4.ip_unprivileged_port_start # Consultar el primer puerto que puede utilizar un proceso sin privilegios
```

En la configuración predeterminada habitual, el segundo parámetro tiene un valor de `1024`, por defecto, los procesos necesitan privilegios especiales para asociarse a puertos inferiores a ese valor.

## Puertos abiertos, puertos cerrados y puertos filtrados

| Estado | Significado |
|---|---|
| Abierto | Existe un servicio escuchando o aceptando comunicaciones en ese puerto. |
| Cerrado | El equipo responde, pero no existe un servicio aceptando conexiones en ese puerto. |
| Filtrado | Un firewall u otro mecanismo de filtrado impide determinar directamente el estado del puerto. |

Un puerto registrado por IANA no tiene por qué estar abierto.

Para que el servicio sea accesible normalmente deben cumplirse varias condiciones:

1. La aplicación debe estar ejecutándose.
2. El servicio debe estar asociado al puerto correspondiente.
3. Debe escuchar en la dirección IP o interfaz adecuada.
4. Las reglas del firewall deben permitir la comunicación.
5. La conectividad de red debe permitir alcanzar el equipo.

Conocer el número de puerto no es suficiente para determinar si un servicio está disponible.
