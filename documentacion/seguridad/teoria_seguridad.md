# Teoría General de Seguridad informática

La seguridad informática comprende las medidas destinadas a proteger los sistemas, las redes, la información y las personas frente a daños, accesos no autorizados, robos, pérdidas o interrupciones de servicio. La ciberseguridad se centra especialmente en proteger los sistemas conectados y los activos digitales frente a amenazas que se producen en el ciberespacio.

La seguridad combina medidas preventivas, de detección, respuesta y recuperación. Su objetivo no es solo evitar incidentes, sino también reducir su probabilidad e impacto y permitir que los servicios se restablezcan cuanto antes.

## Guía de lectura

Esta teoría sirve como mapa general. Para estudiarla de forma progresiva, conviene avanzar desde los objetivos de protección hasta la gestión de incidentes:

- Revisar las dimensiones de seguridad y los controles que las protegen.
- Identificar activos, amenazas, vulnerabilidades e impacto para comprender el riesgo.
- Comprender cómo se identifican y priorizan las vulnerabilidades.
- Reconocer malware y categorías de incidentes sin confundirlos entre sí.
- Consultar los documentos específicos de criptografía, autenticación, cortafuegos, redes, auditoría y análisis forense.

La seguridad es un proceso continuo: un control reduce riesgos concretos, pero no garantiza por sí solo que un incidente no ocurra.

## Ámbitos y tipos de medidas

- **Seguridad física:** protege edificios, equipos, soportes y personas frente a robos, vandalismo, accidentes y desastres. Incluye controles de acceso, vigilancia, protección contra incendios y condiciones ambientales adecuadas.
- **Seguridad lógica:** protege cuentas, datos, aplicaciones, sistemas y redes mediante medidas como autenticación, permisos, cifrado, cortafuegos y actualizaciones.
- **Seguridad de hardware:** protege los componentes físicos, por ejemplo, mediante control de acceso, mantenimiento, redundancia y protección eléctrica.
- **Seguridad de software:** reduce los defectos y accesos indebidos en sistemas operativos y aplicaciones mediante desarrollo seguro, actualizaciones y controles de acceso.
- **Seguridad de red:** protege las comunicaciones y los dispositivos de red mediante segmentación, cortafuegos, cifrado y monitorización.
- **Medidas preventivas:** buscan evitar incidentes o reducir su probabilidad, por ejemplo, aplicando actualizaciones, formando al personal y configurando correctamente los permisos.
- **Medidas de detección:** permiten identificar actividades anómalas o incidentes, por ejemplo, mediante registros y sistemas de monitorización.
- **Medidas de respuesta y recuperación:** limitan los daños y ayudan a restablecer el servicio. Incluyen planes de respuesta, copias de seguridad y procedimientos de recuperación ante desastres.

Los términos *activa* y *pasiva* pueden emplearse para clasificar medidas de distintas maneras según el contexto. No son equivalentes exactos a *preventiva* y *correctiva*.

## Dimensiones de la seguridad

### Tríada CIA

- **Confidencialidad:** solo las personas o sistemas autorizados pueden acceder a la información. El cifrado ayuda a protegerla frente a accesos no autorizados.
- **Integridad:** la información y los sistemas se mantienen correctos y no sufren modificaciones no autorizadas. Los hashes permiten detectar cambios, pero para proteger la integridad frente a una manipulación deliberada se necesitan mecanismos autenticados, como códigos MAC o firmas digitales.
- **Disponibilidad:** la información y los servicios están accesibles cuando se necesitan. La redundancia, las copias de seguridad y los planes de recuperación contribuyen a mantenerla.

### Otras dimensiones y controles

- **Autenticación:** verifica la identidad de una persona, dispositivo o servicio.
- **Control de acceso:** determina qué acciones puede realizar una entidad autenticada sobre un recurso, de acuerdo con sus permisos y privilegios.
- **Trazabilidad:** permite reconstruir qué acciones se realizaron, cuándo y, cuando es posible, quién las realizó. Los registros deben protegerse para que sean fiables.
- **No repudio:** aporta evidencias que dificultan negar la participación en una acción o comunicación. Las firmas digitales pueden ayudar a demostrar el origen e integridad de un mensaje; acreditar su recepción suele requerir mecanismos adicionales, como un acuse de recibo verificable.

