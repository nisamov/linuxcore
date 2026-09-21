# Tipos de Cifrado

## Cifrado Simétrico (Criptografía de Clave Privada)

Arquitectura criptográfica basada en el uso de una **única clave compartida** (*symmetric key*) tanto para la fase de cifrado como para la de descifrado.

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
