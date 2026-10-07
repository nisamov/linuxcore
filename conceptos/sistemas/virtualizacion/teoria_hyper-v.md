# Teoría General Microsoft Hyper-V

## ¿Cómo funciona Microsoft Hyper-V?

Hyper-V es la solución de virtualización de Microsoft, integrada en Windows Server y en las versiones Pro de Windows. Aunque se activa como una característica más del sistema operativo, su arquitectura corresponde a la de un hipervisor de **Tipo 1**.

* **Arquitectura:** Al activar Hyper-V, la secuencia de arranque cambia. El hipervisor se carga antes que el propio sistema operativo Windows. El sistema Windows que el usuario opera pasa a ejecutarse sobre una máquina virtual especial llamada **partición raíz** (o *parent partition*), que dispone de privilegios para acceder directamente al hardware y administrar las demás máquinas virtuales, conocidas como **particiones hijas** (*child partitions*). De esta forma, el hipervisor queda situado por debajo del sistema operativo, controlando todo el hardware.

## Características clave

* **Integración con el ecosistema Microsoft:** Se administra de manera nativa mediante herramientas de la plataforma como PowerShell, Hyper-V Manager y System Center, optimizando la gestión en entornos de red Windows.
* **Live Migration:** Permite transferir máquinas virtuales en ejecución de un servidor físico a otro en tiempo real sin interrumpir el servicio.
* **Seguridad avanzada:** Incluye funcionalidades como *Shielded VMs* (máquinas virtuales blindadas) para proteger los datos e instancias incluso frente a los administradores del propio hipervisor.

## Arranque nativo desde VHD (Native Boot)

El arranque nativo desde VHD (*Native Boot from VHD/VHDX*) consiste en configurar el gestor de arranque del equipo físico (*Windows Boot Manager*) para que apunte directamente a un archivo de disco virtual (`.vhd` o `.vhdx`) e inicie el sistema operativo contenido en su interior, omitiendo el sistema operativo anfitrión tradicional.

* **Matización técnica:** Cuando se utiliza el arranque nativo, la máquina no se ejecuta realmente dentro de Hyper-V ni requiere del hipervisor para funcionar.
* **Modo bare-metal:** El sistema operativo del VHD interactúa directamente con el hardware real del equipo (procesador, memoria RAM, tarjeta gráfica y red) sin ninguna capa de abstracción intermedia. Simplemente emplea el archivo VHD como si fuera un disco duro físico.
* **Utilidad:** Es una técnica muy empleada por administradores y desarrolladores para probar sistemas operativos en hardware real con un rendimiento del 100%, sin necesidad de alterar o reestructurar las particiones del disco físico.
