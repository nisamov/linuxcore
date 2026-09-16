# Preparación del Sistema
## Actualización del sistema operativo

Antes de instalar servicios es necesario actualizar los repositorios:
```sh
sudo apt update
```
# Instalación de MariaDB
## Instalación del servidor y cliente
```sh
sudo apt install mariadb-server mariadb-client -y

sudo mariadb-secure-installarion # Instalacion segura
```
## Gestión del servicio
Ver estado del servicio:
```sh
sudo systemctl status mariadb.service
```
Iniciar servicio:
```sh
sudo systemctl start mariadb.service
```
Detener servicio:
```sh
sudo systemctl stop mariadb.service
```
## Configuración de seguridad inicial
```sh
sudo mysql_secure_installation
```
Consideraciones:
- Se admite establecer contraseñas de menos de 8 caracteres, aunque se considera inseguro.
- Si la contraseña se deja vacía, el sistema lo acepta.
- La contraseña debe almacenarse en un entorno seguro.
# Acceso y Operaciones Básicas
## Acceder al cliente MariaDB
```sql
mysql -u root -p
```