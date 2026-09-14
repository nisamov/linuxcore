# Teoría General de la Firma Digital

* **Cifrado (Confidencialidad):** Oculta el contenido del mensaje para que solo personas autorizadas puedan leerlo.
* **Firma Digital (Autenticidad e Integridad):** Genera una marca o prueba matemática de autoría e inalterabilidad. El mensaje sigue siendo legible (texto plano), pero viene acompañado de una prueba verificable de quién lo envió y de que no ha sido alterado.

En los algoritmos criptográficos modernos (como los basados en curvas elípticas), la firma digital y el cifrado son operaciones conceptual e implementacionalmente distintas.

## Los Dos Pilares de la Firma Digital

Para que una firma digital sea eficiente y segura en la práctica, se combinan dos tecnologías:

### Funciones Hash Criptográficas (Resumen)
Son algoritmos que toman un mensaje de cualquier tamaño y generan una "huella digital" o resumen de tamaño fijo. Tienen tres propiedades fundamentales:
- **Unidireccionalidad:** Es imposible obtener el mensaje original a partir de su resumen.
- **Efecto avalancha:** Cualquier cambio mínimo en el mensaje (incluso un solo espacio o coma) cambia por completo el resumen resultante.
- **Resistencia a colisiones:** Es técnicamente inviable encontrar dos mensajes diferentes que produzcan exactamente el mismo resumen.

### Criptografía de Clave Pública (Asimétrica)
Se basa en el uso de un par de claves vinculadas entre sí:
- **Clave Privada:** Se mantiene en secreto absoluto por el titular y se utiliza para **generar** firmas.
- **Clave Pública:** Es accesible para todo el mundo y se utiliza para **verificar** las firmas.