## Perfiles de atacantes

- **Hacktivistas:** utilizan técnicas informáticas para promover causas políticas o sociales.
- **Usuarios de herramientas ajenas (*script kiddies*):** emplean herramientas creadas por otras personas y pueden tener conocimientos limitados. Aun así, sus acciones pueden causar daños.
- **Personas internas (*insiders*):** miembros de una organización, actuales o anteriores, que hacen un uso indebido de sus conocimientos o accesos, de forma intencionada o accidental.
- **Estados y grupos patrocinados por estados:** pueden llevar a cabo actividades de espionaje, influencia o sabotaje, además de proteger sus propias infraestructuras.
- **Ciberdelincuentes:** buscan obtener beneficios económicos. Pueden especializarse en distintas etapas del delito, como el robo o la venta de datos, la extorsión o la interrupción de servicios.

También se emplean estos términos para describir la intención o autorización de quien realiza pruebas de seguridad:

- **Black hat:** actúa sin autorización y con fines maliciosos o ilícitos.
- **White hat:** trabaja con autorización para evaluar y mejorar la seguridad.
- **Gray hat:** puede investigar o acceder a sistemas sin autorización formal, aunque no persiga necesariamente causar daño. La falta de intención maliciosa no convierte esa actividad en legal ni autorizada.

Un **cracker** es un término usado para describir a quien vulnera sistemas o protecciones, habitualmente sin autorización. En el uso cotidiano suele asociarse a actividades maliciosas, aunque el término no siempre se emplea de manera uniforme.

## Gestión de riesgos

- **Activo:** recurso que tiene valor para una organización y que se desea proteger, como información, servicios, equipos, aplicaciones o instalaciones.
- **Vulnerabilidad:** debilidad de un activo o de las medidas que lo protegen que podría ser aprovechada. Puede deberse a errores de software, configuraciones inadecuadas, credenciales débiles, falta de actualizaciones o errores humanos.
- **Amenaza:** circunstancia, evento o agente que puede causar daño a un activo. Una amenaza puede aprovechar una vulnerabilidad, aunque no toda amenaza llega a materializarse.
- **Impacto:** consecuencias que tendría un incidente sobre los activos o la organización, por ejemplo, pérdida de datos o interrupción de un servicio.
- **Probabilidad:** posibilidad de que una amenaza se materialice en unas circunstancias determinadas.
- **Riesgo:** combinación de la probabilidad de que ocurra un incidente y la gravedad de sus consecuencias. En algunos métodos se representa como el producto de probabilidad e impacto, pero la evaluación concreta depende de la metodología utilizada.

## Origen y clasificación de las vulnerabilidades

Una vulnerabilidad es una debilidad de diseño, implementación, configuración u operación que puede contribuir a un incidente. No toda vulnerabilidad es un error de programación. Según su origen, puede deberse a:

- **Diseño o implementación:** validación insuficiente de entradas, errores de memoria o controles de autorización incompletos.
- **Configuración y operación:** servicios innecesarios, permisos excesivos, parámetros inseguros o componentes sin actualizar.
- **Organización y procesos:** falta de inventario, responsabilidades poco claras, formación insuficiente o ausencia de pruebas de recuperación.

Según su ámbito, se clasifican en:

- **Físico:** por ejemplo, salas de sistemas poco seguras a las que puede acceder alguien con intenciones maliciosas.
- **Organizativo:** falta de personal cualificado, falta de controles, etc.
- **Tecnológico:** software de sistema sin actualizar, falta de control de aplicaciones (por ejemplo, permitir instalar cualquier software en los equipos de los puestos de trabajo), falta de supervisión de incidentes, redes sin proteger, mal segmentadas o sin redundancia, y mal uso del correo electrónico (como no emplear CCO) o de la navegación.

