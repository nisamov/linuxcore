# Crear certificados X.509 con OpenSSL

Este procedimiento describe cómo crear certificados digitales **X.509** utilizando OpenSSL. Se incluyen dos escenarios:

1. Crear un certificado **autofirmado**, apropiado principalmente para pruebas y entornos de desarrollo.
2. Crear una **Autoridad de Certificación (CA) raíz** y utilizarla para firmar certificados de servidor, que es el procedimiento recomendado cuando se necesita una infraestructura de certificados propia.

El procedimiento utiliza **RSA de 2048 bits**, certificados en formato **PEM** y la extensión **Subject Alternative Name (SAN)** para identificar correctamente los dominios o direcciones IP para los que es válido el certificado.

## Conceptos básicos

| Elemento | Archivo habitual | Función |
|---|---|---|
| Clave privada | `.key` | Permite realizar operaciones criptográficas y firmar solicitudes o certificados. |
| CSR | `.csr` | Solicitud de firma de certificado. |
| Certificado | `.crt` / `.pem` | Contiene la clave pública y la identidad del sujeto. |
| CA raíz | `rootCA.crt` | Certificado de la autoridad que firma otros certificados. |
| Clave privada de la CA | `rootCA.key` | Se utiliza para firmar los certificados emitidos por la CA. |
| PKCS#12 | `.p12` / `.pfx` | Contenedor que puede incluir certificado, clave privada y cadena de certificados. |

## Crear una clave privada RSA

La clave privada es el elemento secreto del certificado y **nunca debe distribuirse públicamente**.

Para crear una clave RSA de 2048 bits protegida mediante contraseña:

```sh
openssl genrsa -des3 -out domain.key 2048
```

OpenSSL solicitará una contraseña para proteger `domain.key`.

Los principales parámetros son:

- `genrsa`: genera una clave privada RSA.
- `-des3`: cifra la clave privada mediante una contraseña.
- `-out domain.key`: especifica el archivo de salida.
- `2048`: tamaño de la clave RSA en bits.

Se recomienda limitar los permisos del archivo:

```sh
chmod 600 domain.key
```

> **Importante:** la contraseña de la clave privada no debe almacenarse junto al archivo de clave ni compartirse con terceros.

## Crear una CSR

Una **CSR (Certificate Signing Request)** es una solicitud de firma de certificado.

Contiene información sobre la identidad que se desea incluir en el certificado y la clave pública correspondiente a la clave privada. La CSR **no contiene la clave privada**.

Para crearla:

```sh
openssl req -key domain.key -new -out domain.csr
```

OpenSSL solicitará la contraseña de `domain.key` y posteriormente los datos del sujeto del certificado.

Ejemplo:

```text
Country Name (2 letter code) [AU]:ES
State or Province Name (full name) [Some-State]:Aragon
Locality Name (eg, city) []:Zaragoza
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company
Organizational Unit Name (eg, section) []:IT
Common Name (e.g. server FQDN or YOUR name) []:domain.example.com
Email Address []:admin@example.com
```

También pueden aparecer atributos adicionales:

```text
A challenge password []:
An optional company name []:
```

### Common Name

El campo `Common Name` (`CN`) identifica tradicionalmente el nombre principal del certificado.

Ejemplo:

```text
CN = server.example.com
```

Para certificados TLS modernos, el `Common Name` no debe utilizarse como sustituto de **Subject Alternative Name (SAN)**. Los nombres DNS y direcciones IP deben especificarse mediante SAN.

## Crear la clave y la CSR en un solo comando

También es posible generar la clave privada y la CSR en una única operación:

```sh
openssl req -newkey rsa:2048 -keyout domain.key -out domain.csr
```

Para generar una clave privada **sin cifrado**:

```sh
openssl req -newkey rsa:2048 -noenc -keyout domain.key -out domain.csr
```

En versiones antiguas de OpenSSL es habitual encontrar la opción:

```text
-nodes
```

Una clave privada sin cifrar puede ser necesaria para determinados servicios que deben iniciarse automáticamente, pero requiere especial cuidado en materia de permisos y control de acceso.

## Crear un certificado autofirmado

Un certificado autofirmado es aquel cuya firma procede de la propia clave privada asociada al certificado.

Puede crearse directamente mediante:

```sh
openssl req -key domain.key -new -x509 -days 365 -out domain.crt
```

También es posible generar la clave y el certificado en una única operación:

```sh
openssl req -newkey rsa:2048 -keyout domain.key -x509 -days 365 -out domain.crt
```

El resultado será:

- `domain.key`: clave privada.
- `domain.crt`: certificado autofirmado.

### Uso habitual

Los certificados autofirmados son apropiados principalmente para:

- Desarrollo.
- Laboratorios.
- Pruebas.
- Servicios donde la confianza se configura manualmente.

Los clientes no confiarán automáticamente en un certificado autofirmado si su emisor no pertenece a un almacén de confianza.

## Crear una CA raíz propia

Para un entorno interno es posible crear una **Autoridad de Certificación (CA)**.

La CA será responsable de firmar los certificados de los servidores.

