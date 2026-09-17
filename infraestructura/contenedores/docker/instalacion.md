# Instalación y Post-Instalación (Ubuntu/Debian)

```bash
# 1. Instalación de paquetes necesarios
sudo apt update
sudo apt install -y docker.io docker-compose-plugin

# 2. Configuración de permisos (Evitar usar siempre sudo)
sudo usermod -aG docker $USER

# IMPORTANTE: Para que el cambio de grupo surta efecto, 
# debes cerrar sesión o ejecutar el siguiente comando:
newgrp docker

# 3. Verificación de versiones
docker version
docker compose version
```