## Clasificación de las amenazas

Una amenaza es una circunstancia, evento o agente con capacidad de causar daño. Puede aprovechar una vulnerabilidad, pero también puede materializarse por accidente o por un fallo técnico. Según su origen, puede ser:

- **Deliberadas:** robo, virus, sabotaje, interceptación, alteración de datos.
- **Naturales o ambientales:** inundación, terremoto, incendio, corte de corriente.
- **Accidentales:** errores humanos.
- **Fallos técnicos:** mal funcionamiento de un equipo.

Si una amenaza se materializa, puede causar daños o pérdidas que afecten a la confidencialidad y a la integridad de la información, o a la disponibilidad de los sistemas.

## Vulnerabilidades, pruebas y código de explotación

Una **vulnerabilidad de día cero** (*zero-day*) es una vulnerabilidad que todavía no cuenta con una solución disponible para quienes administran o mantienen el sistema afectado. El término se refiere a la falta de tiempo o de una corrección eficaz; no implica necesariamente que nadie conozca la vulnerabilidad.

Una **prueba de penetración** (*pentest*) es una evaluación de seguridad autorizada y delimitada. Se realiza con un alcance, unas reglas y unos objetivos acordados para identificar debilidades y valorar su impacto.

Un **exploit** es código, una técnica o una herramienta que aprovecha una vulnerabilidad. Según el caso, podría permitir, por ejemplo, ejecutar código, elevar privilegios, provocar una denegación de servicio o acceder a información. Un exploit no es necesariamente malware: puede utilizarse en pruebas autorizadas, aunque también puede formar parte de un ataque.

La **carga útil** (*payload*) es la acción o el contenido que se ejecuta o entrega después de aprovechar una vulnerabilidad. Un mismo exploit puede asociarse a distintas cargas útiles. No todos los exploits entregan malware.

El **malware** es software creado para realizar acciones no autorizadas o perjudiciales, como robar información, alterar datos, interferir con un sistema o impedir el acceso a recursos. Puede llegar a un equipo mediante distintas vías, entre ellas la explotación de vulnerabilidades o el engaño a una persona mediante ingeniería social.

## Identificación y valoración de vulnerabilidades

**CVE** (*Common Vulnerabilities and Exposures*) es un sistema de identificadores públicos para vulnerabilidades conocidas. Un identificador tiene el formato `CVE-AAAA-NNNN`, donde `AAAA` indica el año y la secuencia numérica puede tener cuatro o más dígitos. MITRE gestiona el programa CVE y coordina la asignación de identificadores junto con organizaciones autorizadas. MITRE es una organización estadounidense sin ánimo de lucro. El sitio web oficial del programa (cve.org) lista las vulnerabilidades descubiertas y aceptadas, con enlaces a fuentes que ofrecen más información y a los parches o soluciones de seguridad aportados para mitigarlas.

La **NVD** (*National Vulnerability Database*) es una base de datos mantenida por el NIST estadounidense. Incluye información y análisis sobre vulnerabilidades identificadas mediante CVE. Un identificador CVE sirve para referirse a una vulnerabilidad; por sí solo no expresa su gravedad.

El **CVSS** (*Common Vulnerability Scoring System*) es un sistema para describir y puntuar la gravedad técnica de una vulnerabilidad. La puntuación no equivale por sí sola al riesgo real para una organización, que también depende del contexto, la exposición y el valor de los activos afectados.

En **CVSS 3.1**, el vector base puede expresarse, por ejemplo, como `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H`. Sus métricas son:

