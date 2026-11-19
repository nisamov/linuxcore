# Configuración persistente de red en Linux

La configuración persistente conserva los parámetros de red después de reiniciar el sistema. El mecanismo concreto depende de la distribución y del administrador de red instalado.

## Identificar el administrador de red

```bash
ip -br link
ip -br address
ip route
nmcli general status
systemctl is-active NetworkManager
systemctl is-active systemd-networkd
```

- `ip` muestra enlaces, direcciones y rutas.
- `nmcli` administra NetworkManager.
- `networkctl` muestra estados administrados por `systemd-networkd`.

Instalar o cambiar el administrador de red puede modificar la conectividad. Realiza las pruebas desde una conexión que permita recuperarla y conserva una copia de la configuración anterior.

## Configuración con NetworkManager

### Consultar dispositivos y conexiones

```bash
nmcli device status
nmcli connection show
nmcli connection show --active
```

### Direccionamiento dinámico

```bash
nmcli connection modify "Wired connection 1" ipv4.method auto
nmcli connection modify "Wired connection 1" ipv6.method auto
nmcli connection up "Wired connection 1"
```

### Direccionamiento estático

```bash
nmcli connection modify "Wired connection 1" ipv4.method manual
nmcli connection modify "Wired connection 1" ipv4.addresses "192.0.2.20/24"
nmcli connection modify "Wired connection 1" ipv4.gateway "192.0.2.1"
nmcli connection modify "Wired connection 1" ipv4.dns "192.0.2.53"
nmcli connection up "Wired connection 1"
```

Las direcciones `192.0.2.0/24` pertenecen a documentación y no se conectan a redes reales sin adaptar el entorno.

## Configuración con Netplan

Netplan utiliza archivos YAML ubicados normalmente en `/etc/netplan/`:

```bash
sudo ls -l /etc/netplan
sudo nano /etc/netplan/01-network.yaml
```

Ejemplo con DHCP:

```yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: true
```

Ejemplo estático:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      addresses:
        - 192.0.2.20/24
      routes:
        - to: default
          via: 192.0.2.1
      nameservers:
        addresses:
          - 192.0.2.53
```

Valida y aplica:

```bash
sudo netplan generate
sudo netplan try
```

`netplan try` ofrece una ventana de recuperación si pierde la conectividad. Si el adaptador tiene otro nombre, sustituye `enp0s3` por el obtenido con `ip -br link`.

## Configuración con systemd-networkd

Crea o revisa unidades `.network` en `/etc/systemd/network/`:

```ini
[Match]
Name=enp0s3

[Network]
DHCP=yes
DNS=192.0.2.53
```

Para una dirección estática:

```ini
[Match]
Name=enp0s3

[Network]
Address=192.0.2.20/24
Gateway=192.0.2.1
DNS=192.0.2.53
```

Aplica:

```bash
sudo systemctl enable --now systemd-networkd
sudo networkctl reload
sudo networkctl status enp0s3
```

## Resolución DNS persistente

Comprueba qué mecanismo administra `/etc/resolv.conf`:

```bash
readlink -f /etc/resolv.conf
cat /etc/resolv.conf
resolvectl status
```

En sistemas con `systemd-resolved`, la configuración debe hacerse preferentemente en el administrador de red o mediante `resolvectl`. Editar `/etc/resolv.conf` manualmente puede perderse al reiniciar o al renovar el DHCP.

## Verificación

```bash
ip -br address
ip route
nmcli device show
ping -c 3 192.0.2.1
getent hosts example.invalid
```

Confirma dirección, puerta de enlace, resolución de nombres y conectividad. Evita usar nombres o rutas ajenas al entorno si no están disponibles.

## Reversión

Con NetworkManager:

```bash
nmcli connection reload
nmcli connection up "Wired connection 1"
```

Con Netplan, restaura el archivo anterior y vuelve a generar la configuración:

```bash
sudo cp /ruta/copia/01-network.yaml /etc/netplan/01-network.yaml
sudo netplan generate
sudo netplan apply
```

## Advertencias

- Cambiar una dirección remota por SSH puede interrumpir la sesión.
- Confirma el nombre del adaptador antes de aplicarlo.
- Guarda una copia de la configuración previa.
- No combines NetworkManager, Netplan y systemd-networkd sobre el mismo enlace sin definir cuál tiene prioridad.
