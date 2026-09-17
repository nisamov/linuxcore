# Teória General sobre Maquinas Virtuales

**Definición mejorada**

Una **instantánea (*snapshot*)** es una captura del estado exacto de una máquina virtual o sistema de archivos en un momento preciso. Su objetivo principal es congelar el sistema para poder revertirlo (*rollback*) a ese punto exacto si una actualización, configuración o instalación posterior falla.

**Qué contiene realmente una instantánea**

* **Estado del disco:** Los archivos, registros del sistema y configuraciones congelados en ese segundo exacto.
* **Memoria RAM y estado de ejecución (opcional):** Permite guardar las aplicaciones abiertas, procesos activos y registros de CPU para restaurar la máquina virtual "en marcha", tal y como estaba encendida.
* **Configuración de la máquina:** Los parámetros del hardware virtual (memoria asignada, tarjetas de red, discos adjuntos).

**Cómo funciona por dentro**

Para ser rápida, no duplica todo el disco. En su lugar:

1. Congela el disco virtual original en modo **solo lectura**.
2. Crea un **disco de diferencias (delta)** donde escribe todos los datos nuevos o modificados a partir de ese instante.
3. Si la eliminas, consolida las diferencias con el disco principal; si la restauras, descarta el disco de diferencias.

**Diferencia clave: Snapshot vs. Backup**

| Característica | Instantánea (*Snapshot*) | Copia de seguridad (*Backup*) |
| --- | --- | --- |
| **Dependencia** | Depende del disco original. Si el disco base se daña, el snapshot no sirve. | Es independiente. Se puede mover a otro servidor o almacenamiento externo. |
| **Uso principal** | Entornos de pruebas, aplicación de parches o cambios temporales. | Recuperación ante desastres o fallos físicos del hardware. |
| **Retención** | Corto plazo. Mantenerla mucho tiempo degrada el rendimiento del disco. | Largo plazo. |
