<p align="center">
  <img src=".github/media/top.png" alt="LinuxCore Header" width="100%">
</p>

<div align="center">

# Linux Core

[![MIT License](https://img.shields.io/github/license/nisamov/linuxcore?style=flat-square&color=0969da)](LICENSE) [![Website](https://img.shields.io/badge/website-linuxcore.site-0969da?style=flat-square)](https://linuxcore.site/) [![DB Build](https://img.shields.io/github/actions/workflow/status/nisamov/linuxcore/commands_db_gen.yaml?style=flat-square&color=0969da&label=db%20build)](https://github.com/nisamov/linuxcore/actions) [![Last Commit](https://img.shields.io/github/last-commit/nisamov/linuxcore?style=flat-square&color=0969da)](https://github.com/nisamov/linuxcore/commits)

**Documentación y fundamentos de informática en Español**

</div>

---

## Descripción del Proyecto

**LinuxCore** es un repositorio creado a raíz de su predecesor [LinuxCommands](https://github.com/nisamov/LinuxCommands), con el fin de consolidar años de experiencia en sistemas Linux, arquitectura de computadores, prácticas de seguridad e infraestructuras modernas.

El objetivo es proporcionar el contexto técnico necesario para comprender no solo cómo utilizar una herramienta, servicio o protocolo, sino también el porqué de su funcionamiento y en qué escenarios debe aplicarse.

El contenido se desarrolla en español y está orientado tanto al aprendizaje estructurado como a la consulta técnica rápida.

> [!IMPORTANT]
> Este repositorio está en **desarrollo activo**. Su estructura y contenido pueden cambiar en cualquier momento para mejorar la formato y la consistencia.

Incluye una base de datos en formato JSON disponible en [`releases/`](https://github.com/nisamov/linuxcore/releases), optimizada para el sitio web [linuxcore.site](https://linuxcore.site).

[![Latest Release](https://img.shields.io/github/v/release/nisamov/linuxcore?display_name=release&style=flat-square&color=0969da&label=release)](https://github.com/nisamov/linuxcore/releases/latest)

---

## Estructura de Contenidos

### `fundamentos/`
Conceptos teóricos esenciales para comprender los sistemas informáticos y la arquitectura GNU/Linux.
* Arquitectura de sistemas y fundamentos de hardware.
* Procesos, planificación, estados y ciclo de vida.
* Almacenamiento, RAID, sistemas de archivos y permisos (ACL).
* Documentación detallada sobre distribuciones Linux.

### `comandos/`
Referencia estructurada de herramientas y utilidades del sistema.
* Clasificación por categorías (`almacenamiento`, `archivos`, `compresion`, `info_sistema`, `paquetes`, `procesos`, `red`, `seguridad`, `servicios`, `usuarios`).
* Comandos de propósito general y utilidades en una sola línea (*one-liners*).
* Entradas almacenadas en formato **JSON** para facilitar su procesamiento por herramientas externas.

### `procedimientos/`
Documentación orientada a tareas concretas de administración, diagnóstico y resolución de problemas (*troubleshooting*).
* **Almacenamiento:** Ampliación de particiones, sustitución de discos y recuperación de sistemas de archivos.
* **Diagnóstico:** Detección de procesos zombie, consumo excesivo de CPU y rendimiento.
* **Red y Servicios:** Diagnóstico de conectividad, resolución DNS, rutas, SSH y `systemd`.

### `servicios/` y `protocolos/`
Documentación sobre demonios, infraestructuras y comunicación en red.
* **Servicios:** Bases de datos (MariaDB, PostgreSQL, Redis), servidores web (Apache, Nginx) y demonios del sistema.
* **Redes y Protocolos:** Análisis en profundidad de protocolos como DHCP, KEA y topologías de red.

### `seguridad/`
Estudio de la seguridad informática desde múltiples perspectivas.
* **Seguridad defensiva:** Mecanismos de protección, control de acceso, criptografía, algoritmos de hash, firmas digitales y canales seguros.
* **Seguridad ofensiva y forense:** Auditoría con `auditd`, análisis de logs y evaluación de sistemas.

### `programacion/` y `bases_datos/`
Material aplicado a la automatización y gestión de datos.
* Shell Scripting (Bash) y PHP.
* Teoría general de bases de datos relacionales, SQL, Joins y administración de MySQL/MariaDB.

### `infraestructura/` y `hardware/`
Tecnologías de despliegue y componentes físicos.
* Contenerización con Docker y bases teóricas de Kubernetes e hipervisores.
* Documentación sobre componentes de hardware (memoria RAM, almacenamiento físico).

### `referencias/`
Plantillas y archivos de configuración reales listos para producción.
* Configuraciones para BIND9 (DNS dinámico), `nftables.conf`, `smb.conf` y archivos de unidad de `systemd`.

---

> [!NOTE]
> El proyecto dispone de una plataforma web oficial accesible en [linuxcore.site](https://linuxcore.site/). Dicha plataforma sincroniza su base de datos directamente con este repositorio, aplicando las actualizaciones de forma automática tras cada contribución.

---

## Colaboradores

<div align="center">
  <a href="https://github.com/nisamov/linuxcore/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=nisamov/linuxcore" alt="Contribuyentes de LinuxCore" />
  </a>
</div>

Este es un proyecto desarrollado con fines de aprendizaje y consulta. Cualquier contribución, sugerencia o corrección es bienvenida.

<br>

<div align="center">
  <p><b>Linux Core - Nisamov | MIT License - 2026</b></p>
  <p><b>Contacto:</b> <a href="mailto:nisamov.contact@gmail.com">nisamov.contact@gmail.com</a></p>
  <p align="center">
    <img src=".github/media/bottom.png" alt="LinuxCore Footer" width="100%">
  </p>
</div>