# Endurecimiento de un servidor SSH

SSH permite administrar sistemas de forma remota mediante un canal cifrado. El endurecimiento combina autenticación robusta, mínimo privilegio, configuración actualizada, control de red y supervisión. Cambiar el puerto predeterminado no sustituye a estos controles.

## Antes de cambiar la configuración

- Debe confirmarse la disponibilidad de acceso por consola o de un canal de recuperación independiente.
- Deben identificarse la distribución y la configuración efectiva del servidor, y revisarse las páginas de manual correspondientes.
- El archivo de configuración debe respaldarse y debe programarse una ventana de mantenimiento.
- Una sesión administrativa existente debe permanecer abierta mientras se prueba una segunda conexión.

Un cambio incorrecto puede bloquear el acceso remoto. La sintaxis debe comprobarse con la opción de prueba de configuración ofrecida por la versión instalada antes de recargar o reiniciar el servicio.

## Medidas recomendadas

- OpenSSH debe mantenerse actualizado y el firewall debe limitar el servicio a las redes de administración necesarias.
- Se recomienda el uso de claves públicas protegidas por frase de paso y, cuando sea viable, MFA o un mecanismo de acceso centralizado.
- La autenticación por contraseña solo debe deshabilitarse después de comprobar que el acceso por clave funciona para las cuentas autorizadas.
- El inicio de sesión directo de `root` debe deshabilitarse; la administración debe realizarse mediante una cuenta nominal y privilegios controlados.
- Los usuarios o grupos autorizados deben restringirse y el reenvío de agente, puertos o X11 debe evitarse cuando no sea necesario.
- Deben utilizarse algoritmos mantenidos por la versión soportada; las listas antiguas no deben copiarse sin evaluar su compatibilidad.
- Los registros de autenticación deben revisarse y las alertas deben configurarse ante patrones anómalos.

## Ejemplo de parámetros

Los siguientes nombres ilustran opciones frecuentes de `sshd_config`; el valor soportado y la sintaxis de la versión instalada deben verificarse. El bloque no debe copiarse sin adaptar las cuentas, políticas y compatibilidad:

```text
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
AllowGroups administradores-ssh
X11Forwarding no
AllowAgentForwarding no
```

Antes de aplicar `PasswordAuthentication no`, debe instalarse y probarse una clave para cada administrador previsto. Una sesión debe permanecer abierta mientras se valida la configuración y se prueba una conexión nueva desde una segunda terminal. Tras la comprobación, el servicio debe recargarse mediante el gestor de la distribución.

## Gestión de claves y ciclo de vida

Las claves deben emitirse de forma individual; las que se pierdan o ya no se necesiten deben revocarse, y las cuentas obsoletas deben eliminarse. Las claves privadas deben protegerse con permisos mínimos y copias seguras. No se recomienda compartir claves entre administradores, ya que la atribución y revocación individual son esenciales para una respuesta eficaz.
