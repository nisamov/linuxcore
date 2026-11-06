# Fail2ban: protección frente a intentos repetidos de acceso

Fail2ban analiza registros de servicios y puede aplicar bloqueos temporales cuando detecta patrones configurados, como fallos repetidos de autenticación. Es una capa adicional de defensa; no sustituye a la autenticación multifactor, las actualizaciones ni una configuración segura del servicio.

## Componentes

- **Filtro:** reconoce eventos relevantes en registros mediante patrones mantenidos para un servicio.
- **Jail (cárcel):** combina un filtro con los registros, el umbral de intentos, el periodo de observación y la duración del bloqueo.
- **Acción:** comunica el bloqueo a un cortafuegos o a otro mecanismo compatible.

La sintaxis y los nombres de filtros dependen de la versión y distribución. Antes de activar una configuración, el administrador debe revisar la documentación local del paquete instalado.

## Instalación y configuración general

En Debian o Ubuntu, los siguientes comandos requieren privilegios de administrador y modifican el sistema al instalar el servicio:

```bash
sudo apt update
sudo apt install fail2ban
```

La configuración no debe editarse directamente en `jail.conf`, ya que una actualización del paquete puede reemplazarla. El administrador debe crear una configuración local en `jail.local` o en un archivo de `jail.d/`, habilitar únicamente los jails necesarios y confirmar la ruta y el formato de los registros del servicio. Los parámetros habituales son `enabled`, `logpath`, `maxretry`, `findtime` y `bantime`; sus valores deben ajustarse a la política local.

> Cambiar reglas de bloqueo puede impedir accesos legítimos, incluso el acceso administrativo remoto. Durante los cambios debe mantenerse disponible una sesión de consola; solo deben habilitarse servicios administrados y la configuración debe probarse primero en un entorno de ensayo.

## Verificación y mantenimiento

El estado del servicio y de cada jail debe comprobarse con las herramientas de consulta incluidas en la versión instalada. También deben revisarse los registros de Fail2ban y del cortafuegos, confirmarse que los eventos legítimos no activan bloqueos y probarse el procedimiento de desbloqueo con una cuenta de laboratorio. No se recomienda desactivar la protección de forma global para resolver un bloqueo individual.

Los bloqueos basados en IP pueden ser insuficientes ante redes compartidas, direcciones cambiantes o ataques distribuidos. Esta medida debe combinarse con claves o MFA, deshabilitación de métodos obsoletos, límites en la aplicación y monitorización centralizada.
