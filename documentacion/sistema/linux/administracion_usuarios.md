# Administración de usuarios y privilegios

Las cuentas permiten identificar a las personas y procesos que utilizan el sistema. Los identificadores y permisos determinan qué recursos puede leer, modificar o ejecutar cada cuenta.

## Archivos principales

| Archivo | Contenido |
|---|---|
| `/etc/passwd` | Nombre, UID, GID primario, comentario, directorio personal y shell. |
| `/etc/shadow` | Hash de la contraseña y fechas de validez o bloqueo. Solo debe leerlo `root`. |
| `/etc/group` | Grupos y sus miembros secundarios. |
| `/etc/gshadow` | Contraseñas y administradores de los grupos. |
| `/etc/skel/` | Archivos y directorios copiados al crear una cuenta. |
| `/etc/login.defs` | Políticas globales de creación y caducidad de cuentas. |
| `/etc/sudoers` | Reglas de ejecución mediante `sudo`. Debe editarse con `visudo`. |

## Consultar identidades

```bash
id
id usuario1
whoami
getent passwd usuario1
getent group grupo1
```

Los UID inferiores a 1000 suelen pertenecer a cuentas del sistema. El UID `0` corresponde a `root` y tiene privilegios administrativos sin las restricciones normales de otros usuarios.

## Crear y modificar usuarios

```bash
sudo useradd -m -s /bin/bash usuario1
sudo passwd usuario1
sudo usermod -aG grupo1 usuario1
sudo usermod -s /bin/bash usuario1
sudo usermod -L usuario1
```

- `-m` crea el directorio personal.
- `-s` selecciona el intérprete de inicio de sesión.
- `-aG` añade el usuario a grupos suplementarios sin quitar los existentes.
- `-L` bloquea la contraseña de la cuenta.

Para eliminar una cuenta:

```bash
sudo userdel usuario1
sudo userdel -r usuario1
```

`userdel -r` elimina el directorio personal y puede borrar datos. Revisa primero la propiedad y realiza una copia si la información debe conservarse.

## Crear y modificar grupos

```bash
sudo groupadd proyecto
sudo groupadd -g 1500 proyecto
sudo gpasswd -a usuario1 proyecto
sudo gpasswd -d usuario1 proyecto
```

`gpasswd -d` elimina al usuario de un grupo suplementario. Los cambios pueden requerir una nueva sesión para que sean visibles en el proceso actual.

## Caducidad de contraseñas

```bash
sudo chage -l usuario1
sudo chage -M 90 usuario1
sudo chage -W 7 usuario1
sudo chage -E 2026-12-31 usuario1
sudo chage -E -1 usuario1
```

- `-M`: días máximos entre cambios.
- `-W`: días de aviso antes de caducar.
- `-E`: fecha de caducidad de la cuenta.
- `-E -1`: elimina la fecha de caducidad.

Consulta los datos antes de modificar una cuenta. No pongas contraseñas reales en scripts o ejemplos compartidos.

## Permisos y grupos compartidos

```bash
sudo mkdir -p /srv/proyecto
sudo chown root:proyecto /srv/proyecto
sudo chmod 2775 /srv/proyecto
```

El bit SGID `2775` hace que los archivos creados dentro hereden el grupo `proyecto`.

Comprueba el resultado:

```bash
ls -ld /srv/proyecto
sudo -u usuario1 touch /srv/proyecto/prueba.txt
ls -l /srv/proyecto/prueba.txt
```

El archivo temporal puede eliminarse antes de finalizar la práctica:

```bash
sudo rm -f /srv/proyecto/prueba.txt
```

## Uso de sudo

Consulta privilegios y reglas aplicadas:

```bash
sudo -l
```

No conviene añadir al usuario a `wheel` o `sudo` sin haber definido qué acciones puede realizar. El acceso a `sudo` puede equivaler a control administrativo sobre el sistema.

Edita las reglas solo mediante `visudo`:

```bash
sudo visudo
```

Ejemplo de una entrada específica:

```text
usuario1 ALL=(root) /usr/bin/systemctl restart apache2
```

Esta regla permite reiniciar únicamente `apache2`. No añade a `usuario1` todos los privilegios de `root`.

## Verificación

```bash
getent passwd usuario1
getent group grupo1
id usuario1
sudo -l -U usuario1
```

## Advertencias

- Modificar cuentas puede impedir el acceso por SSH o eliminar datos si se usa la opción incorrecta.
- Las cuentas de servicio no deben usar shells de inicio de sesión innecesarios.
- Las reglas de `sudo` deben tener la ruta absoluta del ejecutable y el menor alcance posible.
- Nunca edites `/etc/shadow` con un editor normal ni escribas hashes de contraseña en documentación pública.
