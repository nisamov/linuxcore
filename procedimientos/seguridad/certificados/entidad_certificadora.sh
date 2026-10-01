sudo mkdir -p /etc/mysql/ssl
cd /etc/mysql/ssl
sudo openssl genrsa 2048 > ca-key.pem # Llave de la Entidad certificadora
sudo openssl req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -subj "/CN=MariaDB-CA"
# Al usar "ls" aparecerá -> ca-key.pem (llave privada) y ca.pem (certificado privado)
sudo openssl req -newkey rsa:2048 -days 3650 -nodes -keyout server-key.pem -out server-req.pem -subj "/CN=MariaDB-Server"
sudo openssl x509 -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem  # Firma
chown -R mysql:mysql /etc/mysql/ssl/
chmod 600 /etc/mysql/ssl/*pem
#edicion de 
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```
# Descomentar y renombrar:
ssl-ca = /etc/mysql/ssl/ca.pem
ssl-cert = /etc/mysql/ssl/server-cert.pem
ssl-key = /etc/mysql/ssl/server-key.pem
```
sudo systemctl mariadb restart
# conexion con ssl
mariadb -h 192.168.1.3 -u usuarioEjemplo -p --ssl
# obligar a que siempre use ssl, para evitar conexiones sin certificado
