# Pods, Deployments y Services en Kubernetes

Kubernetes administra aplicaciones mediante recursos declarativos. Los manifiestos describen el estado deseado; los controladores intentan mantenerlo mientras cambian los Pods o los nodos.

## Función de cada recurso

- **Pod:** unidad mínima de ejecución; aloja uno o varios contenedores estrechamente relacionados y comparte red y volúmenes del Pod.
- **Deployment:** mantiene un número deseado de réplicas y administra actualizaciones y reversiones de Pods sin estado.
- **Service:** ofrece una dirección estable y selecciona Pods mediante etiquetas. `ClusterIP` es interno al clúster; `NodePort` y `LoadBalancer` pueden exponer tráfico fuera del clúster según la plataforma.

Los Pods son efímeros y pueden recrearse con una dirección distinta. Las aplicaciones con identidad o almacenamiento persistente suelen requerir recursos adicionales, como StatefulSet y PersistentVolumeClaim.

## Manifiesto de ejemplo

El siguiente manifiesto crea dos réplicas de una imagen pública de ejemplo y un Service interno. Antes de aplicarlo en un clúster real, deben revisarse la imagen, la etiqueta, los recursos y la política de despliegue.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-demo
  template:
    metadata:
      labels:
        app: web-demo
    spec:
      containers:
        - name: web
          image: nginxinc/nginx-unprivileged:stable
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: 100m
              memory: 64Mi
            limits:
              cpu: 500m
              memory: 128Mi
          securityContext:
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            readOnlyRootFilesystem: true
---
apiVersion: v1
kind: Service
metadata:
  name: web-demo
spec:
  selector:
    app: web-demo
  ports:
    - port: 80
      targetPort: 8080
  type: ClusterIP
```

La imagen no privilegiada de Nginx utiliza el puerto 8080 dentro del contenedor. La etiqueta disponible y el comportamiento de la imagen deben comprobarse antes del despliegue; los servicios no deben exponerse a Internet sin revisar la autenticación, TLS, el firewall y la política de acceso.

## Validación y operación

Antes de aplicar manifiestos, deben revisarse el contexto del clúster y el *namespace*, validarse el YAML con herramientas locales y solicitarse una revisión de cambios. Después, deben comprobarse el estado del Deployment, los Pods, los eventos y los endpoints del Service. La reversión de un Deployment no recupera necesariamente datos ni cambios externos; las copias y los procedimientos de migración deben mantenerse de forma independiente.

Las cuentas de servicio deben configurarse con permisos mínimos, límites de recursos, políticas de red y gestión de secretos apropiada. Los tokens y contraseñas no deben almacenarse en manifiestos versionados.
