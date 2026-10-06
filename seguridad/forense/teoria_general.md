# Análisis Forense Informático

Desgraciadamente no siempre las medidas tomadas para evitar amenazas son eficaces. Cuando ha tenido lugar un ciberataque se hace necesario recabar toda la información posible sobre el mismo con la finalidad de determinar el origen del ataqué y qué sucedió, con el propósito de poder evaluar los daños sufridos, tratar evitar que vuelva a suceder y/o de que sus consecuencias sean menos severas.

El análisis forense consta de las siguientes fases:

## Identificación y Preparación

En esta fase inicial, el objetivo es determinar el alcance del caso y los sistemas o dispositivos que contienen la información relevante (evidencia digital).

* **Estudio del caso:** Conocer qué ha ocurrido, quiénes son los afectados y los posibles dispositivos implicados (ordenadores, servidores, móviles, correos electrónicos, cloud, etc.).
* **Aseguramiento de la escena:** Aplicar protocolos para garantizar que la evidencia no se altere.
* **Planificación:** Definir las herramientas y los recursos necesarios para la investigación.

## Adquisición y Preservación

Esta es una de las fases más críticas para garantizar la validez de la prueba.

* **Adquisición:** Se realiza una copia bit a bit (imagen forense o clonado) del dispositivo original para trabajar siempre sobre la copia y dejar el original intacto. Esto incluye archivos borrados y espacio no asignado.
* **Preservación:** Se utilizan funciones hash (como MD5 o SHA-256) para generar una "huella digital" de la evidencia adquirida. Si el hash de la imagen forense coincide con el del original, se demuestra que la copia es idéntica y que la evidencia no ha sido alterada.
* **Cadena de Custodia:** Se documenta detalladamente el lugar, fecha y personas que han manipulado la evidencia en cada momento.

## Análisis de la evidencia

El experto forense examina la copia de la evidencia digital utilizando herramientas especializadas.

* **Búsqueda y Recuperación:** Se buscan archivos clave, se analizan los logs (registros de actividad), el historial, los metadatos y se intenta recuperar archivos eliminados.
* **Línea de Tiempo (Timeline):** Se reconstruye la secuencia cronológica de los eventos para entender qué sucedió, cuándo y en qué orden.
* **Correlación de Datos:** Se establecen patrones y relaciones entre las diferentes piezas de evidencia para construir una narrativa clara del incidente.

## Documentación e informe

El proceso culmina con la presentación de los hallazgos de forma clara y comprensible.

* **Elaboración del Informe:** Se documenta la metodología empleada, las herramientas utilizadas, las pruebas encontradas y las conclusiones que responden a las preguntas iniciales del caso.
* **Presentación y Ratificación:** En un contexto legal, el perito informático puede tener que ratificar y defender el informe y sus conclusiones ante un tribunal, asegurando que el procedimiento fue sólido y científico.
