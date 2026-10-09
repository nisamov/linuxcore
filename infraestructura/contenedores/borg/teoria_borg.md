# Teoría General de Google Borg

## Introducción y Concepto General

Google Borg es el sistema central de orquestación y administración de clústeres a gran escala desarrollado por Google. Actúa como el sistema operativo distribuido de la compañía, diseñado para coordinar, asignar recursos y mantener la ejecución continua de aplicaciones sobre infraestructura masiva.

* Ejecuta cientos de miles de trabajos (*jobs*) compuestos por millones de tareas pertenecientes a miles de aplicaciones distintas.
* Opera en múltiples clústeres o células (*Cells*), donde cada célula puede llegar a albergar decenas de miles de máquinas físicas conectadas en red.
* Proporciona la infraestructura subyacente para todos los servicios de Google a nivel mundial, incluyendo Búsqueda, Gmail, Google Drive, Google Maps, YouTube y Google Docs.
* Admite cargas de trabajo mixtas dentro del mismo hardware, combinando servicios interactivos de baja latencia con procesamiento masivo de datos en segundo plano.

## Arquitectura del Clúster

La arquitectura de una célula de Borg sigue un modelo maestro-esclavo distribuido, diseñado para manejar alta concurrencia y tolerar fallos de hardware sin interrumpir las aplicaciones.

* **Borg Cell (Célula):** Conjunto de máquinas físicas pertenecientes a un mismo centro de datos que son administradas como una sola unidad heterogénea de cómputo.
* **BorgMaster:** Componente central del plano de control (*Control Plane*) en cada célula. Responsable de procesar peticiones de usuarios, mantener la base de datos del estado del clúster, supervisar el estado de los nodos y planificar las cargas de trabajo. Para evitar puntos únicos de fallo, se replica en múltiples instancias coordinadas mediante el algoritmo de consenso Paxos.
* **Borglet:** Agente o demonio local que se ejecuta en el espacio de usuario de cada máquina física dentro del clúster. Recibe instrucciones del BorgMaster, inicia, detiene y monitorea el estado de los procesos, e informa periódicamente sobre los recursos disponibles (CPU, RAM, disco) de su nodo.
* **Link / Scheduler:** Subproceso interno y altamente optimizado integrado dentro del BorgMaster que evalúa las peticiones de la cola y asigna las tareas a las máquinas más adecuadas de la célula.

## Unidades de Trabajo y Tipos de Carga (Workloads)

Borg clasifica y gestiona las aplicaciones en función de su nivel de prioridad, tolerancias de latencia y patrones de consumo de recursos.

* **Trabajo (Job):** Unidad de organización lógica que agrupa una o más tareas idénticas. Define propiedades globales como restricciones de localización, dependencias y requerimientos de recursos.
* **Tarea (Task):** Un proceso ejecutable individual que corresponde a un contenedor Linux desplegado en un nodo físico.
* **Servicios de Producción (Prod / Latency-Sensitive):** Cargas de trabajo críticas con estrictos requisitos de latencia y disponibilidad contínua (servidores web, motores de búsqueda, bases de datos transaccionales). Cuentan con la máxima prioridad de ejecución y no pueden ser desalojadas por otros procesos.
* **Servicios por Lotes (Non-Prod / Batch):** Cargas de trabajo de alta capacidad orientadas a tareas en segundo plano que no requieren respuesta inmediata en tiempo real (indexación web, entrenamiento de modelos de inteligencia artificial, análisis MapReduce). Tienen menor prioridad y sus recursos se pueden reasignar si la demanda de servicios de producción aumenta.

## Planificación y Programación de Tareas (Scheduling)

El proceso de decisión sobre en qué nodo específico debe ejecutarse cada tarea consta de dos fases principales ejecutadas por el planificador de Borg:

* **Fase de Factibilidad (Feasibility Checking):** El planificador analiza la totalidad de máquinas en la célula y descarta aquellas que no cumplen los requisitos mínimos. Filtra nodos por falta de RAM o CPU disponible, falta de aceleración por hardware (GPU/TPU), incompatibilidades de arquitectura o violaciones de reglas de afinidad.
* **Fase de Puntuación (Scoring):** Asigna una calificación cuantitativa a cada máquina factible para determinar el nodo óptimo. La puntuación equilibra el empaquetado de recursos (*bin-packing*) para maximizar la densidad y reducir el desperdicio de hardware, manteniendo al mismo tiempo suficiente diversidad de ubicación para prevenir caídas masivas por fallos en un bastidor (*rack*).
* **Apropiación y Desalojo (Preemption):** Mecanismo mediante el cual, si una tarea crítica de alta prioridad (*Prod*) necesita ejecutarse y no existen recursos libres en la célula, el BorgMaster interrumpe y expulsa (*preempts*) tareas de menor prioridad (*Batch*) para liberar capacidad de forma inmediata.

## Aislamiento y Gestión de Recursos

Para garantizar que múltiples aplicaciones compartan la misma máquina física sin interferir entre sí, Borg implementa aislamiento estricto mediante tecnologías nativas del núcleo Linux.

* **Aislamiento por Contenedores:** Antecesor de los entornos de contenedores modernos. Utiliza *namespaces* de Linux para aislar tablas de procesos, interfaces de red y sistemas de archivos, junto a *cgroups* (Control Groups) para limitar el consumo de CPU, memoria y velocidad de lectura/escritura en disco.
* **Reserva y Límites de Recursos:** Cada trabajo declara la cantidad requerida (*Requests*) y el consumo máximo permitido (*Limits*) de CPU y memoria. Si una tarea sobrepasa su límite de memoria RAM asignado, el sistema operativo la termina de inmediato emitiendo un evento Out-Of-Memory (OOM).
* **Alloc (Resource Allocation):** Conjunto reservado de recursos en una máquina física que puede ser compartido por múltiples tareas relacionadas dentro del mismo trabajo (concepto precursor de los *Pods*).

## Resiliencia y Tolerancia a Fallos

Borg está diseñado bajo el principio de que los fallos de hardware y red en grandes centros de datos son inevitables y frecuentes.

* **Reprogramación Automática:** Si una máquina física sufre una avería, pierde conexión de red o un Borglet deja de responder, el BorgMaster detecta la anomalía y reubica automáticamente las tareas afectadas en otros nodos sanos.
* **Persistencia del Estado del Clúster:** La información del estado del clúster se mantiene sincronizada en memoria y replicada en disco dentro del clúster de BorgMaster a través de transacciones Paxos.
* **Aislamiento de Errores en el Control Plane:** Si el nodo BorgMaster líder falla por completo, las aplicaciones activas en los Borglets continúan ejecutándose normalmente en los nodos de cómputo mientras las instancias secundarias eligen un nuevo líder mediante elecciones de consenso.

## Legado y Evolución hacia Kubernetes

Borg fue desarrollado como una herramienta interna propietaria escrita en C++. Tras años de experiencia operativa, Google aplicó las lecciones aprendidas en Borg y en su sucesor experimental (Omega) para diseñar el estándar moderno de orquestación de código abierto.

* **Fundamento de Kubernetes:** Ingenieros de Google diseñaron Kubernetes desde cero en lenguaje Go utilizando los conceptos arquitectónicos validados en Borg.
* **Equivalencias de Arquitectura:** El *BorgMaster* dio lugar al *Control Plane* (`kube-apiserver`, `etcd`), el *Borglet* evolucionó a `kubelet`, las *Alloc* pasaron a ser *Pods*, y los *Jobs/Tasks* se convirtieron en los objetos *Deployments/StatefulSets/Pods*.
