# Gestión de Redes en Docker

Por defecto, un contenedor es una entidad aislada. Su proceso principal se ejecuta en su propio `namespace de red`, lo que significa que no puede ver los puertos de la máquina anfitriona (el host) ni los de otros contenedores.

Para que los contenedores sean útiles, deben comunicarse entre sí y con el exterior.

## Drivers de red

| Driver | Equivalente en VirtualBox | Descripción |
| :--- | :--- | :--- |
| **bridge** (puente) | Red NAT | Driver por defecto. Crea una red IP privada interna en el anfitrión. Para exponer un servicio al exterior hay que publicar sus puertos. |
| **host** (anfitrión) | Adaptador puente | El contenedor **no** tiene su propio namespace de red: comparte directamente la interfaz de red del anfitrión. |
| **none** | Sin red | El contenedor queda sin conectividad (solo `loopback`). Máximo aislamiento. |
| **overlay** | — | Conecta contenedores de varios anfitriones (Docker Swarm). |
| **macvlan** | Adaptador puente con MAC propia | Asigna al contenedor una MAC y una IP de la red física. |

### Red bridge por defecto (`docker0`)

* Al instalar Docker se crea automáticamente una red bridge llamada `docker0` (rango típico `172.17.0.0/16`).
* Si se ejecuta un contenedor sin especificar red, se conecta a esta red.
* Limitaciones: los contenedores **solo se ven por IP**, no por nombre, y no hay aislamiento entre ellos.

### Red bridge definida por el usuario

Es la opción recomendada. Ventajas respecto a `docker0`:

* **Resolución DNS por nombre de contenedor** (un contenedor puede llamar a otro por su nombre).
* Mejor aislamiento: solo se comunican los contenedores conectados a la misma red.
* Se pueden conectar y desconectar contenedores sin reiniciarlos.

### Driver host

```sh
docker run -d --network host nginx
```

El servicio queda accesible directamente en el puerto del anfitrión (no hace falta `-p`). Solo funciona de forma completa en Linux.

## Comandos de gestión de redes

| Comando | Descripción |
| :--- | :--- |
| `docker network ls` | Lista las redes del sistema. |
| `docker network create [nombre]` | Crea una red (por defecto tipo bridge). |
| `docker network create --driver bridge --subnet 192.168.50.0/24 [nombre]` | Crea una red con subred personalizada. |
| `docker network inspect [nombre]` | Muestra los detalles de la red (subred, contenedores conectados) en JSON. |
| `docker network connect [red] [contenedor]` | Conecta un contenedor en marcha a una red. |
| `docker network disconnect [red] [contenedor]` | Desconecta un contenedor de una red. |
| `docker network rm [nombre]` | Elimina una red (no debe tener contenedores conectados). |
| `docker network prune` | Elimina todas las redes que no se estén usando. |

## Comunicación entre contenedores por nombre

```sh
# Creación de red
docker network create red_app

# Creación de la base de datos en dicha red
docker run -d --name base_datos --network red_app \
  -e MARIADB_ROOT_PASSWORD=ClaveSegura123 mariadb

# Creación de otro contenedor en la misma red y comprobar la conexión por nombre
docker run -it --rm --network red_app alpine ping -c 3 base_datos
```

> `base_datos` se resuelve automáticamente a la IP del contenedor porque están en una red definida por el usuario.

## Publicación de puertos

```sh
docker run -d -p 8080:80 nginx # Todos los interfaces del anfitrión
docker run -d -p 127.0.0.1:8080:80 nginx # Solo accesible desde el propio anfitrión
docker run -d -p 80 nginx # Puerto aleatorio del host
docker run -d -P nginx # Publica todos los puertos declarados con EXPOSE
```

Consultar los puertos de un contenedor: `docker port [id_o_nombre]`

## Diagnóstico

```sh
docker inspect --format '{{.NetworkSettings.IPAddress}}' [contenedor]
docker exec -it [contenedor] ip a
docker exec -it [contenedor] ping [otro_contenedor]
```
