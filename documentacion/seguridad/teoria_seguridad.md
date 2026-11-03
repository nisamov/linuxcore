# Teoría General de Seguridad informática

La seguridad informática comprende las medidas destinadas a proteger los sistemas, las redes, la información y las personas frente a daños, accesos no autorizados, robos, pérdidas o interrupciones de servicio. La ciberseguridad se centra especialmente en proteger los sistemas conectados y los activos digitales frente a amenazas que se producen en el ciberespacio.

La seguridad combina medidas preventivas, de detección, respuesta y recuperación. Su objetivo no es solo evitar incidentes, sino también reducir su probabilidad e impacto y permitir que los servicios se restablezcan cuanto antes.

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

Una vulnerabilidad es un error en el desarrollo o en la gestión de los sistemas. Según su origen, puede deberse a:

- **Fallos en la implementación de tecnologías (administración):** por ejemplo, usar Telnet en lugar de SSH.
- **Fallos de configuración (administración):** instalar servicios que no se van a usar y que pueden contener debilidades, o dejar el software con su configuración por defecto.
- **Fallos de diseño (desarrollo):** desbordamientos de búfer, inyección de código, etc.

Según su ámbito, se clasifican en:

- **Físico:** por ejemplo, salas de sistemas poco seguras a las que puede acceder alguien con intenciones maliciosas.
- **Organizativo:** falta de personal cualificado, falta de controles, etc.
- **Tecnológico:** software de sistema sin actualizar, falta de control de aplicaciones (por ejemplo, permitir instalar cualquier software en los equipos de los puestos de trabajo), falta de supervisión de incidentes, redes sin proteger, mal segmentadas o sin redundancia, y mal uso del correo electrónico (como no emplear CCO) o de la navegación.

## Clasificación de las amenazas

Una amenaza es alguien o algo que puede explotar una vulnerabilidad para obtener o impedir el acceso a un activo, o para comprometerlo. Según su origen, pueden ser:

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

## Ciberataques

Un **ciberataque** es una maniobra ofensiva de explotación deliberada de una vulnerabilidad con el objetivo de tomar el control de un sistema, desestabilizarlo o aprovecharse de él, con la finalidad última de robar información o hacer daño a su objetivo. Utiliza código malicioso o exploits para comprometer aplicaciones.

### Tipos de ciberataque según su efecto

- **Interrupción:** afecta a la disponibilidad. El recurso deja de estar accesible.
- **Intercepción:** afecta a la confidencialidad. Un tercero accede a información que no le corresponde.
- **Modificación:** afecta a la integridad. Un tercero altera la información o el sistema.
- **Fabricación:** afecta a la autenticación. Un tercero introduce elementos falsos haciéndolos pasar por legítimos.

### Fases de un ataque

**Footprinting:** consiste en recopilar información sobre la víctima. Se suele hacer en fuentes abiertas, habitualmente Internet (buscadores, whois, etc.), y también pueden emplearse técnicas de ingeniería social. La información obtenida se analiza después para encontrar vulnerabilidades.

**Fingerprinting:** emplea la información de la fase anterior para descubrir fallos de seguridad en la infraestructura. Se lleva a cabo mediante escaneos o exploración de la red objetivo para descubrir vulnerabilidades en los dispositivos. Una herramienta típica de esta fase es el escáner de puertos.

**Intrusión y explotación:** se utilizan las vulnerabilidades descubiertas con el objetivo de penetrar y comprometer el sistema para causar algún perjuicio.

**Mantener el acceso:** tras una intrusión, hay que mantener la vía abierta sin ser descubierto, para seguir explorando el sistema o acceder a otros equipos de la red. Se usan herramientas como puertas traseras (*backdoors*) y *rootkits*. En otros tipos de ataque, como la denegación de servicio, esta fase no se lleva a cabo.

**Borrar huellas:** busca pasar desapercibido para continuar en el sistema sin ser detectado y no ser identificado mediante técnicas de análisis forense. Se logra ocultando las direcciones IP y MAC del atacante y editando los registros (*logs*) del sistema que contienen evidencias del ataque.

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

### Categorías de ataques

- **Ataques para obtener información (*information gathering*):** primer paso de una auditoría de caja negra o de un ataque. Se recopila información de la organización mediante footprinting (búsqueda pasiva, sin interactuar con sus sistemas) y fingerprinting (búsqueda activa, con interacción).
- **Ataques a nivel de red:** atacan protocolos o mecanismos de la capa de red, como los protocolos de enrutamiento (RIP, OSPF, BGP), el túnel ICMP, el secuestro de sesión (*session hijacking*), el enrutamiento desde origen (*source routing*), los mensajes ICMP Redirect y los ataques basados en fragmentación IP (*Tiny Fragment* y *Teardrop*).
- **Ataques de monitorización:** el *sniffing* consiste en que una máquina escuche el tráfico de red aunque los mensajes no vayan dirigidos a ella. La suplantación de un servidor DHCP engaña a otros equipos para que crean que el atacante es su puerta de enlace.
- **Ataques de autenticación:** intentan obtener credenciales o eludir la autenticación, por ejemplo mediante fuerza bruta o diccionario.
- **Ataques de denegación de servicio:** buscan impedir o degradar el acceso a un servicio.
- **Ingeniería social:** manipulan a las personas para obtener información o accesos.
- **Malware:** software malicioso como virus, gusanos, spyware o ransomware.

### Suplantación de IP

El **IP spoofing** consiste en falsear la dirección IP de origen de los paquetes para hacerse pasar por otro sistema. Su principal dificultad es mantener la dirección falseada de forma efectiva: para que tenga éxito, normalmente hay que dejar fuera de juego momentáneamente al sistema suplantado (por ejemplo, con una denegación de servicio), ya que, si no, este respondería e interferiría en la comunicación.

Una vulnerabilidad es una debilidad que puede ser aprovechada; no es, por sí misma, un ataque. Del mismo modo, no todas las amenazas son malware ni todos los incidentes tienen origen malicioso.
