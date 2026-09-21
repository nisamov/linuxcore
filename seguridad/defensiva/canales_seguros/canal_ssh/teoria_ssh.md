# Protocolo SSH

SSH (*Secure Shell*) es un protocolo que permite la interacción segura entre máquinas a través de una línea de comandos. Funciona tanto en sistemas **Linux** como **Windows** y utiliza cifrado para proteger la comunicación.

**Datos técnicos:**
* **Protocolo:** SSH
* **Puerto por defecto:** 22/TCP
* **Servicio:** `sshd` (daemon que escucha peticiones en el puerto 22)
* **Flujo:** IP → Red → Puerto

Para conectarse por SSH es necesario conocer:
* Usuario
* Contraseña (o clave privada)

## SSH: Acceso, Claves y Seguridad

### Generación de clave SSH

Creación de clave pública y privada con nombre (`id_rsa` por defecto):
```sh
[user@host ~]$ ssh-keygen
```

### Configuración de cuenta remota para acceso

```sh
[user@host ~]$ ssh-copy-id -i .ssh/key-with-pass.pub user@remotehost
```

El comando `ssh-copy-id` nos permite enviar la clave pública a la máquina destino.

* El parámetro `-i` permite especificar la clave pública para comprobar o autorizar el acceso.
* El parámetro `-v` (*verbose*) permite ver el proceso completo para poder revisar cada uno de los pasos.

La estructura del comando es la siguiente:

```sh
[user@host ~]$ ssh <opcion> <clave_ruta_rel_o_absoluta> <maquina_destino> <comando>
```

**Ejemplo práctico:**

```sh
[user@host ~]$ ssh -i .ssh/key2 operator1@servera hostname
```

### Rutas y archivos por defecto
Por defecto al crear una clave con `ssh-keygen`, se ubica en la ruta: `/home/usuario/.ssh/`

Contenido generado:
* `id_rsa.pub` — Clave pública (compartida con los servidores).
* `id_rsa` — Clave privada (permanece en tu equipo para identificarte).

> **¡Precaución con la sobreescritura de claves!**
> Si generas dos claves sin establecer un nombre personalizado, la segunda sobreescribirá a la primera. Si ya habías distribuido la clave previa en servidores remotos, perderás el acceso.

**Ejemplo de lo que NO se debe hacer:**
```sh
[user@host ~]$ ssh-keygen # Primera generación
[user@host ~]$ ssh -i .ssh/key2 operator1@servera hostname # Se comparte/usa la clave
[user@host ~]$ ssh-keygen # Segunda generación (sobreescribe la primera)
```
Esto provocará que la primera clave sea reemplazada, haciendo que el acceso anterior deje de funcionar.

### Recomendación

Para generar claves con nombres personalizados y evitar conflictos de sobreescritura:

```sh
ssh-keygen -f ~/.ssh/nombre_clave
```

Esto generará:
* `~/.ssh/nombre_clave` (clave privada)
* `~/.ssh/nombre_clave.pub` (clave pública)
