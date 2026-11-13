# Instalación y gestión del servicio MariaDB

## Preparación del sistema

Antes de instalar servicios hay que actualizar los repositorios:

```sh
sudo apt update
```

## Instalación del servidor y del cliente

```sh
sudo apt install mariadb-server mariadb-client -y
```

## Configuración de seguridad inicial

```sh
sudo mysql_secure_installation
```

También existe como `mariadb-secure-installation` en versiones recientes.

Consideraciones:

- Se admiten contraseñas de menos de 8 caracteres, aunque se considera inseguro.
- Si la contraseña se deja vacía, el sistema lo acepta.
- La contraseña debe almacenarse en un entorno seguro.

## Gestión del servicio

```sh
# Ver estado
sudo systemctl status mariadb.service

# Iniciar
sudo systemctl start mariadb.service

# Detener
sudo systemctl stop mariadb.service
```

## Acceso al cliente

```sh
mysql -u root -p
```

Dentro del cliente se puede comprobar usuario, versión y hora actual de la conexión:

```sql
SELECT USER(), VERSION(), NOW();
```
