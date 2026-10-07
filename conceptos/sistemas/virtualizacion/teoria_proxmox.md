# Teoría General Proxmox

## ¿Cómo funciona Proxmox VE?

Proxmox Virtual Environment (VE) es una plataforma de virtualización de código abierto basada en la distribución Linux Debian.

* **Arquitectura:** Proxmox utiliza el propio kernel de Linux como hipervisor gracias a la tecnología KVM (*Kernel-based Virtual Machine*). Al ser una función nativa del sistema operativo base, KVM tiene acceso directo al hardware del procesador, lo que lo convierte en un hipervisor de **Tipo 1** puro y de alto rendimiento.

## Características clave

* **Código abierto:** Es gratuito y no requiere licencias de pago, lo que lo hace idóneo tanto para entornos corporativos como para laboratorios domésticos (*homelabs*).
* **Doble funcionalidad:** Además de máquinas virtuales (VMs) gestionadas con KVM, integra LXC (*Linux Containers*), una tecnología de virtualización a nivel de sistema operativo mucho más ligera que permite desplegar aplicaciones de forma rápida y con menor consumo de recursos.
* **Gestión web centralizada:** Toda la administración del servidor o del conjunto de servidores se realiza a través de una interfaz web intuitiva y completa.
* **Clúster y Alta Disponibilidad (HA):** Permite agrupar varios servidores físicos fácilmente. Si un servidor falla, las máquinas virtuales pueden reiniciarse automáticamente en otro nodo del clúster.

## Hipervisor Tipo 2 (Hosted)

A diferencia de Proxmox (Tipo 1), un hipervisor de Tipo 2 es un programa que se ejecuta sobre un sistema operativo anfitrión ya instalado (Windows, macOS, Linux), como cualquier otra aplicación.

* **Uso principal:** Es ideal para aprender, desarrollar y realizar pruebas sin modificar la configuración del sistema operativo principal.
* **Rendimiento:** Presenta un impacto menor en el rendimiento respecto al Tipo 1, ya que las peticiones de la máquina virtual hacia el hardware deben atravesar la capa adicional del sistema operativo anfitrión.
* **Ejemplo:** Oracle VM VirtualBox.
