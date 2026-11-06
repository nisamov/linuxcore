# Monitorización con Prometheus y exportadores

Prometheus es un sistema de monitorización que recoge métricas mediante consultas periódicas (*scrape*) y las almacena como series temporales. Los exportadores traducen métricas de sistemas o servicios a un formato que Prometheus puede consultar.

## Componentes principales

- **Servidor Prometheus:** descubre objetivos, recoge métricas y evalúa consultas y reglas.
- **Exportador:** expone métricas del host o de una aplicación; `node_exporter` es un ejemplo habitual para métricas de sistema.
- **PromQL:** lenguaje de consulta para seleccionar y agregar series temporales.
- **Alertmanager:** agrupa y enruta alertas según reglas y destinatarios configurados.
- **Servicio de visualización:** puede presentar paneles construidos a partir de consultas.

Prometheus normalmente extrae métricas desde objetivos accesibles. Sus endpoints deben protegerse; las interfaces de administración y métricas internas no deben exponerse a redes no confiables.

## Configuración de ejemplo

Este fragmento ilustra el concepto para una instancia de laboratorio. Sustituye el objetivo por un host administrado y limita el acceso mediante la red de monitorización y controles de firewall.

```yaml
global:
  scrape_interval: 30s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["127.0.0.1:9090"]
```

Los exportadores deben instalarse desde fuentes confiables, mantenerse actualizados y ejecutarse con permisos mínimos. Debe revisarse la información expuesta por cada endpoint y evitarse la inclusión de secretos o etiquetas con datos personales.

## Métricas, alertas y operación

Las métricas deben diseñarse con nombres y etiquetas de cardinalidad controlada: los valores únicos por solicitud pueden disparar el uso de memoria. Las alertas deben describir una condición accionable, incluir contexto y tener una persona o equipo responsable.

Deben verificarse los objetivos disponibles, el retraso de recolección, las reglas y la entrega de alertas. La retención debe dimensionarse según la capacidad y la finalidad; la configuración debe protegerse y su restauración debe probarse. Las métricas son señales operativas; para auditoría y análisis detallado de seguridad se necesitan registros y telemetría adecuados.
