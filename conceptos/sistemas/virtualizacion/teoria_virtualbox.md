# Teoría General Oracle VM VirtualBox

## ¿Cómo funciona Oracle VM VirtualBox?

VirtualBox es el ejemplo más popular de hipervisor de Tipo 2. Su enfoque principal es la facilidad de uso y la interoperabilidad entre diferentes sistemas operativos.

* **Arquitectura:** VirtualBox se instala y se ejecuta como una aplicación estándar dentro del sistema operativo anfitrión (*host*). Cuando creas y arrancas una máquina virtual, esta solicita al sistema anfitrión la asignación de recursos (memoria RAM, tiempo de procesador y espacio en disco).
* **Gestión de recursos:** Todas las operaciones de la máquina virtual invitada (*guest*) son gestionadas por el proceso de VirtualBox, el cual a su vez depende del planificador del sistema operativo anfitrión. Esto crea una capa de abstracción adicional que otorga gran flexibilidad, aunque resulta ligeramente menos eficiente que un hipervisor de Tipo 1.

## Características clave

* **Multiplataforma:** Se puede instalar en sistemas anfitriones Windows, macOS o Linux y ejecutar máquinas virtuales de casi cualquier sistema operativo. Es una herramienta fundamental para desarrollo y administración de sistemas.
* **Facilidad de uso:** Posee una interfaz gráfica muy intuitiva que permite crear y configurar máquinas virtuales en pocos minutos sin requerir conocimientos avanzados.
* **Guest Additions:** Paquete de software que se instala dentro de la máquina virtual invitada para ofrecer una integración profunda con el anfitrión, habilitando funciones como portapapeles compartido, arrastrar y soltar archivos, ajuste automático de resolución y movimiento fluido del ratón.
* **Instantáneas (*Snapshots*):** Permite congelar el estado completo de una máquina virtual en un punto específico. Si un cambio posterior daña el sistema, se puede revertir al estado anterior en segundos.
* **Gratuito y de código abierto:** El producto base es software libre y de código abierto (FOSS), permitiendo su uso sin restricciones en entornos personales, educativos o profesionales.

## Parámetros clave en la creación de la VM

### Tipo y versión del sistema operativo

La elección del tipo (por ejemplo, Linux) y la versión (por ejemplo, Ubuntu 64-bit) es fundamental, ya que VirtualBox utiliza esta información para preconfigurar la máquina virtual con valores optimizados:

* Activa o desactiva automáticamente opciones avanzadas como I/O APIC.
* Sugiere una cantidad de memoria RAM y tamaño de disco recomendados.
* Selecciona el tipo de tarjeta de red y de sonido con mayor compatibilidad.

## Asignación de recursos de hardware

Los recursos asignados a la máquina virtual se reservan o consumen directamente del equipo anfitrión (*host*).

### Procesadores (CPU)

* **Función en un servidor:** La CPU ejecuta las instrucciones del sistema operativo y sus aplicaciones. En entornos de servidor prima la capacidad de procesamiento en paralelo (múltiples núcleos o hilos de ejecución) sobre la velocidad de un solo núcleo.
* **vCPUs vs. núcleos físicos:** No se asignan núcleos físicos directos, sino CPUs virtuales (vCPUs). El hipervisor planifica el tiempo de ejecución de estas vCPUs sobre los núcleos reales del anfitrión.
* **Criterio de asignación:** Cada vCPU adicional introduce una pequeña sobrecarga de gestión. Asignar demasiados núcleos a una VM que no los necesita puede degradar el rendimiento general.
* **Recomendación para Ubuntu Server:** Comenzar con 1 vCPU. Solo se justifica aumentar a 2 o más si se ejecutarán aplicaciones capaces de paralelizar sus cargas de trabajo.

### Memoria RAM

* **Función en un servidor:** Es la memoria ultrarrápida donde se cargan el sistema operativo, las aplicaciones activas y sus datos. Si el sistema se queda sin RAM, recurre al disco duro como memoria temporal (*swapping*), desplomando el rendimiento.
* **Reserva de memoria:** La RAM asignada queda reservada para uso exclusivo de la VM mientras esté encendida.
* **Criterio de asignación:** Asignar poca RAM obligará al sistema invitado a usar *swap*; asignar demasiada ralentizará al sistema anfitrión.
* **Recomendación para Ubuntu Server:** Para un servidor sin entorno gráfico, entre 1024 MB (1 GB) y 2048 MB (2 GB) es un punto de partida óptimo.

### Disco duro virtual

* **Función en un servidor:** Constituye el almacenamiento permanente para el sistema operativo, programas y datos. La velocidad de lectura y escritura es crucial para el rendimiento.
* **Reservado dinámicamente:** El archivo del disco crece a medida que se guarda información. Ahorra espacio en el anfitrión, pero es ligeramente más lento. Ideal para entornos de prueba o laboratorio.
* **Tamaño fijo:** El archivo ocupa todo el espacio asignado desde el principio. Ofrece un rendimiento de E/S superior y es la opción recomendada para producción.

## Configuración de red: adaptadores

Determina la manera en que la máquina virtual interactúa con la red del anfitrión e Internet:

* **No conectado:** Simula una tarjeta de red sin cable enchufado. La máquina virtual permanece completamente aislada sin conectividad.
* **NAT (*Network Address Translation*):** Modo por defecto. VirtualBox actúa como un router con salida a Internet para la VM, pero impidiendo conexiones entrantes desde el exterior. Ideal para descargar paquetes y actualizaciones de forma segura.
* **Red NAT:** Evolución del modo NAT que crea una red privada virtual donde varias VMs pueden comunicarse entre sí y compartir una misma salida a Internet. Excelente para arquitecturas compuestas (ej. servidor web + servidor de base de datos).
* **Adaptador puente (*Bridged Adapter*):** La VM se conecta directamente a la red física del anfitrión, obteniendo su propia IP del router de la red local. Se comporta como un equipo físico independiente, permitiendo a cualquier dispositivo de la red acceder a sus servicios.
* **Red interna (*Internal Network*):** Crea una red virtual totalmente aislada exclusivamente para las VMs seleccionadas. Sin salida a Internet ni comunicación con el anfitrión. Ideal para laboratorios cerrados y pruebas de seguridad.
* **Adaptador solo-anfitrión (*Host-Only Adapter*):** Establece una red privada exclusiva entre el ordenador anfitrión y las VMs. Permite la administración local (ej. mediante SSH) sin exponer el entorno a la red física ni dar acceso a Internet.
* **Driver genérico (*Generic Driver*):** Modo avanzado que utiliza controladores personalizados o genéricos. Utilizado para emulaciones especializadas o sistemas operativos muy antiguos.
