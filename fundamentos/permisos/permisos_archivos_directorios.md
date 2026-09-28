# Permisos de Archivos y Directorios en Linux

Los permisos en sistemas tipo Unix/Linux permiten controlar qué acciones pueden realizar los usuarios sobre los recursos del sistema (archivos y directorios), garantizando la seguridad y el aislamiento en entornos multiusuario.

## Clases de Usuarios y Estructura de Permisos

En Linux, cada archivo o directorio pertenece a un **Usuario Propietario** y a un **Grupo Propietario**. El acceso se evalúa en tres niveles (entidades):

1. **`u` (User / Propietario):** El usuario dueño del archivo.
2. **`g` (Group / Grupo):** Los usuarios que pertenecen al grupo propietario del archivo.
3. **`o` (Others / Otros):** Cualquier otro usuario del sistema que no sea ni el propietario ni pertenezca al grupo.
4. **`a` (All / Todos):** Representa a las tres entidades simultáneamente (`u + g + o`).

### Representación en el sistema de archivos (`ls -l`)

Al ejecutar `ls -l`, el primer bloque de 10 caracteres muestra la naturaleza del elemento y sus permisos:

```text
drwxr-xr--  2 usuario grupo 4096 Sep 25 10:00 mi_directorio
-rw-r--r--  1 usuario grupo 1024 Sep 25 10:00 mi_archivo.txt
```

| Posición | Representación | Significado |
| :--- | :--- | :--- |
| **1** | `-`, `d`, `l` | Tipo de elemento (`-` archivo regular, `d` directorio, `l` enlace simbólico). |
| **2, 3, 4** | `rwx` | Permisos del **Propietario** (`u`). |
| **5, 6, 7** | `r-x` | Permisos del **Grupo** (`g`). |
| **8, 9, 10** | `r--` | Permisos de **Otros** (`o`). |

## Permisos Básicos: Archivos vs. Directorios

El significado de los permisos `r`, `w` y `x` varía dependiendo de si se aplican a un **archivo** o a un **directorio**:

| Permiso | En Archivos | En Directorios |
| :---: | :--- | :--- |
| **`r` (Read / Lectura)** | Ver o leer el contenido del archivo (`cat`, `less`). | Listar el contenido del directorio (`ls`). |
| **`w` (Write / Escritura)** | Modificar o sobrescribir el archivo (`echo`, `nano`). | Crear, eliminar o renombrar archivos/carpetas dentro del directorio. |
| **`x` (eXecute / Ejecución)** | Ejecutar el archivo como un script o binario. | Entrar al directorio (`cd`) y acceder a sus elementos o metadatos. |

> Para que un usuario pueda listar o modificar el contenido de un directorio, **debe tener al menos permiso de ejecución (`x`)** sobre ese directorio para poder acceder a él.

## Sistema Numérico (Octal)

Los permisos se representan en sistema octal mediante valores numéricos asignados a cada tipo de permiso básico:

* **`r` (Lectura)** = $4$ ($2^2$)
* **`w` (Escritura)** = $2$ ($2^1$)
* **`x` (Ejecución)** = $1$ ($2^0$)
* **Sin permiso (`-`)** = $0$

La suma de estos valores define el nivel de acceso para cada entidad (`u`, `g`, `o`):

| Valor Octal | Permisos | Descripción |
| :---: | :---: | :--- |
| **7** | `rwx` | Lectura, escritura y ejecución ($4 + 2 + 1$). |
| **6** | `rw-` | Lectura y escritura ($4 + 2$). |
| **5** | `r-x` | Lectura y ejecución ($4 + 1$). |
| **4** | `r--` | Solo lectura ($4$). |
| **0** | `---` | Sin ningún permiso. |

### Configuración habitual de permisos

| Notación | Representación | Uso habitual |
| :---: | :---: | :--- |
| **`755`** | `rwxr-xr-x` | Scripts o ejecutables públicos; directorios estándar. |
| **`644`** | `rw-r--r--` | Archivos de texto o documentos legibles por todos, modificables solo por el dueño. |
| **`700`** | `rwx------` | Directorios o scripts privados del usuario (ej. `~/.ssh`). |
| **`600`** | `rw-------` | Archivos confidenciales (ej. claves privadas, certificados). |
| **`777`** | `rwxrwxrwx` | Acceso total para todos (**Inseguro**, evitar en producción). |

## Modificación de Permisos con `chmod`

