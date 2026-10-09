# Teoría General Kubernetes

Kubernetes (K8s) es una plataforma de orquestación de contenedores de código abierto que automatiza el despliegue, el escalado y la gestión de aplicaciones distribuidas. Su arquitectura opera mediante un **modelo declarativo**: el usuario define el estado deseado del sistema mediante archivos YAML/JSON y el orquestador trabaja continuamente para mantener ese estado.

> **Nota:** Kubernetes proviene de la palabra griega *κυβερνήτης*, que significa <timonel> o <piloto de barco>.

Es un proyecto de código abierto escrito en **Go** y licenciado bajo la **Apache License 2.0**. Su extensibilidad le permite ser compatible con herramientas de terceros que amplían sus capacidades en una arquitectura modular basada en patrones de microservicios desacoplados.

## Arquitectura del Clúster

Un clúster se compone de dos secciones operativas principales:

| Sección | Subcomponente | Función Principal |
| --- | --- | --- |
| **Control Plane** *(Cerebro)* | `kube-apiserver` | Punto de entrada central de la API RESTful. |
| **Control Plane** *(Cerebro)* | `etcd` | Almacén clave-valor para la persistencia del estado global. |
| **Control Plane** *(Cerebro)* | `kube-scheduler` | Asigna Pods a los nodos según requisitos y recursos. |
| **Control Plane** *(Cerebro)* | `kube-controller-manager` | Ejecuta los bucles de control para regular el estado. |
| **Worker Nodes** *(Cargas de trabajo)* | `kubelet` | Agente que asegura la ejecución de los Pods en el nodo. |
| **Worker Nodes** *(Cargas de trabajo)* | `kube-proxy` | Mantiene las reglas de red y el enrutamiento. |
| **Worker Nodes** *(Cargas de trabajo)* | Container Runtime | Motor ejecutor de contenedores (ej. `containerd`). |

## Conceptos y Objetos Básicos

Kubernetes gestiona la infraestructura mediante las siguientes abstracciones principales:

### Nodo (La infraestructura)

Servidor físico o virtual dentro del clúster que proporciona recursos de CPU, memoria RAM, almacenamiento y red.

* **Tipos de Nodos:**
* **Control Plane Nodes:** Administran y coordinan el clúster.
* **Worker Nodes:** Ejecutan las cargas de trabajo de las aplicaciones.


* **Componentes clave en cada nodo:** Agente ejecutor (`kubelet`), proxy de red (`kube-proxy`) y el motor de ejecución de contenedores (*Container Runtime*).

### Pod (La unidad de ejecución)

Es la abstracción más pequeña y básica desplegable en Kubernetes. Representa una instancia de un proceso en ejecución.

* **Contenido:** Engloba uno o más contenedores que comparten la misma red, dirección IP y volúmenes de almacenamiento.
* **Uso típico:** La mayoría de los Pods albergan un solo contenedor. Se usan múltiples contenedores en un mismo Pod únicamente cuando requieren un acoplamiento fuerte (patrón *sidecar*, como contenedores auxiliares de logs o métricas).
* **Naturaleza efímera:** Los Pods no se reparan ni se mueven. Si un Pod o su nodo falla, Kubernetes destruye la instancia y crea un reemplazo idéntico en un nodo saludable.

### Otros Objetos Principales

* **Deployment:** Gestiona la creación, actualización (*rollout*) y escalado declarativo de Pods.
* **Service:** Proporciona una IP estática y un nombre DNS estable para acceder a un grupo dinámico de Pods con balanceo de carga.
* **Volume / PersistentVolume (PV):** Mecanismo de almacenamiento persistente independiente del ciclo de vida efímero de los contenedores.
* **Namespace:** Aislamiento virtual dentro de un mismo clúster físico para dividir recursos por equipos o entornos (ej. `dev`, `prod`).

## El Bucle de Reconciliación (*Reconciliation Loop*)

La lógica interna de Kubernetes opera mediante un ciclo infinito de control de tres pasos:

1. **Observar:** Lee el estado real del clúster a través de los agentes del sistema.
2. **Comparar:** Contrasta el estado actual con el «estado deseado» guardado en `etcd`.
3. **Actuar:** Si se detecta una discrepancia (por ejemplo, la caída de un Pod), el controlador ejecuta acciones correctivas para restablecer las réplicas definidas (*self-healing*).

## Componentes del Plano de Control (*Control Plane*)

### Servidor API (`kube-apiserver`)

