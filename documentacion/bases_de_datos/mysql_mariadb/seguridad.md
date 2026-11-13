# Seguridad avanzada: autenticación, SSL, túnel SSH y AppArmor

## Plugins de autenticación

Un plugin define cómo se comprueba la identidad de un usuario. Los plugins disponibles están en `/usr/lib/mysql/plugin/`.

### ed25519

```sql
-- Cargar el plugin
INSTALL PLUGIN ed25519 SONAME 'auth_ed25519.so';

-- Crear usuario que usa ed25519
CREATE USER 'manolo'@'localhost' IDENTIFIED VIA ed25519 USING PASSWORD('clave123');
```

### PAM (usuarios del sistema operativo)

En lugar de usuarios de MariaDB, se autentica contra los usuarios del sistema.

```sql
INSTALL PLUGIN pam SONAME 'auth_pam.so';

CREATE USER 'manolo'@'%' IDENTIFIED VIA pam USING 'mariadb';
```

El nombre que va en `USING` ('mariadb') corresponde al fichero de configuración PAM de ese servicio, con las reglas de autenticación. Después hay que salir de MariaDB y crear el usuario en el sistema:

```sh
sudo adduser manolo
```

### AppArmor y PAM

AppArmor restringe qué archivos puede leer o ejecutar cada programa. MariaDB solo puede leer lo que está en `/var/lib/...`, por lo que para gestionar usuarios con PAM hay que darle permisos de lectura sobre lo necesario o cambiar el modo del perfil.

```sh
sudo mysql -u root -p
```

```sql
CREATE USER 'manolo100'@'localhost' IDENTIFIED VIA pam USING 'mariadb';
FLUSH PRIVILEGES;
EXIT;
```

```sh
sudo adduser manolo100
sudo apt install apparmor apparmor-utils
```

Modos del perfil:

- **Enforce**: deniega las acciones no permitidas y registra el aviso.
- **Complain**: permite las acciones aunque no estén permitidas y solo las registra. Con esto el usuario puede salir de la carpeta `/var/lib/mariadb` en la que estaba confinado.

```sh
sudo aa-complain /usr/sbin/mariadbd
```

## Requisitos de conexión segura por usuario

```sql
-- Exige conexión SSL
CREATE USER 'manolo'@'localhost' IDENTIFIED BY 'clave123' REQUIRE SSL;

-- Exige SSL con certificado de cliente x509
CREATE USER 'manolo'@'localhost' IDENTIFIED BY 'clave123' REQUIRE X509;

-- Exige un cifrado concreto
CREATE USER 'manolo'@'localhost' IDENTIFIED BY 'clave123' REQUIRE CIPHER 'TipoDeCifrado';
```

Ejemplo completo con TLS 1.2 y cifrado concreto:

```sql
CREATE USER 'usuario_seguro'@'%'
    IDENTIFIED VIA ed25519 USING PASSWORD('ContrasenaExtremadamenteSegura123!')
    REQUIRE CIPHER 'ECDHE-RSA-AES128-GCM-SHA256';
```

Desglose del nombre del cifrado:

- **ECDHE**: intercambio de claves.
- **RSA**: autenticación.
- **AES128**: cifrado del tráfico.
- **GCM**: modo de cifrado.
- **SHA256**: verificación de integridad.

## Forzar SSL en las conexiones

Desde el cliente:

```sh
mariadb -h 192.168.1.3 -u usuario -p --ssl
```

Para forzar SSL a todos los usuarios, descomentar las líneas de `ssl` en `/etc/mysql/mariadb.conf.d/50-server.cnf`. Para que el servidor no escuche en todas las interfaces, cambiar `bind-address`.

También es posible añadir otra capa combinando SSL con un túnel SSH.

## Túnel SSH hacia MariaDB

```sql
-- En el servidor: usuario que se conecta por el túnel
CREATE USER 'remotessl'@'127.0.0.1' IDENTIFIED BY 'clave123';
GRANT ALL PRIVILEGES ON *.* TO 'remotessl'@'127.0.0.1';
FLUSH PRIVILEGES;
```

```sh
# En el cliente: crear el túnel (puerto local 3307 -> puerto 3306 del servidor)
ssh -N -L 3307:127.0.0.1:3306 ejemplousuario@192.168.1.3

# Conexión segura a través del túnel
mariadb -h 127.0.0.1 -P 3307 -u remotessl -p --ssl
```
