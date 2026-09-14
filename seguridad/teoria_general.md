# Seguridad Informática

Área de la informaática que se preocupa de la protección de los sistemas informáticos y redes ante filtraciones o robos de información, ante el robo o daño al hardware o al software, así como de evitar la interrupción de los servicios que proveen.

- Seguridad física: Protección frente a accesos no autorizados y ataques fisicos a esquipos e instalaciones (incendio, terremoto, inundación...).
- seguridad lógica: Controlar el acceso a la información (privilegios, permisos...) así como controlar la información que entra y sale del sistema.
- Seguridad fisico/lógica: Protección en ambos frentes, ante casos generales (Robo físico y robo lógico)

## Dimensiones de la seguridad informática

### Dimensiones básicas (Trío CIA)

- Confidencialidad: La información solo ha de ser leida por el destinatario de la misma, esta seguridad se implemente mediante un cifrado (simétrico/asimétrico).
- Integridad: La información ha de llegar al destinatario sin haber sido alterada respecto a como salió del emisor, esta seguridad se implementa mediante funciones o resumen hash.
- Disponibilidad (availability): Garantiza que la información esté disponible en el momento que es solicitada, así como se debe evitar la pérdida o bloqueo de la información (ya sea por ataques, malas operaciones, desastres...).

#### Otras dimensiones

- Autenticación: Verificación de entidades, accesos, acciones... (asociado al control de recursos).
- No repudio (saber trazar quien hizo cada accion):
  - En los sistemas: Registro de acciones, así como quien las hace y cuando, ediante trazabilidad.
  - En las comunicaciones:
    - No repudio en origen: Demuestra que el mensaje recibido proviene del emisor (mediante firmas únicas).
    - No repudio en destino: Demuestra que el receptor recibió la comunicación (mediante firmas únicas).
- Control de acceso: Verificar si un determinado usuario puede realizar cierta acción sobre un objeto en el sistema, en cuyo caso, permitir la acción (implementado mediante perfiles de usuario, privilegios, permisos...).
