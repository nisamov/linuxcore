# Planificación de laboratorios de virtualización

Una máquina virtual combina CPU virtualizada, memoria, almacenamiento y red simulados por un hipervisor. Una planificación adecuada evita que el equipo anfitrión se quede sin recursos y permite aislar las pruebas.

## Requisitos previos

- Hipervisor instalado y compatible con el procesador anfitrión.
- Virtualización por hardware habilitada en el firmware si el hipervisor la necesita.
- Espacio suficiente en disco para el sistema invitado y sus instantáneas.
- Estimación de los recursos necesarios por cada máquina virtual.

## Planificar recursos

### CPU

Cada vCPU representa tiempo de ejecución planificado sobre núcleos físicos o hilos reales. Para servidores pequeños suele ser suficiente comenzar con una vCPU y añadir núcleos solo si la carga puede paralelizarse.

Reglas generales:

- No asignar más vCPU que núcleos físicos disponibles.
- Reservar capacidad para el sistema anfitrión.
- Comenzar con una asignación baja y aumentar si existen esperas o cuellos de botella.

Comprobación en Linux:

```bash
lscpu
nproc
uptime
```

### Memoria

La memoria asignada se reserva o consume mientras la máquina virtual está funcionando. La máquina necesita RAM suficiente para evitar intercambios constantes con disco.

Como punto de partida:

| Uso | RAM orientativa |
|---|---|
| Terminal o laboratorio mínimo | 1 GB |
| Servidor Ubuntu sin escritorio | 1-2 GB |
| Aplicaciones de escritorio | 2-4 GB o más |
| Bases de datos o servicios simultáneos | Según carga y datos |

No asignar toda la RAM del anfitrión. Mantener memoria libre para el hipervisor y el sistema operativo.

## Discos virtuales

### Reservado dinámico

El archivo crece a medida que se escribe información:

- Ocupa menos espacio al principio.
- Puede fragmentarse o ralentizar las operaciones de entrada y salida.
- Es adecuado para pruebas y laboratorios.

### Tamaño fijo

El archivo ocupa desde el inicio todo el tamaño asignado:

- Suele ofrecer mejor rendimiento de entrada y salida.
- Consume el espacio reservado aunque no esté lleno.
- Puede resultar apropiado para producción o carga intensiva.

Comprueba el espacio antes de crear discos grandes:

```bash
df -h
sudo du -sh /ruta/virtualbox/
```

Evita usar todo el disco libre del anfitrión. Los sistemas de archivos deben conservar espacio para copias, instantáneas y recuperación.

## Modos de red

| Modo | Comunicación con Internet | Acceso desde el anfitrión | Acceso entre VMs | Aislamiento |
|---|---|---|---|---|
| No conectado | No | No | No | Máximo |
| NAT | Sí, normalmente | Limitado sin reenvío | Depende del hipervisor | Alto |
| Red NAT | Sí | Según configuración | Sí | Alto |
| Adaptador puente | Sí | Sí | Sí | Bajo |
| Red interna | No | No | Solo VMs seleccionadas | Muy alto |
| Solo-anfitrión | No necesariamente | Sí | Sí | Alto |

### NAT

Permite que una máquina virtual acceda a Internet y descarga paquetes sin exponer puertos entrantes por defecto.

Para publicar un puerto web local:

```text
Puerto host: 8080
Puerto invitado: 80
```

La configuración concreta debe hacerse en el hipervisor y debe evitarse la exposición de servicios innecesarios.

### Adaptador puente

La máquina virtual obtiene una dirección de la red física y puede comportarse como otro equipo. Solo usarlo cuando el laboratorio necesite acceso real desde otros equipos.

### Red interna

No permite comunicación con el anfitrión ni con Internet. Es apropiada para pruebas de seguridad, DNS, DHCP o rutas aisladas.

### Solo-anfitrión

Permite comunicación privada entre el anfitrión y las máquinas virtuales sin exponerlas a la red física.

## Instantáneas

Una instantánea guarda el estado del disco virtual y, opcionalmente, la memoria y la configuración en un punto determinado.

Crea una instantánea antes de:

- Aplicar una actualización importante.
- Cambiar configuraciones críticas.
- Probar software desconocido.
- Realizar prácticas de seguridad.

No sustituyen las copias de seguridad. Una instantánea depende del disco base y puede crecer mucho si se mantiene durante mucho tiempo.

Antes de eliminar una instantánea:

- Confirma que el estado actual está completo.
- Comprueba el espacio disponible.
- Realiza una copia de los datos que deban conservarse.

## Ejemplo de laboratorio mínimo

Una red interna con tres máquinas:

```text
red-interna: laboratorio

router: 192.0.2.1
servidor: 192.0.2.10
cliente: 192.0.2.20
```

Ejemplo orientativo:

- Router: 1 vCPU, 1 GB RAM y dos adaptadores internos.
- Servidor: 1 vCPU, 2 GB RAM y disco reservado dinámicamente.
- Cliente: 1 vCPU, 1 GB RAM y disco reservado dinámicamente.

Las direcciones `192.0.2.0/24` son exclusivamente de documentación. Sustitúyelas por una red privada que no entre en conflicto con el entorno real.

## Verificación

Dentro de una máquina invitada:

```bash
ip -br address
ip route
ping -c 3 [puerta_de_enlace]
ping -c 3 [otra_maquina]
```

Comprueba también CPU, memoria y almacenamiento:

```bash
free -h
df -h
uptime
```

## Reversión

- Apaga las máquinas virtuales desde el sistema invitado.
- Restaura una instantánea solo después de comprobar qué datos de estado fueron creados después de ella.
- Elimina clones o máquinas temporales que ya no sean necesarios.
- Libera discos diferenciales y revisa el espacio libre del anfitrión.

## Advertencias

- Las instantáneas no protegen contra daños en el almacenamiento físico del anfitrión.
- Una red puente puede exponer servicios a la red local.
- No pruebes ataques, escaneos o denegación de servicio fuera de redes internas que sean propiedad del laboratorio.