Para crear la clave privada de la CA y su certificado autofirmado:

```sh
openssl req \
    -x509 \
    -sha256 \
    -days 1825 \
    -newkey rsa:2048 \
    -keyout rootCA.key \
    -out rootCA.crt
```

Se obtienen:

- `rootCA.key`: clave privada de la CA.
- `rootCA.crt`: certificado público de la CA.

`rootCA.key` debe permanecer estrictamente protegida. `rootCA.crt` puede distribuirse a los equipos y aplicaciones que deban confiar en la CA.

En el ejemplo se utilizan `1825` días, aproximadamente cinco años, como período de validez de la CA.

## Firmar la CSR con la CA

Una vez creada la CA y generada la CSR del servidor, la CA puede utilizarse para firmarla:

```sh
openssl x509 \
    -req \
    -CA rootCA.crt \
    -CAkey rootCA.key \
    -in domain.csr \
    -out domain.crt \
    -days 365 \
    -CAcreateserial
```

El resultado es:

```text
domain.crt
```

Este certificado ha sido firmado por `rootCA`.

El proceso anterior puede utilizarse para emitir certificados para diferentes servidores o servicios utilizando la misma CA, siempre que los certificados resultantes estén correctamente configurados.

## Subject Alternative Name (SAN)

La extensión **Subject Alternative Name (SAN)** permite especificar explícitamente los nombres DNS y direcciones IP para los que es válido un certificado.

Para certificados TLS, la identidad del servidor debe incluirse mediante SAN.

Ejemplo para un único dominio:

```ini
DNS.1 = domain.example.com
```

Ejemplo con varios nombres:

```ini
DNS.1 = domain.example.com
DNS.2 = www.domain.example.com
DNS.3 = api.domain.example.com
```

También pueden incluirse direcciones IP:

```ini
IP.1 = 192.168.1.10
IP.2 = 192.168.1.11
```

Un mismo certificado puede contener varios nombres DNS y direcciones IP.

## Crear la configuración de extensiones

Crear un archivo llamado:

```text
domain.ext
```

Con el siguiente contenido:

```ini
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
subjectAltName = @alt_names

[alt_names]
DNS.1 = domain.example.com
```

Para varios nombres y direcciones:

```ini
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
subjectAltName = @alt_names

[alt_names]
DNS.1 = domain.example.com
DNS.2 = www.domain.example.com
DNS.3 = api.domain.example.com
IP.1 = 192.168.1.10
```

### `basicConstraints = CA:FALSE`

Indica que el certificado es un certificado final y **no debe utilizarse como CA para firmar otros certificados**.

### `subjectAltName`

Define las identidades para las que el certificado es válido.

### `authorityKeyIdentifier`

Permite identificar la autoridad de certificación asociada a la emisión del certificado.

## Firmar el certificado incluyendo SAN

Una vez creado `domain.ext`, se puede firmar la CSR incluyendo las extensiones:

```sh
openssl x509 \
    -req \
    -CA rootCA.crt \
    -CAkey rootCA.key \
    -in domain.csr \
    -out domain.crt \
    -days 365 \
    -CAcreateserial \
    -extfile domain.ext
```

El certificado resultante contiene la extensión SAN.

También puede aparecer un archivo adicional:

```text
rootCA.srl
```

Este archivo se utiliza para gestionar el número de serie de los certificados emitidos por OpenSSL mediante este procedimiento simplificado.

## Estructura final de archivos

Después de completar el procedimiento pueden existir los siguientes archivos:

```text
domain.key
domain.csr
domain.crt
domain.ext
rootCA.key
rootCA.crt
rootCA.srl
```

### Archivos sensibles

Los siguientes archivos contienen información especialmente sensible:

```text
rootCA.key
domain.key
```

La clave privada de la CA es especialmente crítica porque permite emitir certificados que serán considerados válidos por los sistemas que confían en `rootCA.crt`.

## Verificar el certificado

Para visualizar el contenido del certificado en formato legible:

```sh
openssl x509 -in domain.crt -text -noout
```

Entre la información mostrada se encuentran:

| Campo | Descripción |
|---|---|
| `Version` | Versión de X.509. |
| `Serial Number` | Número de serie del certificado. |
| `Signature Algorithm` | Algoritmo utilizado para firmar el certificado. |
| `Issuer` | Autoridad que emitió el certificado. |
| `Validity` | Período de validez. |
| `Subject` | Identidad del titular del certificado. |
| `Subject Public Key Info` | Información de la clave pública. |
| `X509v3 extensions` | Extensiones incluidas en el certificado. |

Para comprobar específicamente el SAN:

```sh
openssl x509 -in domain.crt -noout -ext subjectAltName
```

Ejemplo:

```text
X509v3 Subject Alternative Name:
    DNS:domain.example.com, DNS:www.domain.example.com
```

## Comprobar la cadena de confianza

Para verificar que el certificado ha sido firmado por nuestra CA:

```sh
openssl verify -CAfile rootCA.crt domain.crt
```

Cuando la validación es correcta:

```text
domain.crt: OK
```

