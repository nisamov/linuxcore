# Criptografía: Algoritmos y Funciones Hash

## Definición y Conceptos Fundamentales

Una **función hash** (o función de digestión criptográfica) es un algoritmo informático que toma un bloque de datos o secuencia de bits de cualquier tamaño y lo transforma en una cadena de caracteres de longitud fija, conocida como **resumen, *digest* o *hash***.

Su objetivo principal es representar de forma única un volumen de información mediante un identificador compacto de tamaño constante.

## Propiedades Técnicas de una Función Hash General

Para que un algoritmo de hash sea funcional y eficiente en tareas generales de computación (como en estructuras de datos o tablas hash), debe cumplir las siguientes características:

* **Determinismo:** Para una misma entrada de datos, el algoritmo debe generar de manera estricta e invariable la misma salida.
* **Uniformidad:** Los resúmenes generados deben distribuirse de manera homogénea a lo largo de todo el rango de salidas posibles, evitando que se concentren en un mismo patrón o rango de valores.
* **Eficiencia Computacional:** El tiempo que requiere la CPU para procesar los datos y calcular el hash debe ser mínimo y escalable en función del tamaño del archivo.
* **Baja Tasa de Colisiones:** Debe minimizar la probabilidad de que dos entradas diferentes generen el mismo hash de salida.
  * *Nota:* Una colisión ocurre cuando dos archivos o cadenas distintas producen exactamente el mismo resumen. Debido a que las entradas posibles son infinitas y el tamaño del resumen es fijo, las colisiones existen técnicamente, pero deben ser muy poco frecuentes.

## Requisitos de Seguridad para Funciones Hash Criptográficas

Para que una función hash sea apta en entornos de seguridad informática, autenticación y ciberseguridad, debe cumplir con el principio de **unidireccionalidad** y tres propiedades de resistencia clave:

- **Resistencia a la Preimagen (Unidireccionalidad):**
   - Dado un hash de salida, debe ser técnicamente imposible revertir el proceso para descubrir el mensaje o contenido original que lo produjo.

- **Resistencia a la Segunda Preimagen (Resistencia Débil a Colisiones):**
   - Dado un archivo o mensaje inicial conocido, debe ser imposible encontrar un segundo archivo diferente que genere exactamente el mismo hash que el primero.

- **Resistencia a Colisiones (Resistencia Fuerte a Colisiones):**
   - Debe ser imposible encontrar un par cualquiera de archivos o datos distintos que tengan un hash de salida idéntico.

## Verificación de Integridad y Vectores de Ataque

### Mecanismo de Verificación de Integridad

Para comprobar que un archivo o mensaje no ha sido alterado o dañado durante una transmisión:
- El **emisor** genera el mensaje y calcula su hash. A continuación, envía ambos elementos al destinatario.
- El **receptor** calcula nuevamente el hash del mensaje recibido y lo compara con el hash que envió el emisor.
- Si ambos valores coinciden exactamente, se confirma que el contenido no se ha corrompido ni modificado durante el trayecto.

### Vulnerabilidad: Ataque de Hombre en el Medio (Man-in-the-Middle)

Las funciones hash por sí solas garantizan la **integridad** (que no ha cambiado), pero no la **autenticidad** (quién lo envió) ni el **no repudio**.
- **Escenario de ataque:** Un atacante puede interceptar la comunicación, alterar el mensaje original, calcular el nuevo hash correspondiente al mensaje modificado y enviar ambos al receptor. El receptor asumirá que los datos son correctos porque el mensaje coincide con su hash recalculado.

- **Solución técnica:** Para evitar la suplantación se deben utilizar técnicas avanzadas como códigos de autenticación de mensajes (**HMAC**) o **firmas digitales** respaldadas por criptografía de clave pública.

## Herramientas de Línea de Comandos (CLI)

### En Microsoft Windows (PowerShell)

Se utiliza el cmdlet nativo `Get-FileHash`:

```powershell
# Cálculo del resumen mediante un algoritmo específico
Get-FileHash -Path .\archivo.ext -Algorithm MD5

# Algoritmos soportados de forma nativa:
# SHA1, SHA256, SHA384, SHA512, MD5
```

### En Sistemas Linux

En entornos Linux no existe un único comando universal con parámetros de algoritmo, sino una suite de utilidades binarias nativas incluidas en el paquete coreutils, donde cada binario implementa un algoritmo específico (`<algoritmo>sum`).

```sh
# Cálculo de hash enviando la salida por pantalla
sha256sum archivo.ext

# Guardar la suma de verificación en un archivo de texto
sha256sum archivo.ext > checksums.txt

# Verificación automática de integridad desde archivo de sumas
sha256sum -c checksums.txt

# Modo silencioso (muestra solo errores o fallos de verificación)
sha256sum -c --quiet checksums.txt
```

### Key (Clave)

* Función: Actúa como la "llave de casa". Sin la clave correcta, el algoritmo matemático no puede revertir el proceso para leer los datos originales.
* Origen: Puede ser una clave generada aleatoriamente (como en AES-256) o derivarse de una contraseña de usuario humana mediante una función de hash.

### Salt (Sal)

* Es una cadena de datos aleatorios que se añade a una contraseña antes de aplicarle un algoritmo de hashing (como SHA-512, bcrypt o Argon2).
* Función: Evita que dos contraseñas idénticas produzcan el mismo hash y protege contra ataques de Tablas Rainbow (tablas precalculadas de contraseñas).
* Propiedad: No es secreta. Se almacena en texto plano junto al hash de la contraseña.

### IV (Initialization Vector / Vector de Inicialización)

* Es un bloque de datos aleatorios o impredecibles que se combina con el primer bloque de datos al usar algoritmos de cifrado simétrico por bloques (como AES en modo CBC).
* Función: Garantiza que si cifras dos veces el mismo archivo o mensaje con la misma clave, los resultados cifrados sean completamente diferentes.
* Propiedad: No es secreto, pero debe ser único para cada sesión de cifrado o mensaje.

## Cifrado simétrico con algoritmo AES-256 usando OpenSSL

**Cifrado:**
```sh
openssl enc -aes256 -e -pass pass:1234 -in message.txt -out message.aes
```
Con este comando la clave de 256 bits de larga se deriva del password suministrado. Si se quiere visualizar la clave derivada, añade -P al final del comando (AVISO: en ese caso no se cifra nada).

**Descifrado:**
```sh
openssl enc -aes256 -d -pass pass:1234 -out message2.txt -in message.aes
```
Con los dos comandos anteriores no se requiere excesivo conocimiento de como funciona el cifrado AES. Este algoritmo de cifrado utiliza una clave y además un IV (initialization vector). Estos valores se pueden proporcionar explícitamente al comando openssl enc para que los utilice para encriptar o desencriptar.

**Ejemplo de comando openssl para cifrado:**
```sh
openssl enc -aes256 -e -K 0816A69B874E196B97B0816A69B874E196B97BAAF7897789123DD97789123DD0  -iv 5B58290BFA954B894405CB4F104BB398 -in message.txt -out message.aes
```
En el ejemplo de arriba, la clave simétrica de 256 bits se suministra después de -K, el IV se proporciona después del modificador -iv. A la hora de desencriptar no es necesario proporcionarlo porque queda escrito en el propio fichero encriptado.

**Ejemplo de comando openssl para descifrado:**
```sh
openssl enc -aes256 -d -K 0816A69B874E196B97B0816A69B874E196B97BAAF7897789123DD97789123DD0 -iv 5B58290BFA954B894405CB4F104BB398 -in message.aes -out message2.txt
```
