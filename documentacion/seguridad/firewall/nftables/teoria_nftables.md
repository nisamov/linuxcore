# Teoría y ejemplos de nftables

`nftables` es el marco de filtrado de paquetes del núcleo Linux y la herramienta `nft` permite administrar sus reglas. Una configuración define una familia de protocolos, tablas, cadenas, reglas y acciones. En sistemas actuales suele sustituir a `iptables`, aunque algunas distribuciones mantienen capas de compatibilidad.

## Conceptos

- **Familia:** determina qué tráfico se procesa, por ejemplo `inet` para IPv4 e IPv6, `ip` para IPv4 o `ip6` para IPv6.
- **Tabla:** agrupa cadenas y conjuntos de reglas.
- **Cadena base:** se conecta a un punto de procesamiento, como entrada, salida o reenvío, y puede tener una política predeterminada.
- **Regla:** expresa condiciones sobre paquetes y una acción, como aceptar, descartar o rechazar.
- **Conjunto:** permite agrupar direcciones, puertos u otros valores para reutilizarlos.

El orden importa: las reglas se evalúan secuencialmente y la primera acción terminal puede determinar el resultado. Deben contemplarse también el tráfico de loopback, las conexiones establecidas y el acceso administrativo requerido.

## Ejemplo didáctico para un host Linux

El siguiente ejemplo es una plantilla conceptual para un equipo de laboratorio: permite loopback y conexiones establecidas, y acepta SSH. No define una política de salida ni reenvío. La sintaxis puede variar según la versión; el archivo debe validarse antes de aplicarlo.

```nft
table inet filtro {
    chain entrada {
        type filter hook input priority filter; policy drop;
        iifname "lo" accept
        ct state established,related accept
        tcp dport 22 ct state new accept
    }
}
```

Aplicar una política de entrada `drop` puede cortar sesiones remotas y bloquear servicios. Una plantilla no debe ejecutarse sin adaptación, acceso de recuperación por consola y una copia de las reglas activas. En la administración remota debe planificarse una reversión temporizada y realizarse primero una prueba en un entorno de ensayo.

## Carga y comprobación

`nft -c -f archivo.nft` comprueba la sintaxis sin aplicar las reglas. Para inspeccionar el conjunto activo se utiliza `nft list ruleset`; la lectura suele estar disponible con permisos administrativos según la distribución. La carga persistente se configura mediante el servicio o mecanismo propio de la distribución; los cambios deben guardarse en la ubicación documentada para ese sistema.

Antes de una modificación, deben registrarse el estado actual y el método de recuperación. Después de aplicarla, deben verificarse el acceso administrativo, el tráfico permitido y denegado, y la persistencia tras reiniciar el servicio. No se recomienda combinar gestores de firewall sin conocer cómo coordinan las reglas.
