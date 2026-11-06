# TLS: certificados y cadena de confianza

TLS (*Transport Layer Security*) protege comunicaciones entre aplicaciones mediante cifrado, integridad y autenticación del servidor; la autenticación mutua puede identificar también al cliente. HTTPS es HTTP protegido por TLS. TLS no garantiza que el sitio sea honesto ni protege datos después de que la aplicación los descifra.

## Certificados y confianza

Un certificado X.509 vincula una identidad —por ejemplo, un nombre DNS— con una clave pública y contiene un periodo de validez y usos previstos. Una autoridad certificadora (CA) firma certificados para que un cliente pueda construir una cadena hasta una raíz de confianza instalada en su almacén.

Al validar un servidor, el cliente comprueba, entre otros aspectos, la cadena de firmas, el nombre solicitado, las fechas, el uso de la clave y la política de revocación disponible. Un certificado autofirmado puede ser útil en un laboratorio, pero no obtiene confianza pública automáticamente. La validación no debe desactivarse para «hacer funcionar» una conexión.

## Parámetros de configuración segura

- Los protocolos y bibliotecas TLS deben mantenerse en versiones soportadas y actualizadas; SSL y las versiones obsoletas de TLS deben deshabilitarse.
- Las suites criptográficas deben seguir las recomendaciones de la plataforma, con claves y algoritmos vigentes.
- Las claves privadas deben protegerse con permisos mínimos, copias controladas y rotación planificada.
- La renovación debe automatizarse y deben monitorizarse las fechas de expiración y los errores de cadena.
- El servidor debe presentar el nombre correcto y la cadena intermedia completa requerida por los clientes.
- En servicios internos, la CA privada debe gestionarse con distribución y revocación controladas.

Las opciones concretas dependen del servidor web, del sistema operativo y de la biblioteca TLS. La configuración debe ajustarse a las guías de seguridad vigentes del fabricante y probarse con los clientes que realmente utilizan el servicio.

## Renovación, revocación y diagnóstico

Una renovación reemplaza el certificado antes de su vencimiento; la clave puede cambiar según la política. Si una clave privada se expone o un certificado deja de ser confiable, el administrador debe revocarlo mediante los mecanismos de la CA y desplegar uno nuevo. CRL y OCSP son mecanismos de consulta de revocación, aunque el comportamiento depende de clientes y servicios.

El inventario debe registrar quién administra los certificados, dónde se guardan las claves, qué nombres cubren, cuándo expiran y cómo se restaura el servicio. Las claves privadas no deben incluirse en repositorios, capturas, tickets ni ejemplos públicos.
