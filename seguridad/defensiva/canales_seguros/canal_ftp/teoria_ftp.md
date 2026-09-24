# Protocolo FTP

FTP (*File Transfer Protocol*) es un protocolo de red estándar utilizado para la transferencia de archivos entre un cliente y un servidor en una red de computadoras. Funciona en sistemas **Linux** y **Windows**, pero por defecto no cifra la comunicación, transmitiendo datos y credenciales en texto claro.

**Datos técnicos:**
* **Protocolo:** FTP
* **Puerto por defecto:** 21/TCP (control) y 20/TCP (datos en modo activo)
* **Servicio:** vsftpd, proftpd, Pure-FTPd (daemons comunes en Linux)
* **Flujo:** IP → Red → Puerto (dos conexiones separadas)

Para conectarse por FTP estándar es necesario conocer:
* Usuario
* Contraseña
* Dirección del servidor

## FTP: Acceso, Configuración y Seguridad

### Instalación del servidor FTP (ejemplo con vsftpd en Linux)

```sh
sudo apt update
sudo apt install vsftpd
```

### Configuración básica del servidor vsftpd

Archivo principal de configuración: `/etc/vsftpd.conf`
```sh
sudo nano /etc/vsftpd.conf
```

### Parámetros esenciales a configurar
```conf
anonymous_enable=NO          # Deshabilitar acceso anónimo
local_enable=YES             # Permitir usuarios locales
write_enable=YES             # Permitir escritura
chroot_local_user=YES        # Limitar usuarios a su directorio home
allow_writeable_chroot=YES   # Permitir escritura en chroot
```

Reinicio del servicio:
```sh
sudo systemctl restart vsftpd
sudo systemctl status vsftpd
Conexión desde el cliente FTP
```

Formato básico de conexión: `ftp servidor.dominio.com`
Especificando puerto: `ftp servidor.dominio.com 21`

### Comandos FTP básicos (sesión interactiva)

| Comando | Descripción |
| :--- | :--- |
| `user nombre` | Especificar nombre de usuario |
| `pass contraseña` | Introducir contraseña |
| `ls` o `dir` | Listar archivos del servidor |
| `cd ruta` | Cambiar directorio en servidor |
| `lcd ruta` | Cambiar directorio local |
| `get archivo` | Descargar archivo del servidor |
| `put archivo` | Subir archivo al servidor |
| `mget *.txt` | Descargar múltiples archivos |
| `mput *.txt` | Subir múltiples archivos |
| `delete archivo` | Eliminar archivo en servidor |
| `mkdir nombre` | Crear directorio en servidor |
| `pwd` | Mostrar directorio actual del servidor |
| `quit` o `bye` | Salir de la sesión FTP |

### Ejemplo completo de sesión FTP

```console
ftp ftp.servidor.com
Connected to ftp.servidor.com.
220 (vsFTPd 3.0.3)
Name (ftp.servidor.com:user): mi_usuario
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> pwd
257 "/home/mi_usuario"
ftp> ls
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
-rw-r--r-- 1 1001 1001 1024 Mar 15 10:30 archivo.txt
-rw-r--r-- 1 1001 1001 2048 Mar 15 10:31 documento.pdf
226 Directory send OK.
ftp> get archivo.txt
local: archivo.txt remote: archivo.txt
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for archivo.txt (1024 bytes).
226 Transfer complete.
ftp> quit
221 Goodbye.
```

## Modos de Conexión FTP

**Modo Activo**
* El cliente abre un puerto aleatorio (>1023) para datos.
* El servidor se conecta desde el puerto 20 al puerto del cliente.
* Problemas comunes con firewalls.

**Modo Pasivo (PASV – recomendado)**
* El servidor abre un puerto aleatorio para datos.
* El cliente se conecta al puerto del servidor.
* Mejor compatibilidad con firewalls.
* Habilitar modo pasivo en vsftpd:

```Ini, TOML
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=50000
```
