## 1. Información General y Alcance
- Objetvos:  Definir qué se busca (cumplimiento normativo, detección de intrusiones, optimización).
- Inventario de Activos: Identificación de servidores, versiones de kernel y
hardware crítico.

## 2. Configuración del Sistema y Hardening
- Servicios y Paquetes: Listado de servicios activos y eliminación de paquetes
innecesarios.
- Parches y Actualizaciones: Verificación del estado de actualización del
sistema y software instalado.
- Seguridad del Kernel: Revisión de parámetros mediante sysctl (protección
contra ataques de red, ejecución de memoria, etc.).

## 3. Control de Acceso y Autenticación
- Gestión de Usuarios y Grupos: Revisión de cuentas inactivas, UID 0
duplicados y fuerza de contraseñas.
- Seguridad SSH: Auditoría del archivo sshd_config (deshabilitar login root,
uso de llaves públicas, puertos no estándar).
- Privilegios: Configuración de sudoers y permisos en archivos críticos del
sistema.

## 4. Auditoría de Eventos (Logs)
- Configuración de Auditd: Reglas para monitorizar llamadas al sistema,
accesos a archivos sensibles y cambios de privilegios.
- Integridad de Logs: Almacenamiento remoto y protección contra
alteraciones
- Rotación de los logs: logrotate (herramienta de administración de sistemas
diseñada para gestionar el crecimiento de los archivos de registro (logs) de
forma automática)
- Frecuencia y calendario: Cuando se recogen y se revisan los logs

## 5. Red y Cortafuegos
- Configuración de Firewall: Revisión de reglas en iptables, nftables
- Escaneo de Puertos: Identificación de puertos abiertos innecesariamente.

## Tareas Automáticas y Procesos
- Cron y Systemd Timers: Análisis de scripts automáticos para detectar
posibles puertas traseras o ejecuciones no autorizadas.

## 7. Conclusiones e Informe de Hallazgos
- Clasificación de Riesgos
- Recomendaciones de Mitigación

## 8. Herramientas Utilizadas
- Herramientas utilizadas durante la auditoría.

## 9. Alertas e informes
- Eventos que generan avisos, como y a quien notifican.