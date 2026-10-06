# Bind9 Teoria General

## Servidor Pirncipal

Instalación
```sh
sudo apt update && sudo apt install bind9 bind9utils bind9-doc dnsutils -y
```
Configuración servidor primario `/etc/bind/named.conf.options`:
```conf
options {
        directory "/var/cache/bind";
        listen-on port 53 { 127.0.0.1; 192.168.1.10; };
        allow-query { any; };
        forwarders {
                8.8.8.8;
        };
        dnssec-validation auto;
};
```

Declarar zonas `/etc/bind/named.conf.local`
```conf
// Zona Directa
zone "ejemplo.es" {
    type master;
    file "/etc/bind/db.ejemplo.es";
    allow-transfer { 192.168.1.20; };
    also-notify { 192.168.1.20; };
};
// Zona Inversa
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.1";
    allow-transfer { 192.168.1.20; };
    also-notify { 192.168.1.20; };
};
```
Crear archivo en zona directa `/etc/bind/db.ejemplo.es`
```conf
$TTL    604800
@       IN      SOA     ns1.ejemplo.es. root.ejemplo.es. (
                              2         ; Serial (incrementar si modificas)
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.ejemplo.es.
@       IN      NS      ns2.ejemplo.es.

ns1     IN      A       192.168.1.10
ns2     IN      A       192.168.1.20
cliente IN      A       192.168.1.100
```

Crear zona inversa `/etc/bind/db.192.168.1`
```conf
$TTL    604800
@       IN      SOA     ns1.ejemplo.es. root.ejemplo.es. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.ejemplo.es.
@       IN      NS      ns2.ejemplo.es.

10      IN      PTR     ns1.ejemplo.es.
20      IN      PTR     ns2.ejemplo.es.
100     IN      PTR     cliente.ejemplo.es.
```
Verificación de servicio y reinicio
```sh
sudo named-checkconf
sudo named-checkzone ejemplo.es /etc/bind/db.ejemplo.es
sudo named-checkzone 1.168.192.in-addr.arpa /etc/bind/db.192.168.1
sudo systemctl restart bind9
```

## Servidor Secundario

Modificar `/etc/bind/named.conf.options`
```
options {
        directory "/var/cache/bind";
        listen-on port 53 { 127.0.0.1; 192.168.1.20; };
        allow-query { any; };
        forwarders {
                8.8.8.8;
        };
        dnssec-validation auto;
};
```
Declarar zonas `/etc/bind/named.conf.local`
```conf
// Zona Directa Secundaria
zone "ejemplo.es" {
    type slave;
    file "/var/cache/bind/db.ejemplo.es";
    masters { 192.168.1.10; };
};

// Zona Inversa Secundaria
zone "1.168.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.168.1";
    masters { 192.168.1.10; };
};
```
Verificar servicio
```sh
sudo named-checkconf
sudo systemctl restart bind9
```

