# Teoría General Kubernetes

Kubernetes (K8s) es una plataforma de orquestación de contenedores de código abierto que automatiza el despliegue, el escalado y la gestión de aplicaciones distribuidas. Su arquitectura opera mediante un **modelo declarativo**: el usuario define el estado deseado del sistema mediante archivos YAML/JSON y el orquestador trabaja continuamente para mantener ese estado.

**Arquitectura del Clúster**

Un clúster se compone de dos secciones operativas:

| Sección | Subcomponente | Función Principal |
| --- | --- | --- |
| **Control Plane** *(Cerebro)* | `kube-apiserver` | Punto de entrada de la API central |
| **Control Plane** *(Cerebro)* | `etcd` | Base de datos clave-valor para el estado global |
| **Control Plane** *(Cerebro)* | `kube-scheduler` | Asigna Pods a los nodos según recursos |
| **Control Plane** *(Cerebro)* | `kube-controller-manager` | Ejecuta los bucles de control |
| **Worker Nodes** *(Cargas de trabajo)* | `kubelet` | Agente que asegura la ejecución de Pods en el nodo |
| **Worker Nodes** *(Cargas de trabajo)* | `kube-proxy` | Mantiene las reglas de red y el enrutamiento |
| **Worker Nodes** *(Cargas de trabajo)* | Container Runtime | Motor ejecutor de contenedores (ej. `containerd`) |

---

**Objetos Básicos de Kubernetes**

Kubernetes gestiona la infraestructura mediante abstracciones llamadas objetos:

* **Pod:** La unidad mínima desplegable. Engloba uno o más contenedores que comparten la misma red e IP.
* **Deployment:** Abstracción que gestiona la creación, actualización (*rollout*) y escalado de Pods de forma automatizada.
* **Service:** Abstracción de red que proporciona una dirección IP estática y un nombre DNS para acceder a un grupo dinámico de Pods.
* **Volume / PersistentVolume (PV):** Mecanismo de almacenamiento persistente que sobrevive al ciclo de vida efímero de los contenedores.
* **Namespace:** Aislamiento virtual dentro de un mismo clúster físico para dividir recursos por equipos o entornos (ej. *dev*, *prod*).

---

**El Bucle de Reconciliación (*Reconciliation Loop*)**

La lógica interna de Kubernetes funciona mediante un ciclo infinito de control:

1. **Observar:** Lee el estado real del clúster a través de los agentes del sistema.
2. **Comparar:** Contrasta el estado actual con el "estado deseado" guardado en `etcd`.
3. **Actuar:** Si un Pod falla o se elimina, el controlador crea uno nuevo para restablecer la cantidad de réplicas definidas por el usuario (*self-healing*).

---

**Nodo (La infraestructura)**

Es un servidor individual dentro del clúster de Kubernetes que proporciona recursos de CPU, memoria RAM, almacenamiento y red.

* **Tipos de Nodo:** Un clúster cuenta con **Worker Nodes** (ejecutan las aplicaciones del usuario) y **Control Plane Nodes** (administran y coordinan el clúster).
* **Componentes clave:** Cada nodo ejecuta un agente principal (**`kubelet`**) para comunicarse con el plano de control, un componente de red (**`kube-proxy`**) y un motor de almacenamiento/ejecución de contenedores (como `containerd`).

**Pod (La unidad de ejecución)**

Es la abstracción más pequeña y básica en Kubernetes. Representa una instancia de un proceso en ejecución dentro del clúster.

* **Contenido:** Envuelve uno o más contenedores (habitualmente de Docker o similar) que comparten la misma red, dirección IP y volúmenes de almacenamiento.
* **Uso típico:** La gran mayoría de los Pods contienen **un solo contenedor**. Sin embargo, pueden albergar varios si necesitan trabajar de forma fuertemente acoplada (por ejemplo, un contenedor principal web junto a un contenedor *sidecar* para gestión de logs).
* **Carácter efímero:** Los Pods no se reparan ni se mueven; si un Pod falla o el nodo donde reside muere, Kubernetes simplemente crea un reemplazo idéntico en otro nodo.