El comando `chmod` (*Change Mode*) permite alterar los permisos en sintaxis numérica o simbólica.

### Modo Simbólico
Estructura: `chmod [entidad][operador][permisos] archivo`

* **Entidades:** `u`, `g`, `o`, `a`
* **Operadores:**
  * `+` : Añade el permiso.
  * `-` : Quita el permiso.
  * `=` : Establece exactamente esos permisos (reemplaza los anteriores).

**Ejemplos prácticos:**
```bash
chmod u+x script.sh          # Otorga permiso de ejecución al propietario
chmod g+w documento.txt      # Otorga permiso de escritura al grupo
chmod o-rwx privado.txt      # Quita todos los permisos a "otros"
chmod ugo+x archivo          # Otorga ejecución a todos (equivale a chmod a+x)
chmod u=rw,g=r,o= archivo    # Asigna rw- al dueño, r-- al grupo y --- a otros
```

### Modo Octal / Numérico
Estructura: `chmod NNN archivo`

**Ejemplos prácticos:**
```bash
chmod 755 /var/www/html/index.php    # rwxr-xr-x
chmod 600 ~/.ssh/id_rsa              # rw-------
chmod -R 755 /var/www/html           # Aplica los permisos de forma recursiva (-R)
```

## Gestión de Propiedad: `chown` y `chgrp`

Además de modificar permisos, es habitual cambiar quién es el propietario o el grupo de un elemento.

### `chown` (*Change Owner*)
Permite cambiar el usuario propietario y/o el grupo:

```bash
chown usuario /ruta/fichero                # Cambia solo el propietario
chown usuario:grupo /ruta/fichero          # Cambia propietario y grupo
chown -R usuario:grupo /ruta/directorio    # Cambia propietario y grupo recursivamente
```

### `chgrp` (*Change Group*)
Cambia únicamente el grupo propietario:

```bash
chgrp grupo /ruta/fichero
```

## Máscara de Permisos por Defecto: `umask`

Cuando se crea un nuevo archivo o directorio, sus permisos por defecto están determinados por la **máscara de usuario (`umask`)**.

* **Permiso máximo teórico para archivos:** `666` (`rw-rw-rw-`) *(Los archivos no se crean con permiso de ejecución por seguridad)*.
* **Permiso máximo teórico para directorios:** `777` (`rwxrwxrwx`).

### Cálculo de permisos
$$\text{Permiso final} = \text{Permiso máximo} - \text{umask}$$

* Si la `umask` es `022`:
  * **Directorios:** $777 - 022 = 755$ (`rwxr-xr-x`)
  * **Archivos:** $666 - 022 = 644$ (`rw-r--r--`)
* Si la `umask` es `027`:
  * **Directorios:** $777 - 027 = 750$ (`rwxr-x---`)
  * **Archivos:** $666 - 027 = 640$ (`rw-r-----`)

Ver o cambiar la umask actual:
```bash
umask        # Muestra la umask actual (ej: 0022)
umask 027    # Establece temporalmente una umask más restrictiva
```

## Identificadores del Sistema: UID y GID

### UID (User ID)

Identificador numérico asignado a cada cuenta de usuario. Se gestionan en `/etc/passwd`.

* **UID `0`:** Usuario `root` (Superusuario con control absoluto del sistema).
* **UID `1` a `999`:** Cuentas de servicios y del sistema (ej. `www-data`, `systemd`, `sshd`).
* **UID `1000` en adelante:** Usuarios regulares del sistema.

Estructura de una línea en `/etc/passwd`:
```text
usuario:x:1002:1005:Juan Perez,/bin/bash
 │       │  │    │     │          └─ Shell por defecto
 │       │  │    │     └─ Comentario/GECOS (Nombre completo, oficina, etc.)
 │       │  │    └─ GID Primario
 │       │  └─ UID
 │       └─ 'x' indica que la contraseña cifrada está en /etc/shadow
 └─ Nombre de usuario
```

### GID (Group ID)

Identificador de grupo del sistema. Se gestionan en `/etc/group`.

* **Grupo Primario:** Asignado al usuario al momento de su creación (coincide con el GID en `/etc/passwd`).
* **Grupos Secundarios:** Grupos adicionales a los que se añade un usuario para otorgarle permisos específicos (ej. grupo `sudo`, `docker`, `wheel`).

Comandos útiles de consulta:
```bash
id                   # Muestra el UID, GID y grupos del usuario actual
id usuario           # Muestra la información de un usuario específico
whoami               # Muestra el nombre del usuario actual
```

