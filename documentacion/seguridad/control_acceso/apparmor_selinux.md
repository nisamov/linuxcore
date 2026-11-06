# AppArmor y SELinux: control de acceso obligatorio

AppArmor y SELinux son mecanismos de control de acceso obligatorio (MAC, *Mandatory Access Control*) para Linux. Complementan los permisos tradicionales de usuarios y grupos limitando las acciones que un proceso puede realizar, incluso cuando sus permisos discrecionales permitirían más.

## Modelo de seguridad

- **AppArmor** asocia perfiles a programas y suele expresar restricciones mediante rutas, capacidades y acceso a recursos. Los perfiles pueden ejecutarse en modo de cumplimiento o de queja (registrar denegaciones sin aplicarlas).
- **SELinux** etiqueta procesos, archivos y otros objetos, y aplica políticas que determinan las interacciones permitidas entre tipos. Puede operar en modo enforcing, permissive o disabled; el modo deshabilitado requiere cambios de sistema y no es una solución habitual a un bloqueo.

Ambos reducen el impacto de una aplicación comprometida, pero no corrigen vulnerabilidades ni sustituyen la actualización, el aislamiento de servicios y el principio de mínimo privilegio.

## Operación y diagnóstico

El administrador debe utilizar las herramientas de la distribución para comprobar el estado, identificar el perfil o contexto asociado a un proceso y revisar los registros de denegaciones. En AppArmor los perfiles suelen ubicarse bajo `/etc/apparmor.d/`; en SELinux las políticas y etiquetas las administra el sistema de políticas de la distribución. Las etiquetas o los perfiles no deben cambiarse de forma recursiva sin conocer las consecuencias.

Un procedimiento seguro para adaptar una política es:

- El comportamiento debe reproducirse en un entorno de prueba y el perfil o la política actual deben conservarse.
- Los registros deben consultarse para identificar la operación legítima que se bloquea.
- La excepción mínima necesaria debe añadirse, evitando permisos amplios o cambios globales.
- El modo de cumplimiento debe restablecerse y deben probarse las funciones normales y los casos de error.
- La excepción debe documentarse y revisarse para determinar si sigue siendo necesaria.

> Desactivar MAC o poner el sistema globalmente en modo permisivo reduce la protección del host. En producción, esas medidas no deben utilizarse como solución permanente; si una política bloquea un servicio esencial, la recuperación debe realizarse mediante acceso por consola.

La disponibilidad de paquetes, comandos y perfiles predeterminados varía según la distribución. Consulta su documentación oficial antes de instalar políticas o cambiar el modo de seguridad.
