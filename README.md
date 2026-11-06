<p align="center">
  <img src=".github/media/top.png" alt="LinuxCore Header" width="100%">
</p>

<div align="center">

# Linux Core

**Base de datos abierta de comandos Linux y documentación técnica, en español**

[![MIT License](https://img.shields.io/github/license/nisamov/linuxcore?style=flat-square&color=0969da)](LICENSE)
[![Website](https://img.shields.io/badge/website-linuxcore.site-0969da?style=flat-square)](https://linuxcore.site/)
[![DB Build](https://img.shields.io/github/actions/workflow/status/nisamov/linuxcore/commands_db_gen.yaml?style=flat-square&color=0969da&label=db%20build)](https://github.com/nisamov/linuxcore/actions)
[![Docker](https://img.shields.io/badge/ghcr.io-nisamov%2Flinuxcore-0969da?style=flat-square&logo=docker&logoColor=white)](https://github.com/nisamov/linuxcore/pkgs/container/linuxcore)
[![Comandos](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnisamov%2Flinuxcore%2Fmain%2F.github%2Fdb%2Fcommands.json&query=%24._meta.total_registros&label=comandos&style=flat-square&color=0969da)](json/comandos)
[![Distribuciones](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnisamov%2Flinuxcore%2Fmain%2F.github%2Fdb%2Fdistros.json&query=%24._meta.total_registros&label=distribuciones&style=flat-square&color=0969da)](json/distribuciones)

[Web](https://linuxcore.site) · [Inicio rápido](#inicio-rápido) · [Documentación](#documentación) · [Datos y comandos](#datos-y-comandos) · [Estructura](#estructura-del-repositorio) · [Contribuir](#contribuir)

</div>

> [!IMPORTANT]
> **Repositorio en desarrollo activo:** la estructura de carpetas y la documentación pueden cambiar. Si necesitas enlazar a un archivo concreto, hazlo a una [release](https://github.com/nisamov/linuxcore/releases) o a un commit para que el enlace no se rompa.

## Qué es LinuxCore

**Linux Core** es un repositorio creado a raíz de su predecesor [LinuxCommands](https://github.com/nisamov/LinuxCommands), con el fin de consolidar años de experiencia en sistemas Linux, arquitectura de computadores, prácticas de seguridad e infraestructuras modernas.

El objetivo es proporcionar el contexto técnico necesario para comprender no solo cómo utilizar una herramienta, servicio o protocolo, sino también el porqué de su funcionamiento y en qué escenarios debe aplicarse. El contenido se desarrolla en español y está orientado tanto al aprendizaje estructurado como a la consulta técnica rápida.

| Qué ofrece | Detalle |
| --- | --- |
| [Documentación técnica](#documentación) | Teoría y procedimientos de sistema, redes, seguridad, servicios, virtualización, contenedores, bases de datos y programación, con los ficheros de configuración de ejemplo junto a cada tema. |
| [Referencia de comandos](#datos-y-comandos) | Fichas JSON de comandos de Linux, validadas con un [esquema oficial](.github/schemas/comando.schema.json), con parámetros, riesgos, instalación y ejemplos. |
| [Datos abiertos](#descargar-los-datos) | Las fichas de comandos y de distribuciones se compilan en dos archivos JSON que se publican en cada cambio, listos para scripts, paneles o aplicaciones propias. |
| [Sitio web](https://linuxcore.site) | Muestra comandos y distribuciones con búsqueda, a partir de los mismos datos de este repositorio. |

### Pensado para quien administra sistemas

- **Seguridad antes de ejecutar:** cada ficha de comando indica su nivel de riesgo, si es destructivo, si necesita permisos de superusuario y qué advertencias tener en cuenta.
- **Instalación por familia de distribución:** la orden de instalación para Debian y Ubuntu, Arch Linux y RHEL y CentOS.
- **Ejemplos con resultado esperado:** cada ejemplo describe qué hace y qué debería verse al ejecutarlo.
- **Datos para automatizar:** las fichas indican si el comando es idempotente, interactivo o apto para scripts, qué validaciones hacer antes y cómo revertirlo.
- **Procedimientos completos:** ampliar una partición, reemplazar un disco, montar DNS dinámico con BIND9 o alta disponibilidad en DHCP, con los ficheros de configuración reales.

## Inicio rápido

<table>
  <tr>
    <td width="50%" valign="top">
    
**Documentación**

Teoría, procedimientos y ficheros de configuración de redes, seguridad, almacenamiento, servicios y bases de datos, con rutas de lectura ordenadas.

[Ver documentación](#documentación) · [Rutas recomendadas](#rutas-recomendadas)

</td>
    <td width="50%" valign="top">

**Referencia de comandos**

Búsqueda de comandos y distribuciones en la web, con nivel de riesgo, instalación por distribución y ejemplos.

[Consultar la web](#consultar-la-web)

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Datos abiertos**

`commands.json` y `distros.json` en cada release, listos para scripts, paneles o aplicaciones propias.

[Descargar los datos](#descargar-los-datos)

</td>
    <td width="50%" valign="top">

**Docker** (opcional)

Ejecuta la web en tu equipo con una imagen `amd64` y `arm64`, sin depender de linuxcore.site.

[Ejecutar en local](#ejecutar-la-web-en-local-con-docker)

</td>
  </tr>
</table>

### Prueba en menos de un minuto

Descarga los datos y lista los comandos marcados como destructivos:

```bash
curl -fsSLO https://github.com/nisamov/linuxcore/releases/latest/download/commands.json
jq -r '.comandos[] | select(.seguridad.destructivo) | .id' commands.json
```

### Consultar la web

Abre [linuxcore.site](https://linuxcore.site) para buscar comandos y distribuciones. La plataforma sincroniza su base de datos con este repositorio y se actualiza de forma automática tras cada contribución.

### Descargar los datos

> [!NOTE]
> **Base de datos exportable**
> El proyecto distribuye la referencia de comandos y distribuciones en formato **JSON**. Es la misma que alimenta la web **[linuxcore.site](https://linuxcore.site)** y puedes usarla libremente.
>
> **Descargar la última versión compilada:** [![Latest Release](https://img.shields.io/github/v/release/nisamov/linuxcore?display_name=release&style=flat-square&color=0969da&label=release)](https://github.com/nisamov/linuxcore/releases/latest)

```bash
curl -fsSLO https://github.com/nisamov/linuxcore/releases/latest/download/commands.json
curl -fsSLO https://github.com/nisamov/linuxcore/releases/latest/download/distros.json
```

### Ejecutar la web en local con Docker

Es opcional: la documentación y los datos se consultan sin necesidad de Docker.

> [!TIP]
> **LinuxCore en local con Docker**
> Ejecuta la web en tu equipo, con los datos de la última release y sin depender de `linuxcore.site`:
>
> ```bash
> docker run -d --name linuxcore -p 8080:80 --restart unless-stopped ghcr.io/nisamov/linuxcore:latest
> ```
>
> Abre <http://localhost:8080>. Para actualizar: `docker pull ghcr.io/nisamov/linuxcore:latest` y recrea el contenedor.

La imagen es multiarquitectura (`amd64` y `arm64`) y se reconstruye en cada release y una vez por semana.

## Documentación

La documentación está en [`documentacion/`](documentacion), organizada por áreas. Cada tema incluye la teoría y, cuando procede, los ficheros de configuración o scripts de ejemplo.

[Sistema](#sistema) · [Redes](#redes) · [Seguridad](#seguridad) · [Servicios](#servicios) · [Infraestructura](#infraestructura) · [Bases de datos](#bases-de-datos) · [Programación](#programación)

> [!NOTE]
> **Cómo leer los nombres de archivo**
> - `teoria_*`: el concepto, antes de tocar ningún comando.
> - `diagnosticar_*`: resolución de problemas, con comprobaciones paso a paso.
> - Nombres de acción (`ampliar_particion`, `reemplazar_disco`...): procedimientos completos.
> - Ficheros sin extensión `.md` (`.conf`, `.sh`, `.service`...): configuración o scripts de ejemplo que acompañan al tema.

### Rutas recomendadas

Cada ruta se lee en el orden indicado: los pasos están numerados de lo básico a lo práctico.

<table>
  <tr>
    <td width="50%" valign="top">

**Servicios de red**

Configurar y diagnosticar los servicios básicos de una red: direccionamiento, resolución de nombres y acceso remoto.

1. [Puertos](documentacion/redes/fundamentos/teoria_puertos.md): puertos y servicios asociados.
2. [DHCP](documentacion/redes/dhcp/teoria_dhcp.md): ISC DHCP, concepto y configuración.
3. [DNS](documentacion/redes/dns/teoria_dns.md): jerarquía y resolución.
4. [BIND9](documentacion/redes/dns/bind9/teoria_bind9.md): servidor autoritativo.
5. [SSH](documentacion/redes/ssh/teoria_ssh.md): acceso remoto seguro.
6. [Diagnosticar conectividad](documentacion/redes/diagnostico/diagnosticar_conectividad.md): comprobación de conexión.

</td>
    <td width="50%" valign="top">

**Almacenamiento y recuperación**

Gestionar discos y particiones, montar RAID, sustituir hardware averiado y recuperar datos.

1. [Discos y particiones](documentacion/sistema/almacenamiento/teoria_discos_particiones.md): tablas de particiones y sistemas de archivos.
2. [Ampliar una partición](documentacion/sistema/almacenamiento/ampliar_particion.md): procedimiento paso a paso.
3. [RAID](documentacion/sistema/almacenamiento/raid/teoria_raid.md): niveles y casos de uso.
4. [Reemplazar un disco](documentacion/sistema/almacenamiento/reemplazar_disco.md): sustitución de disco.
5. [Recuperar sistema de archivos](documentacion/sistema/almacenamiento/recuperar_sistema_archivos.md): reparación y recuperación.
6. [Borg](documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md): backups deduplicados.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Seguridad y auditoría**

Controlar el acceso a los recursos, filtrar el tráfico con cortafuegos y auditar el sistema.

1. [Teoría de seguridad](documentacion/seguridad/teoria_seguridad.md): principios y conceptos.
2. [Permisos](documentacion/sistema/permisos/permisos_archivos_directorios.md): modelo clásico `rwx`, propietarios y grupos.
3. [ACL](documentacion/sistema/permisos/listas_acceso.md): ACLs con `getfacl` / `setfacl`.
4. [iptables](documentacion/seguridad/firewall/iptables/teoria_iptables.md): reglas y cadenas.
5. [UFW](documentacion/seguridad/firewall/ufw/teoria_ufw.md): cortafuegos simplificado.
6. [Auditoría](documentacion/seguridad/forense/auditoria/audit_planning.md): auditoría con `auditd`.
7. [Forense](documentacion/seguridad/forense/teoria_forense.md): metodología.

</td>
    <td width="50%" valign="top">

**Seguridad en redes**

Comprender los protocolos de red y las técnicas de ataque que explotan sus debilidades. Úsala solo en entornos propios o de laboratorio.

1. [Dispositivos de red](documentacion/seguridad/dispositivos_de_red.md): equipos de red y su relevancia para la seguridad.
2. [Ethernet](documentacion/seguridad/ethernet.md): red local y nivel de enlace.
3. [IPv4](documentacion/seguridad/ipv4.md): direccionamiento y cabecera IP.
4. [ARP](documentacion/seguridad/arp.md): resolución de direcciones y sus debilidades.
5. [ICMP](documentacion/seguridad/icmp.md): mensajes de control y diagnóstico.
6. [TCP y UDP](documentacion/seguridad/tcp_udp.md): protocolos de transporte.
7. [Sniffing](documentacion/seguridad/sniffing.md): captura de tráfico.
8. [Envenenamiento ARP](documentacion/seguridad/arp_poisoning.md): suplantación en la caché ARP.
9. [DHCP falso](documentacion/seguridad/dhcp_falso.md): servidores DHCP no autorizados.
10. [Secuestro de sesión](documentacion/seguridad/session_hijacking.md): toma de control de sesiones establecidas.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Virtualización y contenedores**

Pasar de la virtualización completa a los contenedores y su orquestación.

1. [Máquinas virtuales](documentacion/infraestructura/virtualizacion/teoria_mv.md): conceptos básicos.
2. [Hipervisores](documentacion/infraestructura/virtualizacion/teoria_hipervisor.md): tipo 1 y tipo 2.
3. [Proxmox](documentacion/infraestructura/virtualizacion/teoria_proxmox.md): plataforma de virtualización.
4. [Docker](documentacion/infraestructura/contenedores/docker/teoria_docker.md): conceptos.
5. [Crear un Dockerfile](documentacion/infraestructura/contenedores/docker/creacion_dockerfile.md): construcción de imágenes.
6. [Kubernetes](documentacion/infraestructura/contenedores/kubernetes/teoria_kubernetes.md): orquestación.

</td>
    <td width="50%" valign="top">

**Bases de datos con MySQL y MariaDB**

Instalar, administrar y proteger un servidor MySQL/MariaDB y trabajar con sus datos.

1. [Fundamentos](documentacion/bases_de_datos/mysql_mariadb/fundamentos.md): conceptos básicos y arquitectura general.
2. [Instalación y servicio](documentacion/bases_de_datos/mysql_mariadb/instalacion_y_servicio.md): instalación y gestión del servicio.
3. [Bases y tablas](documentacion/bases_de_datos/mysql_mariadb/bases_y_tablas.md): creación, modificación y estructura.
4. [Inserciones](documentacion/bases_de_datos/mysql_mariadb/inserciones.md): inserción de registros.
5. [Consultas y funciones](documentacion/bases_de_datos/mysql_mariadb/consultas_y_funciones.md): consultas SQL y funciones integradas.
6. [Joins y uniones](documentacion/bases_de_datos/mysql_mariadb/joins_y_uniones.md): combinación de tablas con JOIN y UNION.
7. [Usuarios y permisos](documentacion/bases_de_datos/mysql_mariadb/usuarios_y_permisos.md): cuentas y privilegios.
8. [Copias de seguridad y recuperación](documentacion/bases_de_datos/mysql_mariadb/copias_seguridad_y_recuperacion.md): backups con `mysqldump` y restauración.

</td>
  </tr>
</table>

### Sistema

<table>
  <tr>
    <td width="50%" valign="top">

**Linux**

- [Teoría de Linux](documentacion/sistema/linux/teoria_linux.md): fundamentos del sistema operativo.
- [Linus Torvalds](documentacion/sistema/linux/linus_torvalds.md): origen y contexto histórico.

</td>
    <td width="50%" valign="top">

**Permisos**

- [Permisos de archivos y directorios](documentacion/sistema/permisos/permisos_archivos_directorios.md): modelo clásico `rwx`, propietarios y grupos.
- [Listas de control de acceso](documentacion/sistema/permisos/listas_acceso.md): ACLs con `getfacl` / `setfacl`.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Procesos**

- [Teoría de procesos](documentacion/sistema/procesos/teoria_de_procesos.md): ciclo de vida, estados y señales.
- [Proceso zombie](documentacion/sistema/procesos/proceso_zombie.md): qué son y cómo tratarlos.
- [Proceso consumiendo CPU](documentacion/sistema/procesos/proceso_consumiendo_cpu.md): diagnóstico de uso excesivo de CPU.

</td>
    <td width="50%" valign="top">

**Almacenamiento**

- [Teoría de almacenamiento](documentacion/sistema/almacenamiento/teoria_almacenamiento.md): conceptos generales.
- [Discos y particiones](documentacion/sistema/almacenamiento/teoria_discos_particiones.md): tablas de particiones y sistemas de archivos.
- [Ampliar una partición](documentacion/sistema/almacenamiento/ampliar_particion.md): procedimiento paso a paso.
- [Reemplazar un disco](documentacion/sistema/almacenamiento/reemplazar_disco.md): sustitución de disco.
- [Recuperar sistema de archivos](documentacion/sistema/almacenamiento/recuperar_sistema_archivos.md): reparación y recuperación.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**RAID**

- [Teoría de RAID](documentacion/sistema/almacenamiento/raid/teoria_raid.md): niveles y casos de uso.
- [RAID 1](documentacion/sistema/almacenamiento/raid/raid1.md): montaje práctico.
- [RAID (versión compacta)](documentacion/sistema/almacenamiento/raid/raid_compressed.md): resumen rápido.

</td>
    <td width="50%" valign="top">

**Hardware**

- [RAM](documentacion/sistema/hardware/ram.md): funcionamiento y tipos de memoria.

</td>
  </tr>
</table>

### Redes

<table>
  <tr>
    <td width="50%" valign="top">

**Fundamentos**

- [Topología de redes](documentacion/redes/fundamentos/topologia_redes.md): tipos de topología.
- [Puertos](documentacion/redes/fundamentos/teoria_puertos.md): puertos y servicios asociados.
- [ARP](documentacion/redes/fundamentos/arp.md): resolución de direcciones.
- [TTL e ICMP](documentacion/redes/fundamentos/ttl_icmp.md): funcionamiento de `ping` y `traceroute`.

</td>
    <td width="50%" valign="top">

**Diagnóstico**

- [Diagnosticar conectividad](documentacion/redes/diagnostico/diagnosticar_conectividad.md): comprobación de conexión.
- [Diagnosticar rutas](documentacion/redes/diagnostico/diagnosticar_rutas.md): análisis de rutas.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**DHCP**

- [Teoría de DHCP](documentacion/redes/dhcp/teoria_dhcp.md): ISC DHCP, concepto y configuración.
- [DHCP *failover*](documentacion/redes/dhcp/failover/teoria_dhcp_failover.md): alta disponibilidad con ISC.
- [Kea](documentacion/redes/dhcp/kea/teoria_kea.md): servidor DHCP moderno.
- [Kea *failover*](documentacion/redes/dhcp/kea/failover/teoria_kea_failover.md): alta disponibilidad con Kea.
- [Ficheros de configuración](documentacion/redes/dhcp/configuracion/): `dhcpd.conf` y Netplan de ambos servidores.

</td>
    <td width="50%" valign="top">

**DNS**

- [Teoría de DNS](documentacion/redes/dns/teoria_dns.md): jerarquía y resolución.
- [Diagnosticar DNS](documentacion/redes/dns/diagnosticar_dns.md): resolución de problemas.
- [BIND9](documentacion/redes/dns/bind9/teoria_bind9.md): servidor autoritativo.
- [DDNS en BIND9](documentacion/redes/dns/bind9/dinamico/procedimiento.md): actualizaciones dinámicas; ver también los [ficheros del procedimiento](documentacion/redes/dns/bind9/dinamico/).
- [Zonas y configuración BIND9](documentacion/redes/dns/bind9/): zonas directa/inversa, maestro y esclavo.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**FTP**

- [Teoría de FTP](documentacion/redes/ftp/teoria_ftp.md): protocolo y modos.

</td>
    <td width="50%" valign="top">

**NFS**

- [Teoría de NFS](documentacion/redes/nfs/teoria_nfs.md): recursos compartidos en red; ver también [`exports`](documentacion/redes/nfs/exports) y [`fstab`](documentacion/redes/nfs/fstab).

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Samba**

- [General de Samba](documentacion/redes/samba/general_samba.md): compartición con Windows; ver [`smb.conf`](documentacion/redes/samba/smb.conf), [`smb_test.conf`](documentacion/redes/samba/smb_test.conf) y [`smb_test2.conf`](documentacion/redes/samba/smb_test2.conf).

</td>
    <td width="50%" valign="top">

**SSH**

- [Teoría de SSH](documentacion/redes/ssh/teoria_ssh.md): acceso remoto seguro.
- [Comandos y casos de uso](documentacion/redes/ssh/uso.md): conexiones y ejecución remota.

</td>
  </tr>
</table>

### Seguridad

> [!CAUTION]
> Las secciones de **pentesting**, **OSINT** y **ataques de red** describen técnicas que solo deben usarse en sistemas propios o con autorización expresa. Practica en un laboratorio aislado (máquinas virtuales o contenedores).

<table>
  <tr>
    <td width="50%" valign="top">

**General**

- [Teoría de seguridad](documentacion/seguridad/teoria_seguridad.md): principios y conceptos.

</td>
    <td width="50%" valign="top">

**Autenticación**

- [libpam-passwdqc](documentacion/seguridad/autenticacion/libpam-passwdqc.md): política de contraseñas.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Criptografía**

- [Cifrado](documentacion/seguridad/criptografia/cifrado/teoria_cifrado.md): simétrico y asimétrico.
- [Hash](documentacion/seguridad/criptografia/hash/teoria_hash.md): funciones resumen e integridad.
- [Firma digital](documentacion/seguridad/criptografia/firma_digital/teoria_firma_digital.md): fundamentos.
- [Firma SSL](documentacion/seguridad/criptografia/firma_digital/firma_ssl.md): aplicación práctica.
- [Certificado RSA con OpenSSL](documentacion/seguridad/criptografia/certificados/certificado_rsa_openssl.md): generación de certificados.
- [Entidad certificadora](documentacion/seguridad/criptografia/certificados/entidad_certificadora.sh): script de CA.

</td>
    <td width="50%" valign="top">

**Cortafuegos**

- [iptables](documentacion/seguridad/firewall/iptables/teoria_iptables.md): reglas y cadenas.
- [UFW](documentacion/seguridad/firewall/ufw/teoria_ufw.md): cortafuegos simplificado.
- [nftables](documentacion/seguridad/firewall/nftables/nftables.conf): configuración de ejemplo.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Forense**

- [Teoría forense](documentacion/seguridad/forense/teoria_forense.md): metodología.
- [Planificación de auditoría](documentacion/seguridad/forense/auditoria/audit_planning.md): auditoría con `auditd`.
- [Foremost](documentacion/seguridad/forense/herramientas/foremost.md): recuperación de archivos.
- [Definición de datos](documentacion/seguridad/forense/herramientas/datadefinition.md): conceptos de datos.

</td>
    <td width="50%" valign="top">

**OSINT**

- [Teoría de OSINT](documentacion/seguridad/osint/teoria_osint.md): fundamentos y metodología.
- [Holehe](documentacion/seguridad/osint/herramientas/correo/holehe.md): herramienta para correos.
- [OWASP Amass](documentacion/seguridad/osint/herramientas/dominios/owasp_amass.md) · [theHarvester](documentacion/seguridad/osint/herramientas/dominios/theharvester.md): herramientas para dominios.
- [Maigret](documentacion/seguridad/osint/herramientas/usuarios/maigret.md) · [Sherlock](documentacion/seguridad/osint/herramientas/usuarios/sherlock.md): herramientas para nombres de usuario.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Pentesting**

- [Nmap](documentacion/seguridad/pentesting/redes/nmap.md) · [hping3](documentacion/seguridad/pentesting/redes/hping3.md): exploración y pruebas en red.

</td>
    <td width="50%" valign="top">

**Redes**

- [Dispositivos de red](documentacion/seguridad/dispositivos_de_red.md) · [Ethernet](documentacion/seguridad/ethernet.md) · [IPv4](documentacion/seguridad/ipv4.md): capas y dispositivos desde la seguridad.
- [ARP](documentacion/seguridad/arp.md) · [ICMP](documentacion/seguridad/icmp.md) · [TCP y UDP](documentacion/seguridad/tcp_udp.md): protocolos y su superficie de ataque.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Ataques de red**

- [Sniffing](documentacion/seguridad/sniffing.md) · [Envenenamiento ARP](documentacion/seguridad/arp_poisoning.md) · [DHCP falso](documentacion/seguridad/dhcp_falso.md): captura de tráfico y suplantación.
- [ICMP redirect](documentacion/seguridad/icmp_redirect.md) · [Source routing](documentacion/seguridad/source_routing.md) · [Ataques de enrutamiento](documentacion/seguridad/ataques_enrutamiento.md): manipulación de rutas.
- [Ataques de fragmentación](documentacion/seguridad/ataques_fragmentacion.md) · [Secuestro de sesión](documentacion/seguridad/session_hijacking.md): fragmentación IP y sesiones.

</td>
    <td width="50%" valign="top">

**Reconocimiento**

- [Footprinting](documentacion/seguridad/footprinting.md) · [Fingerprinting](documentacion/seguridad/fingerprinting.md): recopilación de información del objetivo.

</td>
  </tr>
</table>

### Servicios

<table>
  <tr>
    <td width="50%" valign="top">

**Web**

- [Apache2](documentacion/servicios/web/apache2/teoria_apache2.md): servidor web.
- [Nginx](documentacion/servicios/web/nginx/teoria_nginx.md): servidor web y proxy inverso.

</td>
    <td width="50%" valign="top">

**Sistema**

- [Cron](documentacion/servicios/sistema/cron/teoria_cron.md): tareas programadas.
- [Journal](documentacion/servicios/sistema/journal/teoria_journal.md): registros con `journald`.
- [Diagnosticar systemd](documentacion/servicios/sistema/systemd/diagnosticar_systemd.md): resolución de problemas.
- [Ejemplo de unidad](documentacion/servicios/sistema/systemd/ejemplo.service): fichero `.service` de ejemplo.

</td>
  </tr>
</table>

### Infraestructura

<table>
  <tr>
    <td width="50%" valign="top">

**Virtualización**

- [Máquinas virtuales](documentacion/infraestructura/virtualizacion/teoria_mv.md): conceptos básicos.
- [Hipervisores](documentacion/infraestructura/virtualizacion/teoria_hipervisor.md): tipo 1 y tipo 2.
- [Proxmox](documentacion/infraestructura/virtualizacion/teoria_proxmox.md): plataforma de virtualización.
- [VirtualBox](documentacion/infraestructura/virtualizacion/teoria_virtualbox.md): hipervisor de escritorio.
- [Hyper-V](documentacion/infraestructura/virtualizacion/teoria_hyper-v.md): hipervisor de Microsoft.

</td>
    <td width="50%" valign="top">

**Contenedores**

- [Docker: teoría](documentacion/infraestructura/contenedores/docker/teoria_docker.md): conceptos.
- [Docker: instalación](documentacion/infraestructura/contenedores/docker/instalacion.md): puesta en marcha.
- [Docker: crear un Dockerfile](documentacion/infraestructura/contenedores/docker/creacion_dockerfile.md): construcción de imágenes.
- [Docker: volúmenes](documentacion/infraestructura/contenedores/docker/volumenes.md): persistencia de datos.
- [Docker: gestión de redes](documentacion/infraestructura/contenedores/docker/gestion_redes.md): redes entre contenedores.
- [Docker: variables de entorno](documentacion/infraestructura/contenedores/docker/variables_entorno.md): configuración de contenedores.
- [Docker Compose](documentacion/infraestructura/contenedores/docker/docker_compose.md): aplicaciones multicontenedor.
- [Kubernetes](documentacion/infraestructura/contenedores/kubernetes/teoria_kubernetes.md): orquestación.
- [LXC](documentacion/infraestructura/contenedores/lxc/teoria_lxc.md): contenedores de sistema.

</td>
  </tr>
  <tr>
    <td colspan="2" valign="top">

**Copias de seguridad**

- [Borg](documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md): backups deduplicados.

</td>
  </tr>
</table>

### Bases de datos

<table>
  <tr>
    <td width="50%" valign="top">

**Fundamentos**

- [Fundamentos](documentacion/bases_de_datos/mysql_mariadb/fundamentos.md): conceptos básicos y arquitectura general de MySQL/MariaDB.

</td>
    <td width="50%" valign="top">

**Servidor**

- [Instalación y servicio](documentacion/bases_de_datos/mysql_mariadb/instalacion_y_servicio.md): instalación y gestión del servicio del sistema.
- [Configuración del servidor](documentacion/bases_de_datos/mysql_mariadb/configuracion_servidor.md): parámetros del motor, archivos de configuración y ajustes.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Datos**

- [Bases y tablas](documentacion/bases_de_datos/mysql_mariadb/bases_y_tablas.md): creación, modificación y estructura de bases de datos y tablas.
- [Inserciones](documentacion/bases_de_datos/mysql_mariadb/inserciones.md): inserción de registros.

</td>
    <td width="50%" valign="top">

**Consultas**

- [Consultas y funciones](documentacion/bases_de_datos/mysql_mariadb/consultas_y_funciones.md): consultas SQL, manipulación de datos y funciones integradas.
- [Joins y uniones](documentacion/bases_de_datos/mysql_mariadb/joins_y_uniones.md): combinación de tablas mediante tipos de JOIN y UNION.

</td>
  </tr>
  <tr>
    <td width="50%" valign="top">

**Acceso**

- [Usuarios y permisos](documentacion/bases_de_datos/mysql_mariadb/usuarios_y_permisos.md): gestión de cuentas de usuario y asignación de privilegios.
- [Roles y permisos](documentacion/bases_de_datos/mysql_mariadb/roles_y_permisos.md): roles y asignación de privilegios.
- [Seguridad](documentacion/bases_de_datos/mysql_mariadb/seguridad.md): buenas prácticas, hardening y protección de datos.

</td>
    <td width="50%" valign="top">

**Operación**

- [Transacciones y concurrencia](documentacion/bases_de_datos/mysql_mariadb/transacciones_y_concurrencia.md): control transaccional (ACID), bloqueos y aislamiento.
- [Metadatos y caché de consultas](documentacion/bases_de_datos/mysql_mariadb/metadatos_y_cache_de_consultas.md): inspección de metadatos, esquemas del sistema y caché.
- [Copias de seguridad y recuperación](documentacion/bases_de_datos/mysql_mariadb/copias_seguridad_y_recuperacion.md): estrategias de backup (`mysqldump`) y restauración.

</td>
  </tr>
  <tr>
    <td colspan="2" valign="top">

**Guiones**

- [Construcción de guiones](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/construccion_guiones.md): introducción a los guiones SQL.
- [Declaración](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/declaracion.md): declaración y uso de variables en scripts.
- [Tipos y operadores](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/tipos_operadores.md): tipos de datos y operadores.
- [Condicionales](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/condicionales.md): estructuras de control de flujo (`IF`, `CASE`).
- [Bucles](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/bucles.md): estructuras repetitivas.
- [Funciones](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/funciones.md): definición y uso de funciones personalizadas.
- [Delimitador](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/delimitador.md): uso y sintaxis del comando `DELIMITER`.

</td>
  </tr>
</table>

### Programación

<table>
  <tr>
    <td width="50%" valign="top">

**Conceptos**

- [Introducción](documentacion/programacion/conceptos/introduccion.md): fundamentos de programación.

</td>
    <td width="50%" valign="top">

**Bash**

- [Comentarios](documentacion/programacion/bash/comentarios.sh) · [Input](documentacion/programacion/bash/input.sh) · [Argumentos](documentacion/programacion/bash/argumentos.sh) · [Alias](documentacion/programacion/bash/alias.sh): sintaxis básica y entrada de datos.
- [Operadores aritméticos](documentacion/programacion/bash/operadores_aritmeticos.sh) · [Condiciones](documentacion/programacion/bash/condiciones_evaluacion.sh) · [Control de flujo](documentacion/programacion/bash/control_flujo.sh) · [Devolución](documentacion/programacion/bash/devolucion.sh): lógica y funciones.
- [Redirecciones](documentacion/programacion/bash/redirecciones.sh) · [Tuberías](documentacion/programacion/bash/tuberias.sh): entrada, salida y encadenado de comandos.
- [Contar](documentacion/programacion/bash/contar.sh) · [Fechas](documentacion/programacion/bash/fechas.sh) · [Depuración](documentacion/programacion/bash/depuracion.sh): utilidades y depuración.

</td>
  </tr>
  <tr>
    <td colspan="2" valign="top">

**PHP**

- [Comentarios](documentacion/programacion/php/comentarios.php) · [Variables](documentacion/programacion/php/variables.php) · [Concatenación](documentacion/programacion/php/concatenacion.php): sintaxis básica.
- [Condicionales](documentacion/programacion/php/condicionales.php) · [Conversión](documentacion/programacion/php/conversion.php): lógica y tipos.

</td>
  </tr>
</table>

## Datos y comandos

### Consultas de ejemplo con jq

Con los dos archivos descargados y [`jq`](https://jqlang.github.io/jq/) instalado, estas consultas son de solo lectura.

Listar los comandos marcados como destructivos antes de usarlos en un servidor:

```bash
jq -r '.comandos[] | select(.seguridad.destructivo) | .id' commands.json
```

Listar los comandos de la categoría de red:

```bash
jq -r '.comandos[] | select(.categoria_db == "red") | .id' commands.json
```

Obtener la orden para instalar un comando en Debian y Ubuntu:

```bash
jq -r '.comandos[] | select(.id == "tcpdump") | .instalacion.paquetes.debian_ubuntu' commands.json
```

Listar las distribuciones basadas en Debian:

```bash
jq -r '.distribuciones[] | select(.distribucion_base == "Debian") | .nombre' distros.json
```

### Qué contiene cada ficha de comando

| Bloque | Qué describe |
| --- | --- |
| `clasificacion` | Categoría, subcategoría y etiquetas para buscar. |
| `sintaxis` | Forma principal de uso y alternativas. |
| `parametros` | Cada opción con su tipo, valor por defecto, valores admitidos, conflictos y dependencias entre opciones. |
| `requisitos` | Permisos, dependencias y paquetes necesarios. |
| `seguridad` | Nivel de riesgo, si es destructivo, si requiere root o confirmación y advertencias. |
| `instalacion` | Método de instalación y orden para Debian y Ubuntu, Arch Linux y RHEL y CentOS. |
| `ejemplos` | Casos de uso con el comando, su descripción y el resultado esperado. |
| `automatizacion` | Idempotencia, interactividad, aptitud para scripts, validaciones previas y reversión. |

Ejemplo reducido de la ficha de `lsof`:

```json
{
  "id": "lsof",
  "descripcion": "Lista archivos abiertos por procesos y permite buscar por PID, usuario, red, directorio y otros criterios.",
  "seguridad": {
    "nivel": "medio",
    "destructivo": false,
    "requiere_root": false,
    "advertencias": [
      "La salida puede revelar rutas, usuarios, archivos y conexiones de red sensibles.",
      "La búsqueda recursiva +D puede tardar y causar carga de E/S en árboles grandes."
    ]
  },
  "instalacion": {
    "metodo": "gestor_paquetes",
    "paquetes": {
      "debian_ubuntu": "sudo apt install lsof",
      "arch_linux": "sudo pacman -S lsof",
      "rhel_centos": "sudo dnf install lsof"
    }
  },
  "ejemplos": [
    {
      "nombre": "Archivos abiertos por PID",
      "comando": "lsof -p 1234",
      "descripcion": "Lista los archivos y descriptores abiertos por el proceso 1234.",
      "resultado_esperado": "Tabla de comando, PID, usuario, descriptor y nombre del archivo."
    }
  ],
  "automatizacion": {
    "idempotente": true,
    "apto_script": true,
    "rollback": null
  }
}
```

### Categorías de comandos

Las fichas están en [`json/comandos/`](json/comandos), una carpeta por categoría. Las distribuciones están en [`json/distribuciones/`](json/distribuciones).

| Categoría | Contenido | Algunos ejemplos |
| --- | --- | --- |
| [`almacenamiento`](json/comandos/almacenamiento) | Discos, LVM, RAID, sistemas de archivos y estado SMART. | `lvcreate`, `mdadm`, `smartctl`, `zfs` |
| [`archivos`](json/comandos/archivos) | Gestión de archivos y procesamiento de texto. | `find`, `grep`, `sed`, `awk` |
| [`compresion`](json/comandos/compresion) | Compresión, copias y sincronización. | `tar`, `rsync`, `dd`, `gzip` |
| [`info_sistema`](json/comandos/info_sistema) | Hardware, kernel y entorno del sistema. | `lscpu`, `lspci`, `dmidecode`, `sysctl` |
| [`miscelaneo`](json/comandos/miscelaneo) | Utilidades de terminal y productividad. | `tmux`, `jq`, `fzf`, `screen` |
| [`monolinea`](json/comandos/monolinea) | Recetas de una línea para tareas habituales. | `comprobar_espacio_y_inodos`, `mostrar_puertos_abiertos` |
| [`paquetes`](json/comandos/paquetes) | Gestores de paquetes de las principales familias. | `apt`, `dnf`, `pacman`, `flatpak` |
| [`procesos`](json/comandos/procesos) | Procesos, rendimiento y trazado. | `ps`, `strace`, `lsof`, `kill` |
| [`red`](json/comandos/red) | Configuración, diagnóstico y captura de red. | `ip`, `ss`, `tcpdump`, `nmap` |
| [`seguridad`](json/comandos/seguridad) | Cortafuegos, permisos, auditoría y criptografía. | `iptables`, `ufw`, `auditctl`, `setfacl` |
| [`servicios`](json/comandos/servicios) | Servicios, registros y protocolos de directorio y monitorización. | `systemctl`, `journalctl`, `snmpwalk`, `ldapsearch` |
| [`usuarios`](json/comandos/usuarios) | Cuentas, grupos y sesiones. | `useradd`, `passwd`, `chage`, `last` |

## Estructura del repositorio

```text
linuxcore/
├── documentacion/          Teoría, procedimientos y ficheros de ejemplo, por área
│   ├── bases_de_datos/       MySQL y MariaDB
│   ├── infraestructura/      Virtualización, contenedores y copias de seguridad
│   ├── programacion/         Bash y PHP
│   ├── redes/                DHCP, DNS, FTP, NFS, Samba y SSH
│   ├── seguridad/            Criptografía, cortafuegos, forense, OSINT y ataques de red
│   ├── servicios/            Servidores web y servicios del sistema
│   └── sistema/              Linux, almacenamiento, permisos, procesos y hardware
├── json/
│   ├── comandos/             Una ficha JSON por comando, en 12 categorías
│   ├── distribuciones/       Una ficha JSON por distribución
│   └── servicios/            En desarrollo (MariaDB, PostgreSQL y Redis)
├── docker/                 Dockerfile de la web en local
├── .github/
│   ├── db/                   Bases de datos compiladas (commands.json y distros.json)
│   ├── ISSUE_TEMPLATE/       Plantillas de incidencias
│   ├── linuxcommands/        Material histórico de LinuxCommands
│   ├── media/                Imágenes del README
│   ├── schemas/              Esquema JSON de las fichas de comandos
│   ├── scripts/              Validación y generación de las bases de datos
│   └── workflows/            Automatización con GitHub Actions
├── ACCESSIBILITY.md        Criterios de accesibilidad
├── CHANGELOG.md            Registro de cambios
└── TODO.md                 Pendientes del proyecto
```

## Contribuir

Este proyecto nace con fines de aprendizaje y referencia técnica. Si encuentras alguna errata, quieres corregir un procedimiento o añadir nuevo contenido, las contribuciones son más que bienvenidas.

| Quiero | Cómo |
| --- | --- |
| Avisar de un error o un enlace roto | Abre una [incidencia de corrección](https://github.com/nisamov/linuxcore/issues/new/choose). |
| Proponer un tema o un comando | Abre una [incidencia](https://github.com/nisamov/linuxcore/issues/new/choose) con la plantilla de documentación o de nuevo comando. |
| Aportar documentación, una ficha de comando o una distribución | Sigue la [guía de contribución](.github/CONTRIBUTING.md) y envía un [Pull Request](https://github.com/nisamov/linuxcore/pulls). |
| Comunicar una barrera de accesibilidad | Sigue las indicaciones de [ACCESSIBILITY.md](ACCESSIBILITY.md). |

Antes de enviar un Pull Request, ejecuta las validaciones que explica la guía:

```bash
python3 .github/scripts/validate_markdown.py
python3 .github/scripts/validate_commands.py
```

### Documentos del proyecto

| Documento | Contenido |
| --- | --- |
| [Guía de contribución](.github/CONTRIBUTING.md) | Flujo de trabajo, reglas por tipo de aporte y validaciones. |
| [Accesibilidad](ACCESSIBILITY.md) | Criterios para que la documentación y la web sean accesibles. |
| [Política de seguridad](.github/SECURITY.md) | Directrices de uso seguro de los comandos y los scripts. |
| [Código de conducta](.github/CODE_OF_CONDUCT.md) | Normas de convivencia y de contenido. |
| [Registro de cambios](CHANGELOG.md) | Historial de versiones del repositorio. |
| [Pendientes](TODO.md) | Tareas y mejoras previstas. |
| [Agradecimientos](.github/AGRADECIMIENTOS.md) | Reconocimiento a quienes han aportado conocimiento. |

> [!WARNING]
> El contenido se proporciona con fines informativos. Prueba los comandos y los scripts en una máquina virtual o un contenedor antes de usarlos en producción, sobre todo los que requieren `sudo` o están marcados como destructivos.

## Automatización

Los cambios se comprueban y se publican de forma automática con GitHub Actions. Esta parte interesa sobre todo a quien mantiene el repositorio; para leer o contribuir no hace falta conocerla.

| Flujo de trabajo | Qué hace | Cuándo se ejecuta |
| --- | --- | --- |
| Generación bases de datos | Valida las fichas de comandos con el esquema, compila `commands.json` y `distros.json` y los publica en la última release. | Al cambiar `json/comandos/`, `json/distribuciones/`, el esquema o los scripts asociados. |
| Validación de documentación | Comprueba que los enlaces internos de los archivos Markdown apuntan a archivos que existen. | Al cambiar archivos `.md`. |
| Detección de claves secretas | Busca credenciales y claves accidentales en el contenido. | En cada `push` y en cada Pull Request. |
| Publicar imagen Docker | Construye y publica la imagen de la web en `ghcr.io` para `amd64` y `arm64`. | En cada release y una vez por semana. |

Dependabot revisa las acciones de GitHub una vez al mes.

## Colaboradores

<div align="center">
  <a href="https://github.com/nisamov/linuxcore/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Nisamov/linuxcore&columns=8" alt="Contribuyentes de LinuxCore" />
  </a>
</div>

---

<div align="center">
  <p><b>Linux Core - Nisamov | <a href="LICENSE">Licencia MIT</a> - 2026</b></p>
  <p><b>Contacto:</b> <a href="mailto:nisamov.contact@gmail.com">nisamov.contact@gmail.com</a></p>
  <p align="center">
    <img src=".github/media/bottom.png" alt="LinuxCore Footer" width="100%">
  </p>
</div>