Es el componente central que intercepta, valida y procesa todas las llamadas RESTful de usuarios, administradores y agentes externos.

* **Persistencia:** Es el **único** componente autorizado para comunicarse directamente con `etcd` para leer y escribir el estado del clúster.
* **Escalabilidad:** Permite escalado horizontal y la incorporación de servidores API secundarios personalizados mediante proxy enrutador.

### Programador (`kube-scheduler`)

Asigna los nuevos Pods a los nodos de trabajo (*Worker Nodes*) disponibles.

* **Criterios de decisión:** Analiza el uso de recursos, restricciones de usuario (ej. etiquetas como `disk==ssd`), políticas de Calidad de Servicio (QoS), localidad de datos, afinidad, antiafinidad, manchas (*taints*) y tolerancias.
* **Proceso:** Aplica *filtros con predicados* para aislar nodos candidatos y luego los califica con *prioridades* para seleccionar el nodo óptimo.
* **Complejidad:** En clústeres multi-nodo realiza decisiones de alta complejidad, mientras que en clústeres de un solo nodo su tarea es trivial.

### Gestores de Controladores

* **`kube-controller-manager`:** Ejecuta los bucles de control estándar para gestionar el ciclo de vida de los nodos, recuento de Pods, endpoints, cuentas de servicio y tokens de acceso.
* **`cloud-controller-manager`:** Interactúa con las APIs del proveedor de la nube (*Cloud Provider*) para gestionar nodos, volúmenes, balanceadores de carga y enrutamiento externo.

### Almacén de Datos Clave-Valor (`etcd`)

Almacén de datos distribuido, consistente y de código abierto (proyecto CNCF) que guarda el estado global del clúster.

* **Escritura:** Solo permite operaciones *append-only* (adición). Los datos obsoletos se compactan periódicamente para optimizar espacio.
* **Mantenimiento y HA:** La herramienta `etcdctl` permite crear e importar instantáneas (*snapshots*). En producción, `etcd` requiere despliegues en alta disponibilidad (HA) replicados, mientras que en entornos de desarrollo suele ejecutarse de forma apilada (*stacked*) en el propio nodo de control.

## Características Principales

* **Embalaje automático:** Optimiza la distribución de contenedores según recursos y restricciones.
* **Autocuración (*Self-healing*):** Reinicia o reemplaza automáticamente contenedores fallidos y los desvía del tráfico de red.
* **Escalado horizontal:** Modifica la cantidad de réplicas de forma manual o automática basado en métricas de CPU o personalizadas.
* **Descubrimiento de servicios y balanceo de carga:** Asigna direcciones IP y nombres DNS para distribuir la carga entre contenedores.
* **Despliegues y reversiones automatizadas:** Actualiza y revierte aplicaciones sin interrupciones del servicio.
* **Gestión de secretos y configuración:** Separa claves, tokens y variables del código e imágenes del contenedor.
* **Orquestación de almacenamiento:** Monta almacenamiento local, en la nube, distribuido o en red (SDS).
* **Ejecución por lotes (*Batch*):** Soporta trabajos programados (*Jobs* / *CronJobs*) y tareas de larga duración.
* **Soporte Dual-Stack:** Compatibilidad nativa con direccionamiento IPv4 e IPv6.

## Instalación de Clústeres de Aprendizaje Locales

Existen diversas herramientas para desplegar clústeres de Kubernetes de un solo nodo o multi-nodo en entornos locales para aprendizaje, pruebas y desarrollo:

* **Minikube:** Implementa un clúster local de uno o varios nodos en un solo host. Es el estándar recomendado para entornos de aprendizaje.
* **Kind (*Kubernetes IN Docker*):** Ejecuta clústeres multi-nodo donde cada nodo de Kubernetes es un contenedor Docker. Muy ligero y rápido para entornos de prueba.
* **Docker Desktop:** Incluye una opción integrada de clúster local de Kubernetes habilitable con un solo clic para usuarios de Docker.
* **Podman Desktop:** Proporciona integración directa y gestión de clústeres Kubernetes para entornos que utilizan Podman.
* **MicroK8s:** Distribución ligera y modular de Canonical. Diseñada tanto para desarrollo local como para entornos de producción e IoT.
* **K3s:** Distribución ultra ligera de Kubernetes enfocada en entornos locales, IoT, Edge computing y CI/CD (originalmente desarrollada por Rancher, actualmente un proyecto de la CNCF).