# Sobre Hipervisores

Un hipervisor (o VMM, Virtual Machine Monitor) es una capa de software, firmware o hardware que permite crear, gestionar y ejecutar máquinas virtuales. Su función principal es abstraer y dividir los recursos del hardware físico (CPU, RAM, almacenamiento y red) para repartirlos de forma aislada entre varios sistemas operativos independientes.

## Tipos de hipervisor

### Tipo 1 (Bare Metal / Nativo)

* Ubicación: Se ejecuta directamente sobre el hardware físico de la máquina, sin necesidad de un sistema operativo previo.
* Características:
    * Máximo rendimiento y baja latencia al no tener intermediarios.
    * Mayor nivel de seguridad y estabilidad.
    * Orientado a servidores corporativos, centros de datos y entornos de producción.

Ejemplos: VMware ESXi, Microsoft Hyper-V, Proxmox VE, KVM, Xen.

### Tipo 2 (Hosted / Alojado)
* Ubicación: Se instala y ejecuta como una aplicación sobre un sistema operativo anfitrión (Host OS) convencional (Windows, Linux, macOS).
* Características:
    * Fácil de instalar, configurar y utilizar.
    * Menor rendimiento (overhead) debido a la capa extra del sistema operativo base.
    * Ideal para entornos de desarrollo, pruebas, laboratorio o uso personal.

Ejemplos: Oracle VirtualBox, VMware Workstation / Fusion, Parallels Desktop

Un proxmox es un software que se instala sobre un sistema operativo de virtualizacion