Esta comprobación permite confirmar que el certificado puede validarse utilizando `rootCA.crt` como autoridad de confianza.

## Comprobar la correspondencia entre clave y certificado

También es útil comprobar que la clave privada utilizada por el servidor corresponde al certificado.

Obtener la clave pública contenida en el certificado:

```sh
openssl x509 -in domain.crt -pubkey -noout
```

Obtener la clave pública correspondiente a la clave privada:

```sh
openssl pkey -in domain.key -pubout
```

Las dos claves públicas deben ser idénticas.

## Formato PEM

Los certificados generados por OpenSSL suelen utilizar formato **PEM**.

Un certificado PEM contiene datos codificados en Base64 y delimitados por:

```text
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
```

PEM es un formato de representación textual habitual para certificados y otros objetos criptográficos.

## Convertir el certificado a DER

El formato **DER** representa el certificado mediante una codificación binaria ASN.1.

Para convertir un certificado PEM a DER:

```sh
openssl x509 \
    -in domain.crt \
    -outform DER \
    -out domain.der
```

El resultado será:

```text
domain.der
```

PEM y DER representan el mismo certificado; la diferencia está en la forma de codificación.

## Crear un archivo PKCS#12 / PFX

**PKCS#12** es un formato contenedor que puede almacenar la clave privada junto con el certificado y, opcionalmente, certificados de la cadena de confianza.

Es habitual encontrar las extensiones:

```text
.p12
.pfx
```

Para combinar la clave privada y el certificado:

```sh
openssl pkcs12 \
    -inkey domain.key \
    -in domain.crt \
    -export \
    -out domain.pfx
```

OpenSSL solicitará una contraseña para proteger el archivo PKCS#12.

Este formato es habitual cuando una aplicación necesita importar conjuntamente la clave privada y el certificado, por ejemplo en determinados entornos Windows/IIS.

## Flujo recomendado

Para un entorno de laboratorio o infraestructura interna, el procedimiento completo puede resumirse en los siguientes pasos.

### Creación de CA

```sh
openssl req \
    -x509 \
    -sha256 \
    -days 1825 \
    -newkey rsa:2048 \
    -keyout rootCA.key \
    -out rootCA.crt
```

### Crear la clave privada del servidor

```sh
openssl genrsa -out domain.key 2048
```

### Creación de la CSR

```sh
openssl req \
    -new \
    -key domain.key \
    -out domain.csr
```

### Creación de la configuración SAN

Crear `domain.ext`:

```ini
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
subjectAltName = @alt_names

[alt_names]
DNS.1 = domain.example.com
```

### Firmar la CSR

```sh
openssl x509 \
    -req \
    -CA rootCA.crt \
    -CAkey rootCA.key \
    -in domain.csr \
    -out domain.crt \
    -days 365 \
    -CAcreateserial \
    -extfile domain.ext
```

### Verificación de certificado

```sh
openssl x509 \
    -in domain.crt \
    -text \
    -noout
```

### Comprobación la cadena de confianza

```sh
openssl verify \
    -CAfile rootCA.crt \
    domain.crt
```

Resultado esperado:

```text
domain.crt: OK
```

## Diferencia entre certificado autofirmado y certificado emitido por una CA

### Certificado autofirmado

La propia identidad del certificado genera su firma.

Es adecuado principalmente para:

- Desarrollo.
- Pruebas.
- Laboratorios.
- Servicios donde la confianza se configura manualmente.

### Certificado firmado por una CA propia

Una CA independiente firma el certificado del servidor.

Este modelo permite utilizar una única CA para emitir certificados destinados a múltiples servicios internos, siempre que los clientes confíen en el certificado de la CA.

## Recomendaciones de seguridad

- Proteger `rootCA.key` y `domain.key` mediante permisos restrictivos.
- No distribuir `rootCA.key` a servidores que únicamente necesitan utilizar certificados emitidos por la CA.
- Distribuir `rootCA.crt` únicamente a los sistemas que deban confiar en la CA.
- No compartir las claves privadas.
- Utilizar SAN para definir los nombres DNS y direcciones IP del certificado.
- Verificar los certificados antes de instalarlos en los servicios.
- Mantener la clave privada de la CA aislada y con acceso restringido.
- No utilizar certificados autofirmados como sustituto de una CA de confianza en entornos donde se requiera una cadena de confianza gestionada.

## Verificación
Los comandos principales de verificación son:

```sh
openssl verify -CAfile rootCA.crt domain.crt
# O bien
openssl x509 -in domain.crt -text -noout
```

Comprobación SAN:

```sh
openssl x509 -in domain.crt -noout -ext subjectAltName
```

> **Nota:** este procedimiento está orientado a la creación de certificados con OpenSSL para laboratorios, desarrollo e infraestructuras internas. Para certificados públicos utilizados en Internet normalmente se utiliza una CA pública de confianza en lugar de una CA privada creada localmente.

## Referencia

Documentación original proporcionada para este procedimiento, basada en el artículo de [Baeldung](https://www.baeldung.com/openssl-self-signed-cert#1-convert-pem-to-der) sobre certificados autofirmados con OpenSSL.
