# Teoría General del Cifrado

## Cifrado Simétrico (Criptografía de Clave Privada)

Arquitectura criptográfica basada en el uso de una **única clave compartida** (*symmetric key*) tanto para la fase de cifrado como para la de descifrado.

Cifrado simétrico con algoritmo AES-256 usando OpenSSL con referencia a [teoria_hash.md](../algoritmos_hash/teoria_hash.md).
```sh
# Cifrado de message.txt
openssl enc -aes256 -e -pass pass:1234 -in message.txt -out message.aes
# Con este comando la clave de 256 bits de larga se deriva del password suministrado. Si se quiere visualizar la clave derivada, añade -P al final del comando (AVISO: en ese caso no se cifra nada).

# Descifrado
openssl enc -aes256 -d -pass pass:1234 -out message2.txt -in message.aes
# Con los dos comandos anteriores no se requiere excesivo conocimiento de como funciona el cifrado AES. Este algoritmo de cifrado utiliza una clave y además un IV (initialization vector). Estos valores se pueden proporcionar explícitamente al comando openssl enc para que los utilice para encriptar o desencriptar.

# Ejemplo de comando openssl para cifrado:
openssl enc -aes256 -e -K 0816A69B874E196B97B0816A69B874E196B97BAAF7897789123DD97789123DD 
       -iv 5B58290BFA954B894405CB4F104BB398 -in message.txt -out message.aes
# En el ejemplo de arriba, la clave simétrica de 256 bits se suministra después de -K, el IV se proporciona después del modificador -iv. A la hora de desencriptar no es necesario proporcionarlo porque queda escrito en el propio fichero encriptado.

# Ejemplo de comando openssl para descifrado:
openssl enc -aes256 -d -K 0816A69B874E196B97B0816A69B874E196B97BAAF7897789123DD97789123DD0
       -iv 5B58290BFA954B894405CB4F104BB398 -in message.aes -out message2.txt
```

### Limitaciones e Inconvenientes

- **Problema de la Distribución de Claves (*Key Exchange Problem*):** Inseguridad inherente al transmitir la clave compartida a través de un canal no seguro, lo que expone el sistema a interceptaciones (*Eavesdropping*) o ataques de intermediario (*Man-in-the-Middle*).
- **Complejidad de Escalabilidad de Claves:** Requiere una clave única por cada par de entidades que deseen establecer una comunicación confidencial. En una red de $n$ participantes, el número total de claves necesarias sigue un crecimiento cuadrático:
   *Ejemplo:* Para $n = 1000$ usuarios, el sistema requiere generar y almacenar **499.500 claves**, haciendo insostenible la gestión, almacenamiento y rotación del llavero criptográfico.

## Cifrado Asimétrico (Criptografía de Clave Pública)

Paradigma diseñado para resolver los problemas de distribución y escalabilidad del cifrado simétrico mediante el uso de **pares de claves asimétricas**, vinculadas dinámicamente mediante funciones matemáticas de un solo sentido (*trapdoor one-way functions*).

### Principios de Funcionamiento

- Complementariedad y Dualidad Criptográfica: La transformación de datos realizada por una clave del par únicamente puede ser revertida por la otra clave del mismo par.
- Asignación de Claves por Nivel de Confidencialidad:
  - Clave Pública: Accesible de manera irrestricta en el dominio público o distribuida mediante infraestructura de clave pública. Se emplea para cifrar mensajes destinados al propietario de la clave o para verificar firmas digitales.
  - Clave Privada: Secretismo absoluto y custodio exclusivo por parte del titular. Se utiliza para descifrar datos entrantes o generar firmas digitales autenticadas.

## Public Key Infrastructure (PKI)
La infraestructura en torno al cifrado asimétrico se llama PKI (Public Key Infrastructure).

El **certificado X.509v3** Es un fichero que contiene una clave pública vinculada a unos campos con información que identifican a una persona persona física u organismo. Va firmado por una AC (Autoridad de Certificación).

Una autoridad de certificación raíz es aquella que se autofirma su propio certificado. En las organizaciones que se dedican a la emisión de certificados, es muy típico el árbol de tres niveles, en la cual la CA raíz (nivel 1) firma su propio certificado y los de otras entidades subordinadas de (CAs de nivel 2), que son las que emiten certificados ya para personas físicas, jurídicas o para servicios (servidor de email, servidor web, servidor SSH...)

Los certificados se emiten para ciertos usos:
* Identificación (para un Servidor Web, por ejemplo)
* Firma
* Autenticación
* Firma de otros certificados
* Intercambio de claves (para un Servidor Web, por ejemplo)

AR Autoridad de registro. Es la encargada de verificar que la identidad de una persona u organización es verdadera.

* **AV Autoridad de Validación:** Entidades donde puede comprobarse que un certificado no ha sido revocado.
* **CRL:** Certificate Revocation List: ficheros que publican las CAs con un listado de certificados digitales que han sido revocados antes de expirar.
* **OCSP:** Online Certificate Status Protocol. Protocolo utilizado para realizar consultas de validez sobre un certificado.

Cada vez se visita un sitio HTTPs, el navegador recibe un certificado x509v3. Para comprobar su validez, el navegador puede recurrir a la lista CRL. Otra opción es consultar si el certificado no ha sido revocado utilizando el respondedor OCSP, un servicio gestionado por la propia AC.