## Permisos Especiales (SUID, SGID, Sticky Bit)

Además de los permisos estándar (`rwx`), existen 3 permisos especiales que se representan con un **cuarto dígito octal a la izquierda** (`Xrwxrwxrwx`).

Fichero de configuración global de límites de ID: `/etc/login.defs`

### SUID (Set User ID)
* **Valor octal:** `4000`
* **Representación en `ls -l`:** Sustituye la `x` del propietario por `s` (o `S` si no tenía permiso de ejecución previo). Ej: `-rwsr-xr-x`.
* **Función:** Cuando se ejecuta el archivo binario, el proceso se ejecuta **con los privilegios del propietario del archivo**, no con los del usuario que lo lanza.
* **Ejemplo clásico:** El comando `/usr/bin/passwd` tiene SUID activo (`rwsr-xr-x` propiedad de `root`). Esto permite a cualquier usuario modificar su propia contraseña en `/etc/shadow` (archivo restringido a root).

```bash
chmod u+s /ruta/binario    # Activa SUID simbólicamente
chmod 4755 /ruta/binario   # Activa SUID numéricamente
```

> **Riesgo de Seguridad:** Un binario mal diseñado o con SUID activo de `root` puede ser explotado para obtener escalada de privilegios local. Nunca debe aplicarse a scripts de bash/python.

### SGID (Set Group ID)
* **Valor octal:** `2000`
* **Representación en `ls -l`:** Sustituye la `x` del grupo por `s` (o `S`). Ej: `-rwxr-sr-x` o `drwxr-sr-x`.
* **Comportamiento:**
  * **En archivos:** El proceso se ejecuta con los privilegios del **grupo propietario** del archivo.
  * **En directorios:** **(Uso más común)** Todos los archivos o subdirectorios creados dentro heredarán automáticamente el *grupo propietario* del directorio padre, en lugar del grupo primario del usuario que crea el archivo. Ideal para carpetas compartidas entre equipos de trabajo.

```bash
chmod g+s /ruta/directorio_compartido    # Activa SGID simbólicamente
chmod 2775 /ruta/directorio_compartido   # Activa SGID numéricamente
```

### Sticky Bit
* **Valor octal:** `1000`
* **Representación en `ls -l`:** Sustituye la `x` de *otros* por `t` (o `T`). Ej: `drwxrwxrwt`.
* **Función:** Se aplica sobre **directorios**. Impide que los usuarios eliminen o renomren archivos de otros usuarios dentro de dicho directorio, **aunque tengan permiso de escritura en la carpeta**. Solo pueden eliminar un archivo el propietario del archivo, el propietario del directorio o `root`.
* **Uso típico:** Directorios temporales como `/tmp` y `/var/tmp`.

```bash
chmod +t /directorio_compartido          # Activa Sticky Bit simbólicamente
chmod o+t /directorio_compartido         # Otra forma simbólica
chmod 1777 /tmp                          # Configuración estándar de /tmp
```

### Resumen visual de la 'S' / 'T' en mayúscula vs. minúscula

| Símbolo | Permiso especial activo | Permiso `x` subyacente | Estado |
| :---: | :---: | :---: | :--- |
| **`s`** / **`t`** | **SÍ** | **SÍ** | Configuración correcta y funcional. |
| **`S`** / **`T`** | **SÍ** | **NO** | Inconsistencia: El permiso especial está activo pero falta el permiso de ejecución. |

## Ampliación: Listas de Control de Acceso (ACLs)

El esquema clásico POSIX (`u`, `g`, `o`) no permite dar permisos a un **segundo usuario específico** o a un **segundo grupo** sin cambiar la propiedad. Para eso existen las **ACLs** (*Access Control Lists*).

### Comandos principales:
* **`getfacl`:** Ver las ACLs de un archivo o directorio.
* **`setfacl`:** Modificar o asignar ACLs.

### Ejemplos prácticos:
```bash
# Dar permisos de lectura y escritura al usuario "juan" en un archivo del que no es dueño:
setfacl -m u:juan:rw archivo.txt

# Dar permisos de lectura, escritura y ejecución al grupo "auditoría":
setfacl -m g:auditoria:rwx /directorio

# Ver los permisos ACL extendidos:
getfacl archivo.txt

# Eliminar las reglas ACL de un archivo:
setfacl -b archivo.txt
```
