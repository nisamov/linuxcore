# Auditoría autorizada de contraseñas con Hashcat

Hashcat es una herramienta de recuperación de contraseñas a partir de hashes. En seguridad defensiva puede ayudar a evaluar, dentro de un laboratorio aislado y con autorización expresa, si las políticas de contraseñas resisten ataques de adivinación. Este documento describe el proceso de gobierno y protección; no incluye instrucciones para recuperar credenciales reales.

## Alcance y autorización

Antes de una auditoría, la persona responsable debe aprobar por escrito:

- Los sistemas, cuentas y conjuntos de datos incluidos y excluidos.
- El objetivo de la prueba, la fecha, la duración y los recursos de cómputo permitidos.
- Quién custodiará los hashes, los resultados y los informes, y cuándo se eliminarán.
- El procedimiento de interrupción y los contactos para incidentes.

La auditoría debe utilizar únicamente hashes sintéticos generados para el laboratorio o datos cuya evaluación esté autorizada. Un hash de contraseña debe tratarse como una credencial: no debe subirse a servicios públicos ni incluirse sin protección en incidencias, repositorios o informes.

## Preparación segura del laboratorio

- El equipo de prueba debe mantenerse aislado de las redes y cuentas de producción.
- Deben utilizarse datos ficticios; no deben reutilizarse contraseñas personales ni de usuarios reales.
- El formato y el algoritmo de los hashes deben confirmarse mediante documentación oficial, sin inferirlos únicamente por su apariencia.
- El uso de CPU/GPU, la temperatura, la duración y el almacenamiento deben mantenerse dentro de los límites aprobados.
- La herramienta y los controladores deben obtenerse de fuentes oficiales; sus versiones deben quedar documentadas.

## Interpretación y respuesta

Una coincidencia indica que una contraseña de prueba fue recuperable bajo las condiciones del ensayo; no demuestra que todas las cuentas sean vulnerables ni mide por sí sola el riesgo de una organización. El informe debe registrar el alcance, el algoritmo de almacenamiento, las condiciones del laboratorio, las limitaciones y los resultados agregados. Los secretos recuperados no deben divulgarse.

Se recomienda priorizar mitigaciones como contraseñas largas y únicas, gestores de contraseñas, autenticación multifactor (MFA), limitación de intentos en servicios en línea y almacenamiento con funciones de derivación de contraseñas adecuadas, sal única y parámetros de coste actualizados. La política no debe basarse únicamente en reglas arbitrarias de composición.

## Cierre

Al finalizar, la persona responsable debe revocar cualquier dato temporal, eliminar hashes y resultados según el plan aprobado y verificar que no queden copias en historiales, sincronización o respaldos. También debe documentar las medidas correctivas y confirmar su aplicación por un canal autorizado.
