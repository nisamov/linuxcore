<p align="center">
  <img src=".github/media/top.png" alt="LinuxCore Header" width="100%">
</p>

<div align="center">

# Linux Core

**Documentación técnica, referencia de comandos y datos abiertos de Linux, en español**

[![MIT License](https://img.shields.io/github/license/nisamov/linuxcore?style=flat-square&color=0969da)](LICENSE) [![Website](https://img.shields.io/badge/website-linuxcore.site-0969da?style=flat-square)](https://linuxcore.site/) [![DB Build](https://img.shields.io/github/actions/workflow/status/nisamov/linuxcore/commands_db_gen.yaml?style=flat-square&color=0969da&label=db%20build)](https://github.com/nisamov/linuxcore/actions) [![Docker](https://img.shields.io/badge/ghcr.io-nisamov%2Flinuxcore-0969da?style=flat-square&logo=docker&logoColor=white)](https://github.com/nisamov/linuxcore/pkgs/container/linuxcore) [![Comandos](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnisamov%2Flinuxcore%2Fmain%2F.github%2Fdb%2Fcommands.json&query=%24._meta.total_registros&label=comandos&style=flat-square&color=0969da)](json/comandos) [![Distribuciones](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnisamov%2Flinuxcore%2Fmain%2F.github%2Fdb%2Fdistros.json&query=%24._meta.total_registros&label=distribuciones&style=flat-square&color=0969da)](json/distribuciones) [![Visitas](https://api.visitorbadge.io/api/combined?path=nisamov.linuxcore&countColor=0969da&style=flat-square)](https://github.com/nisamov/linuxcore)

[Web](https://linuxcore.site) · [Inicio rápido](#inicio-rápido) · [Datos y comandos](#datos-y-comandos) · [Documentación](#documentación) · [Automatización](#automatización) · [Contribuir](#contribuir)

</div>

> [!IMPORTANT]
> **Repositorio en desarrollo activo:** La estructura de carpetas y la documentación están sujetas a cambios.

## Qué es LinuxCore

**Linux Core** es un repositorio creado a raíz de su predecesor [LinuxCommands](https://github.com/nisamov/LinuxCommands), con el fin de consolidar años de experiencia en sistemas Linux, arquitectura de computadores, prácticas de seguridad e infraestructuras modernas.

El objetivo es proporcionar el contexto técnico necesario para comprender no solo cómo utilizar una herramienta, servicio o protocolo, sino también el porqué de su funcionamiento y en qué escenarios debe aplicarse. El contenido se desarrolla en español y está orientado tanto al aprendizaje estructurado como a la consulta técnica rápida.

| Qué ofrece | Detalle |
| --- | --- |
| Documentación técnica | Teoría y procedimientos de redes, almacenamiento, seguridad, servicios, virtualización, contenedores y bases de datos, con los ficheros de configuración de ejemplo junto a cada tema. |
| Referencia de comandos | Fichas JSON de comandos de Linux, validadas con un [esquema oficial](.github/schemas/comando.schema.json), con parámetros, riesgos, instalación y ejemplos. |
| Datos abiertos | Las fichas de comandos y de distribuciones se compilan en dos archivos JSON que se publican en cada cambio, listos para scripts, paneles o aplicaciones propias. |
| Sitio web | [linuxcore.site](https://linuxcore.site) muestra comandos y distribuciones con búsqueda, a partir de los mismos datos de este repositorio. |

### Pensado para quien administra sistemas

- **Seguridad antes de ejecutar:** cada ficha de comando indica su nivel de riesgo, si es destructivo, si necesita permisos de superusuario y qué advertencias tener en cuenta.
- **Instalación por familia de distribución:** la orden de instalación para Debian y Ubuntu, Arch Linux y RHEL y CentOS.
- **Ejemplos con resultado esperado:** cada ejemplo describe qué hace y qué debería verse al ejecutarlo.
- **Datos para automatizar:** las fichas indican si el comando es idempotente, interactivo o apto para scripts, qué validaciones hacer antes y cómo revertirlo.
- **Procedimientos completos:** ampliar una partición, reemplazar un disco, montar DNS dinámico con BIND9 o alta disponibilidad en DHCP, con los ficheros de configuración reales.

## Inicio rápido

### Consultar la web

Abre [linuxcore.site](https://linuxcore.site) para buscar comandos y distribuciones. La plataforma sincroniza su base de datos con este repositorio y se actualiza de forma automática tras cada contribución.

### Ejecutar la web en local con Docker

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

### Descargar los datos

> [!NOTE]
> **Base de datos exportable**
> El proyecto distribuye la referencia de comandos y distribuciones en formato **JSON**, optimizada para alimentar el sitio web **[linuxcore.site](https://linuxcore.site)**.
>
> __Descargar la última versión compilada:__ [![Latest Release](https://img.shields.io/github/v/release/nisamov/linuxcore?display_name=release&style=flat-square&color=0969da&label=release)](https://github.com/nisamov/linuxcore/releases/latest)

```bash
curl -fsSLO https://github.com/nisamov/linuxcore/releases/latest/download/commands.json
curl -fsSLO https://github.com/nisamov/linuxcore/releases/latest/download/distros.json
```

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

## Documentación

La documentación está en [`documentacion/`](documentacion), organizada por áreas. Cada tema incluye la teoría y, cuando procede, los ficheros de configuración o scripts de ejemplo.

### Rutas recomendadas

Cada ruta se lee en el orden indicado.

| Objetivo | Recorrido |
| --- | --- |
| Servicios de red | [Puertos](documentacion/redes/fundamentos/teoria_puertos.md) · [DHCP](documentacion/redes/dhcp/teoria_dhcp.md) · [DNS](documentacion/redes/dns/teoria_dns.md) · [BIND9](documentacion/redes/dns/bind9/teoria_bind9.md) · [SSH](documentacion/redes/ssh/teoria_ssh.md) · [Diagnosticar conectividad](documentacion/redes/diagnostico/diagnosticar_conectividad.md) |
| Almacenamiento y recuperación | [Discos y particiones](documentacion/sistema/almacenamiento/teoria_discos_particiones.md) · [Ampliar una partición](documentacion/sistema/almacenamiento/ampliar_particion.md) · [RAID](documentacion/sistema/almacenamiento/raid/teoria_raid.md) · [Reemplazar un disco](documentacion/sistema/almacenamiento/reemplazar_disco.md) · [Recuperar sistema de archivos](documentacion/sistema/almacenamiento/recuperar_sistema_archivos.md) · [Borg](documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md) |
| Seguridad y auditoría | [Teoría de seguridad](documentacion/seguridad/teoria_seguridad.md) · [Permisos](documentacion/sistema/permisos/permisos_archivos_directorios.md) · [ACL](documentacion/sistema/permisos/listas_acceso.md) · [iptables](documentacion/seguridad/firewall/iptables/teoria_iptables.md) · [UFW](documentacion/seguridad/firewall/ufw/teoria_ufw.md) · [Auditoría](documentacion/seguridad/forense/auditoria/audit_planning.md) · [Forense](documentacion/seguridad/forense/teoria_forense.md) |
| Virtualización y contenedores | [Máquinas virtuales](documentacion/infraestructura/virtualizacion/teoria_mv.md) · [Hipervisores](documentacion/infraestructura/virtualizacion/teoria_hipervisor.md) · [Proxmox](documentacion/infraestructura/virtualizacion/teoria_proxmox.md) · [Docker](documentacion/infraestructura/contenedores/docker/teoria_docker.md) · [Kubernetes](documentacion/infraestructura/contenedores/kubernetes/teoria_kubernetes.md) |
| Bases de datos | [MySQL y MariaDB, en orden de lectura](#bases-de-datos) |

### Sistema

| Tema | Documento | Contenido |
| --- | --- | --- |
| Linux | [Teoría de Linux](documentacion/sistema/linux/teoria_linux.md) | Fundamentos del sistema operativo. |
| Linux | [Linus Torvalds](documentacion/sistema/linux/linus_torvalds.md) | Origen y contexto histórico. |
| Permisos | [Permisos de archivos y directorios](documentacion/sistema/permisos/permisos_archivos_directorios.md) | Modelo clásico `rwx`, propietarios y grupos. |
| Permisos | [Listas de control de acceso](documentacion/sistema/permisos/listas_acceso.md) | ACLs con `getfacl` / `setfacl`. |
| Procesos | [Teoría de procesos](documentacion/sistema/procesos/teoria_de_procesos.md) | Ciclo de vida, estados y señales. |
| Procesos | [Proceso zombie](documentacion/sistema/procesos/proceso_zombie.md) | Qué son y cómo tratarlos. |
| Procesos | [Proceso consumiendo CPU](documentacion/sistema/procesos/proceso_consumiendo_cpu.md) | Diagnóstico de uso excesivo de CPU. |
| Almacenamiento | [Teoría de almacenamiento](documentacion/sistema/almacenamiento/teoria_almacenamiento.md) | Conceptos generales. |
| Almacenamiento | [Discos y particiones](documentacion/sistema/almacenamiento/teoria_discos_particiones.md) | Tablas de particiones y sistemas de archivos. |
| Almacenamiento | [Ampliar una partición](documentacion/sistema/almacenamiento/ampliar_particion.md) | Procedimiento paso a paso. |
| Almacenamiento | [Reemplazar un disco](documentacion/sistema/almacenamiento/reemplazar_disco.md) | Sustitución de disco. |
| Almacenamiento | [Recuperar sistema de archivos](documentacion/sistema/almacenamiento/recuperar_sistema_archivos.md) | Reparación y recuperación. |
| RAID | [Teoría de RAID](documentacion/sistema/almacenamiento/raid/teoria_raid.md) | Niveles y casos de uso. |
| RAID | [RAID 1](documentacion/sistema/almacenamiento/raid/raid1.md) | Montaje práctico. |
| RAID | [RAID (versión compacta)](documentacion/sistema/almacenamiento/raid/raid_compressed.md) | Resumen rápido. |
| Hardware | [RAM](documentacion/sistema/hardware/ram.md) | Funcionamiento y tipos de memoria. |

### Redes

| Tema | Documento | Contenido |
| --- | --- | --- |
| Fundamentos | [Topología de redes](documentacion/redes/fundamentos/topologia_redes.md) | Tipos de topología. |
| Fundamentos | [Puertos](documentacion/redes/fundamentos/teoria_puertos.md) | Puertos y servicios asociados. |
| Fundamentos | [ARP](documentacion/redes/fundamentos/arp.md) | Resolución de direcciones. |
| Fundamentos | [TTL e ICMP](documentacion/redes/fundamentos/ttl_icmp.md) | Funcionamiento de `ping` y `traceroute`. |
| Diagnóstico | [Diagnosticar conectividad](documentacion/redes/diagnostico/diagnosticar_conectividad.md) | Comprobación de conexión. |
| Diagnóstico | [Diagnosticar rutas](documentacion/redes/diagnostico/diagnosticar_rutas.md) | Análisis de rutas. |
| DHCP | [Teoría de DHCP](documentacion/redes/dhcp/teoria_dhcp.md) | ISC DHCP: concepto y configuración. |
| DHCP | [DHCP *failover*](documentacion/redes/dhcp/failover/teoria_dhcp_failover.md) | Alta disponibilidad con ISC. |
| DHCP | [Kea](documentacion/redes/dhcp/kea/teoria_kea.md) | Servidor DHCP moderno. |
| DHCP | [Kea *failover*](documentacion/redes/dhcp/kea/failover/teoria_kea_failover.md) | Alta disponibilidad con Kea. |
| DHCP | [Ficheros de configuración](documentacion/redes/dhcp/configuracion/) | `dhcpd.conf` y Netplan de ambos servidores. |
| DNS | [Teoría de DNS](documentacion/redes/dns/teoria_dns.md) | Jerarquía y resolución. |
| DNS | [Diagnosticar DNS](documentacion/redes/dns/diagnosticar_dns.md) | Resolución de problemas. |
| DNS | [BIND9](documentacion/redes/dns/bind9/teoria_bind9.md) | Servidor autoritativo. |
| DNS | [DDNS en BIND9](documentacion/redes/dns/bind9/dinamico/procedimiento.md) | Actualizaciones dinámicas; ver también los [ficheros del procedimiento](documentacion/redes/dns/bind9/dinamico/). |
| DNS | [Zonas y configuración BIND9](documentacion/redes/dns/bind9/) | Zonas directa/inversa, maestro y esclavo. |
| FTP | [Teoría de FTP](documentacion/redes/ftp/teoria_ftp.md) | Protocolo y modos. |
| NFS | [Teoría de NFS](documentacion/redes/nfs/teoria_nfs.md) | Recursos compartidos en red; ver también [`exports`](documentacion/redes/nfs/exports) y [`fstab`](documentacion/redes/nfs/fstab). |
| Samba | [General de Samba](documentacion/redes/samba/general_samba.md) | Compartición con Windows; ver [`smb.conf`](documentacion/redes/samba/smb.conf). |
| SSH | [Teoría de SSH](documentacion/redes/ssh/teoria_ssh.md) | Acceso remoto seguro. |
| SSH | [Comandos y casos de uso](documentacion/redes/ssh/uso.md) | Conexiones y ejecución remota. |

### Seguridad

| Tema | Documento | Contenido |
| --- | --- | --- |
| General | [Teoría de seguridad](documentacion/seguridad/teoria_seguridad.md) | Principios y conceptos. |
| Autenticación | [libpam-passwdqc](documentacion/seguridad/autenticacion/libpam-passwdqc.md) | Política de contraseñas. |
| Criptografía | [Cifrado](documentacion/seguridad/criptografia/cifrado/teoria_cifrado.md) | Simétrico y asimétrico. |
| Criptografía | [Hash](documentacion/seguridad/criptografia/hash/teoria_hash.md) | Funciones resumen e integridad. |
| Criptografía | [Firma digital](documentacion/seguridad/criptografia/firma_digital/teoria_firma_digital.md) | Fundamentos. |
| Criptografía | [Firma SSL](documentacion/seguridad/criptografia/firma_digital/firma_ssl.md) | Aplicación práctica. |
| Criptografía | [Certificado RSA con OpenSSL](documentacion/seguridad/criptografia/certificados/certificado_rsa_openssl.md) | Generación de certificados. |
| Criptografía | [Entidad certificadora](documentacion/seguridad/criptografia/certificados/entidad_certificadora.sh) | Script de CA. |
| Cortafuegos | [iptables](documentacion/seguridad/firewall/iptables/teoria_iptables.md) | Reglas y cadenas. |
| Cortafuegos | [UFW](documentacion/seguridad/firewall/ufw/teoria_ufw.md) | Cortafuegos simplificado. |
| Cortafuegos | [nftables](documentacion/seguridad/firewall/nftables/nftables.conf) | Configuración de ejemplo. |
| Forense | [Teoría forense](documentacion/seguridad/forense/teoria_forense.md) | Metodología. |
| Forense | [Planificación de auditoría](documentacion/seguridad/forense/auditoria/audit_planning.md) | Auditoría con `auditd`. |
| Forense | [Foremost](documentacion/seguridad/forense/herramientas/foremost.md) | Recuperación de archivos. |
| Forense | [Definición de datos](documentacion/seguridad/forense/herramientas/datadefinition.md) | Conceptos de datos. |
| OSINT | `seguridad/osint/` | Herramientas y teoría |

### Servicios

| Tema | Documento | Contenido |
| --- | --- | --- |
| Web | [Apache2](documentacion/servicios/web/apache2/teoria_apache2.md) | Servidor web. |
| Web | [Nginx](documentacion/servicios/web/nginx/teoria_nginx.md) | Servidor web y proxy inverso. |
| Sistema | [Cron](documentacion/servicios/sistema/cron/teoria_cron.md) | Tareas programadas. |
| Sistema | [Journal](documentacion/servicios/sistema/journal/teoria_journal.md) | Registros con `journald`. |
| Sistema | [Diagnosticar systemd](documentacion/servicios/sistema/systemd/diagnosticar_systemd.md) | Resolución de problemas. |
| Sistema | [Ejemplo de unidad](documentacion/servicios/sistema/systemd/ejemplo.service) | Fichero `.service` de ejemplo. |

### Infraestructura

| Tema | Documento | Contenido |
| --- | --- | --- |
| Virtualización | [Máquinas virtuales](documentacion/infraestructura/virtualizacion/teoria_mv.md) | Conceptos básicos. |
| Virtualización | [Hipervisores](documentacion/infraestructura/virtualizacion/teoria_hipervisor.md) | Tipo 1 y tipo 2. |
| Virtualización | [Proxmox](documentacion/infraestructura/virtualizacion/teoria_proxmox.md) | Plataforma de virtualización. |
| Virtualización | [VirtualBox](documentacion/infraestructura/virtualizacion/teoria_virtualbox.md) | Hipervisor de escritorio. |
| Virtualización | [Hyper-V](documentacion/infraestructura/virtualizacion/teoria_hyper-v.md) | Hipervisor de Microsoft. |
| Contenedores | [Docker: teoría](documentacion/infraestructura/contenedores/docker/teoria_docker.md) | Conceptos. |
| Contenedores | [Docker: instalación](documentacion/infraestructura/contenedores/docker/instalacion.md) | Puesta en marcha. |
| Contenedores | [Kubernetes](documentacion/infraestructura/contenedores/kubernetes/teoria_kubernetes.md) | Orquestación. |
| Contenedores | [LXC](documentacion/infraestructura/contenedores/lxc/teoria_lxc.md) | Contenedores de sistema. |
| Copias de seguridad | [Borg](documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md) | Backups deduplicados. |

### Bases de datos

| Tema | Documento | Contenido |
|---|---|---|
| Fundamentos | [fundamentos.md](documentacion/bases_de_datos/mysql_mariadb/fundamentos.md) | Conceptos básicos y arquitectura general de MySQL/MariaDB |
| Instalación y servicio | [instalacion_y_servicio.md](documentacion/bases_de_datos/mysql_mariadb/instalacion_y_servicio.md) | Guía de instalación y gestión del servicio del sistema |
| Configuración del servidor | [configuracion_servidor.md](documentacion/bases_de_datos/mysql_mariadb/configuracion_servidor.md) | Parámetros del motor, archivos de configuración y ajustes |
| Bases y tablas | [bases_y_tablas.md](documentacion/bases_de_datos/mysql_mariadb/bases_y_tablas.md) | Creación, modificación y estructura de bases de datos y tablas |
| Consultas y funciones | [consultas_y_funciones.md](documentacion/bases_de_datos/mysql_mariadb/consultas_y_funciones.md) | Consultas SQL, manipulación de datos y funciones integradas |
| Joins y uniones | [joins_y_uniones.md](documentacion/bases_de_datos/mysql_mariadb/joins_y_uniones.md) | Combinación de tablas mediante tipos de JOIN y UNION |
| Usuarios y permisos | [usuarios_y_permisos.md](documentacion/bases_de_datos/mysql_mariadb/usuarios_y_permisos.md) | Gestión de cuentas de usuario y asignación de privilegios |
| Seguridad | [seguridad.md](documentacion/bases_de_datos/mysql_mariadb/seguridad.md) | Buenas prácticas, hardening y protección de datos |
| Transacciones y concurrencia | [transacciones_y_concurrencia.md](documentacion/bases_de_datos/mysql_mariadb/transacciones_y_concurrencia.md) | Control transaccional (ACID), bloqueos y aislamiento |
| Metadatos y caché de consultas | [metadatos_y_cache_de_consultas.md](documentacion/bases_de_datos/mysql_mariadb/metadatos_y_cache_de_consultas.md) | Inspección de metadatos, esquemas del sistema y caché |
| Copias de seguridad y recuperación | [copias_seguridad_y_recuperacion.md](documentacion/bases_de_datos/mysql_mariadb/copias_seguridad_y_recuperacion.md) | Estrategias de backup (mysqldump) y restauración |
| Construcción de guiones | [declaracion.md](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/declaracion.md) | Declaración y uso de variables en scripts |
| Construcción de guiones | [condicionales.md](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/condicionales.md) | Estructuras de control de flujo (IF, CASE) |
| Construcción de guiones | [funciones.md](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/funciones.md) | Definición y uso de funciones personalizadas |
| Construcción de guiones | [delimitador.md](documentacion/bases_de_datos/mysql_mariadb/construccion_guiones/delimitador.md) | Uso y sintaxis del comando DELIMITER |

### Programación

| Tema | Documento | Contenido |
| --- | --- | --- |
| Conceptos | [Introducción](documentacion/programacion/conceptos/introduccion.md) | Fundamentos de programación. |
| Bash | [Comentarios](documentacion/programacion/bash/comentarios.sh) · [Input](documentacion/programacion/bash/input.sh) · [Operadores aritméticos](documentacion/programacion/bash/operadores_aritmeticos.sh) | Sintaxis básica. |
| Bash | [Condiciones](documentacion/programacion/bash/condiciones_evaluacion.sh) · [Control de flujo](documentacion/programacion/bash/control_flujo.sh) · [Devolución](documentacion/programacion/bash/devolucion.sh) | Lógica y funciones. |
| PHP | [Comentarios](documentacion/programacion/php/comentarios.php) · [Variables](documentacion/programacion/php/variables.php) · [Concatenación](documentacion/programacion/php/concatenacion.php) | Sintaxis básica. |
| PHP | [Condicionales](documentacion/programacion/php/condicionales.php) · [Conversión](documentacion/programacion/php/conversion.php) | Lógica y tipos. |

## Estructura del repositorio

```text
linuxcore/
├── documentacion/     Teoría, procedimientos y ficheros de ejemplo, por área
│   ├── bases_de_datos/  infraestructura/  programacion/  redes/
│   └── seguridad/       servicios/        sistema/
├── json/
│   ├── comandos/        Una ficha JSON por comando, en 12 categorías
│   ├── distribuciones/  Una ficha JSON por distribución
│   └── servicios/       En desarrollo
├── docker/            Dockerfile de la web en local
├── .github/
│   ├── schemas/         Esquema JSON de las fichas de comandos
│   ├── scripts/         Validación y generación de las bases de datos
│   ├── workflows/       Automatización con GitHub Actions
│   └── ISSUE_TEMPLATE/  Plantillas de incidencias
├── ACCESSIBILITY.md   Criterios de accesibilidad
└── CHANGELOG.md       Registro de cambios
```

## Automatización

Los cambios se comprueban y se publican de forma automática con GitHub Actions.

| Flujo de trabajo | Qué hace | Cuándo se ejecuta |
| --- | --- | --- |
| Generación bases de datos | Valida las fichas de comandos con el esquema, compila `commands.json` y `distros.json` y los publica en la última release. | Al cambiar `json/comandos/`, `json/distribuciones/`, el esquema o los scripts asociados. |
| Validación de documentación | Comprueba que los enlaces internos de los archivos Markdown apuntan a archivos que existen. | Al cambiar archivos `.md`. |
| Detección de claves secretas | Busca credenciales y claves accidentales en el contenido. | En cada `push` y en cada Pull Request. |
| Publicar imagen Docker | Construye y publica la imagen de la web en `ghcr.io` para `amd64` y `arm64`. | En cada release y una vez por semana. |

Dependabot revisa las acciones de GitHub una vez al mes.

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
| [Agradecimientos](.github/AGRADECIMIENTOS.md) | Reconocimiento a quienes han aportado conocimiento. |

> [!WARNING]
> El contenido se proporciona con fines informativos. Prueba los comandos y los scripts en una máquina virtual o un contenedor antes de usarlos en producción, sobre todo los que requieren `sudo` o están marcados como destructivos.

## Colaboradores

<div align="center">
  <a href="https://github.com/nisamov/linuxcore/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Nisamov/linuxcore" alt="Contribuyentes de LinuxCore" />
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