- **AV (Attack Vector, vector de ataque):** contexto desde el que se puede explotar la vulnerabilidad: `N` (Network, a través de una red), `A` (Adjacent, desde una red adyacente), `L` (Local, con acceso local al sistema) o `P` (Physical, con acceso físico al dispositivo).
- **AC (Attack Complexity, complejidad del ataque):** condiciones adicionales necesarias para explotar la vulnerabilidad: `L` (Low, bajas) o `H` (High, altas).
- **PR (Privileges Required, privilegios requeridos):** nivel de privilegios que debe tener el atacante antes de la explotación: `N` (None, ninguno), `L` (Low, bajos) o `H` (High, altos).
- **UI (User Interaction, interacción del usuario):** indica si la explotación requiere que otra persona realice alguna acción: `N` (None, no se requiere) o `R` (Required, se requiere).
- **S (Scope, ámbito):** indica si el impacto se limita a la autoridad de seguridad del componente vulnerable (`U`, Unchanged) o afecta a recursos fuera de ella (`C`, Changed).
- **C, I y A:** impacto en la confidencialidad (*Confidentiality*), la integridad (*Integrity*) y la disponibilidad (*Availability*). Cada métrica puede ser `H` (High, alto), `L` (Low, bajo) o `N` (None, ninguno).

## Incidentes y categorías de amenazas

Un **incidente de seguridad** es un evento que afecta o puede afectar a la confidencialidad, integridad o disponibilidad de la información o los servicios. Puede ser deliberado, accidental o consecuencia de un fallo técnico. Un **ciberataque** es un incidente deliberado que utiliza medios digitales; no todos los incidentes son ataques ni todos los ataques llegan a tener éxito.

### Tipos de ciberataque según su efecto

- **Interrupción:** afecta a la disponibilidad. El recurso deja de estar accesible.
- **Intercepción:** afecta a la confidencialidad. Un tercero accede a información que no le corresponde.
- **Modificación:** afecta a la integridad. Un tercero altera la información o el sistema.
- **Fabricación:** afecta a la autenticación. Un tercero introduce elementos falsos haciéndolos pasar por legítimos.

### Ciclo de vida de un incidente

Los incidentes no siguen siempre una secuencia única. Para fines defensivos, se pueden analizar mediante estas etapas generales:

- **Preparación y exposición:** existen activos, configuraciones o procesos que podrían quedar expuestos. El inventario, el endurecimiento y la gestión de vulnerabilidades reducen el riesgo.
- **Acceso o evento inicial:** una debilidad, un error humano, una cuenta comprometida o un fallo técnico puede iniciar el incidente.
- **Efecto sobre los activos:** puede haber acceso indebido, cambios no autorizados, pérdida de datos o interrupción del servicio.
- **Detección y análisis:** las alertas, los registros y los informes permiten determinar qué sistemas están afectados y con qué nivel de confianza.
- **Contención, recuperación y mejora:** se limita el impacto, se restaura desde fuentes confiables y se corrigen las causas. La respuesta debe preservar evidencias cuando sea necesario.

Las guías de *footprinting* y *fingerprinting* del repositorio describen conceptos de reconocimiento. Cualquier evaluación activa debe tener autorización escrita, alcance definido, ventanas de ejecución y límites de impacto; no se deben probar sistemas ajenos.

## Amenazas y tipos de ataque

