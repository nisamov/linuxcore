# Footprinting

El footprinting es la primera fase de un ataque o de una auditoría de caja negra. Consiste en recopilar información sobre la organización objetivo mediante una **búsqueda pasiva**, es decir, sin interactuar con sus sistemas.

## Fuentes de información

Las principales fuentes son Internet y la ingeniería social. Algunas fuentes concretas son:

- Sitios web de la organización publicados en Internet.
- Perfiles de la organización en redes sociales.
- Ofertas de empleo, que dan pistas sobre las tecnologías que utilizan.
- Registros públicos de DNS y de dominios (por ejemplo, mediante whois).

Al finalizar el proceso se realiza un análisis y filtrado de la información obtenida. Existen herramientas que automatizan esta labor.

## Herramientas

### Google Hacking o Google Dorking

Consiste en utilizar operadores avanzados en las búsquedas (comillas, `AND`, `OR`, `intitle`, `inurl`, `site`, etc.) para localizar información que no debería estar expuesta.

La **Google Hacking Database** es un repositorio de *dorks* creados por la comunidad para encontrar páginas interesantes desde el punto de vista de la seguridad, como:

- Pantallas de login de aplicaciones web conocidas.
- Interfaces web de administración de dispositivos de red, cámaras de seguridad, etc.

### Shodan

Motor de búsqueda que permite encontrar dispositivos y recursos conectados a Internet:

- Routers.
- Servidores.
- Dispositivos IoT (cámaras de videovigilancia, termostatos, semáforos, etc.).

### Maltego

Aplicación de recolección de información que busca en repositorios gratuitos de Internet. Muestra los resultados de forma muy visual, como nodos y relaciones entre ellos.

### FOCA

Siglas de *Fingerprinting Organizations with Collected Archives*. Obtiene información a partir de documentos publicados en Internet:

- Busca ficheros en motores de búsqueda populares (Google, Bing y DuckDuckGo).
- Analiza los metadatos de los documentos y las URL donde están disponibles.
- Analiza documentos ofimáticos de Microsoft Office y LibreOffice, además de PDF, ficheros de imagen, etc.

### Robtex

Herramienta online gratuita que recupera información pública de DNS (dominios y direcciones IP). También muestra el proveedor de Internet que da servicio al dominio, la popularidad del sitio y si aparece en alguna lista negra.

### theHarvester

Herramienta gratuita para entornos Linux. Recopila correos electrónicos, nombres, subdominios, IP y URL utilizando múltiples fuentes públicas (repositorios y motores de búsqueda).

### Recon-ng

Framework escrito en Python para footprinting y fingerprinting web. Automatiza tareas de obtención de información.