- **Virus:** malware que se inserta en archivos o programas y se propaga cuando se ejecuta el elemento infectado.
- **Gusano:** malware capaz de propagarse automáticamente entre sistemas, normalmente a través de una red, sin tener que adjuntarse a un archivo anfitrión.
- **Spyware:** software que recopila información o supervisa la actividad sin el conocimiento o consentimiento adecuado de la persona afectada.
- **Ransomware:** malware que cifra o bloquea datos y exige un pago. Pagar no garantiza recuperar la información.
- **Cryptojacking:** uso no autorizado de los recursos de un dispositivo para minar criptomonedas.
- **Denegación de servicio (DoS):** acción que busca impedir o degradar el acceso a un sistema o servicio. Si se origina desde numerosos sistemas, se denomina denegación de servicio distribuida (DDoS).
- **Intermediario en la comunicación (MITM, *Man in the Middle*):** interceptación o posible modificación de comunicaciones entre partes que creen comunicarse directamente.
- **Phishing:** engaño que suplanta a una entidad de confianza para inducir a la víctima a revelar información, abrir contenido o realizar una acción. La suplantación dirigida a una organización o persona concreta se conoce como *spear phishing*.
- **Inyección SQL:** vulnerabilidad que aparece cuando una aplicación incorpora datos no confiables en una consulta SQL sin tratarlos de forma segura. Puede permitir consultar o modificar datos de manera no autorizada.
- **Suplantación de sitios web:** creación de páginas que imitan servicios legítimos para engañar a las personas, por ejemplo, para que introduzcan sus credenciales.
- **Ingeniería social:** manipulación de personas para obtener información, inducir acciones o conseguir acceso no autorizado.
- **Ataque de fuerza bruta:** intento sistemático de adivinar una contraseña o clave probando muchas combinaciones.
- **Ataque de diccionario:** intento de adivinar credenciales probando palabras o combinaciones frecuentes.
- **Explotación de día cero:** aprovechamiento de una vulnerabilidad para la que todavía no hay una corrección disponible.
- **Puerta trasera:** mecanismo oculto o no autorizado que permite volver a acceder a un sistema o eludir sus controles habituales.
- **Bomba lógica:** código que se activa cuando se cumple una condición o llega un momento determinado.
- **Flooding:** envío de una cantidad elevada de solicitudes o tráfico para consumir recursos y degradar o interrumpir un servicio. Puede formar parte de una denegación de servicio.

### Categorías de amenazas y controles defensivos

- **Exposición de información:** puede facilitar la selección de objetivos. Se reduce limitando la publicación de datos y revisando periódicamente los activos expuestos.
- **Compromiso de cuentas:** incluye el abuso de credenciales, la reutilización de contraseñas y la ingeniería social. MFA, contraseñas únicas, límites de acceso y alertas reducen el riesgo.
- **Abuso de protocolos o servicios de red:** puede afectar a la confidencialidad o disponibilidad. La segmentación, el cifrado, las actualizaciones y la monitorización son controles relevantes.
- **Interrupción del servicio:** incluye fallos, errores operativos y denegación de servicio. La capacidad adecuada, la redundancia y los planes de continuidad ayudan a limitar su impacto.
- **Malware:** incluye, entre otros, virus, gusanos, spyware y ransomware. Las copias aisladas, el control de aplicaciones, las actualizaciones y la respuesta a incidentes son medidas defensivas.
- **Manipulación o fraude:** puede usar suplantación e ingeniería social. La verificación por un canal independiente y los procesos de aprobación reducen errores.

### Suplantación de IP

La **suplantación de IP** (*IP spoofing*) consiste en falsificar la dirección de origen de un paquete. La dirección que aparece como origen no prueba quién generó el tráfico, por lo que no debe utilizarse como único mecanismo de autenticación. Los filtros de entrada y salida, la validación en los límites de red y protocolos autenticados ayudan a reducir los usos indebidos.

Una vulnerabilidad es una debilidad que puede ser aprovechada; no es, por sí misma, un ataque. Del mismo modo, no todas las amenazas son malware ni todos los incidentes tienen origen malicioso.

## Gestión defensiva y mejora continua

Un programa básico de seguridad mantiene un inventario de activos, asigna responsables, aplica actualizaciones con pruebas proporcionales al riesgo, limita privilegios, registra eventos relevantes y comprueba periódicamente las copias de seguridad. Las medidas deben priorizarse según el impacto para el negocio y revisarse cuando cambien los sistemas o las amenazas.

La evaluación de seguridad requiere autorización explícita y un alcance documentado. Los hallazgos deben comunicarse de forma responsable, protegerse como información sensible y acompañarse de medidas de corrección verificables. Para profundizar, se recomienda consultar [la teoría de OSINT](osint/teoria_osint.md), [el análisis forense](forense/teoria_forense.md), las secciones de [criptografía](criptografia/cifrado/teoria_cifrado.md) y [cortafuegos](firewall/).
