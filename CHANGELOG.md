<p align="center">
  <img src=".github/media/top.png" alt="LinuxCore Header" width="100%">
</p>

<div align="center">
  <h1>Registro de Cambios | Linux Core</h1>

<p>Todos los cambios relevantes de <b>Linux Core</b> se documentan en este archivo. Las versiones más recientes aparecen primero y cada una indica su fecha (año-mes-día).</p>
<p>Los cambios de cada versión se agrupan en <b>Añadido</b>, <b>Cambiado</b>, <b>Corregido</b> y <b>Eliminado</b>.</p>
</div>

## [`00-00-01-10`] - 2026-10-30

## Añadido

- Agregada la configuración `documentacion/redes/dhcp/configuracion/dhcpd.conf`
- Creado y documentados `INSERTS` en `documentacion/bases_de_datos/mysql_mariadb/inserciones.md`

## Cambiado

- El archivo `documentacion/bases_de_datos/mysql_mariadb/creador_roles_y_permisos.md` ha sido renombrado a `documentacion/bases_de_datos/mysql_mariadb/roles_y_permisos.md`

---

## [`00-00-01-09`] - 2026-10-29

## Añadido

- Creada el archivo guía `documentacion/infraestructura/contenedores/docker/creacion_dockerfile.md`.

## Corregido

- Actualizadas dependencias de `docker/Dockerfile` por advertencias de seguridad con 'severidad [8]'.

## Cambiado

- Contenido teórico actualizado en `documentacion/infraestructura/contenedores/docker/teoria_docker.md`.

---

## [`00-00-01-08`] - 2026-10-28

## Añadido

- Contenido en espera por ser implementado en `TODO.md`.
- Agregada nueva extensión teórica en `documentacion/infraestructura/contenedores/docker/teoria_docker.md`.

## Corregido

- Contenido sobrante general en el repositorio `./*`.
- Corrección general de formato en múltiples archivos, cumpliendo con `.github/CONTRIBUTING.md`.

## Cambiado

- Actualizado contenido de archivo `documentacion/infraestructura/contenedores/docker/instalacion.md`

---

## [`00-00-01-07`] - 2026-10-26

## Eliminado

- Enlaces rotos de `README.md`
- `foremost.json` de `json/comandos/seguridad` por contenido duplicado (contenia un comando duplicado).

## Corregido

- Corregidas las rutas de las imágenes de cabecera y pie en `.github/CONTRIBUTING.md`, `.github/CODE_OF_CONDUCT.md` y `.github/SECURITY.md`.
- Actualizadas las imágenes de `.github/AGRADECIMIENTOS.md` para cargarlas desde las URL directas de GitHub.

---

## [`00-00-01-06`] - 2026-10-26

## Añadido

- Nuevo comando `json/comandos/seguridad/foremost.json` relacionado directamente con `documentacion/seguridad/forense/herramientas/foremost.md`.
- Creación de ruta `documentacion/seguridad/pentesting/redes`.
- Nueva herramienta en `documentacion/seguridad/forense/herramientas/hping3.md` (Investigación de red y puertos, relacionado con auditorias y seguridad).
- Nueva herramienta en `documentacion/seguridad/forense/herramientas/nmap.md`.
- Agregado archivo `documentacion/seguridad/pentesting/redes/hping3.md` en la nueva ruta mencionada (`documentacion/seguridad/pentesting/redes`).
- Agregado archivo `documentacion/seguridad/pentesting/redes/nmap.md` en la nueva ruta mencionada (`documentacion/seguridad/pentesting/redes`).
- Creación de ruta `documentacion/seguridad/osint/herramientas` y documentación de contenido `holehe.md`, `owasp_amass.md`, `theharvester.md`, `maigret.md` y `sherlock.md` junto a la creación de la teoría general que les acompaña `documentacion/seguridad/osint/teoria_osint.md`.
- Creación de archivo `TODO.md` como lista de espera para contenido pendiente.

## Eliminado

- Retirado el documento `documentacion/seguridad/forense/herramientas/logrotate.md` al no corresponder a dicha sección.
- Eliminado el documento  `documentacion/seguridad/osint/en.espera` por haber cumplido su función hasta la fecha.

## Cambiado

– Asignación de decoración estandar en `ACCESSIBILITY.md`, `.github/CONTRIBUTING.md`, `.github/CODE_OF_CONDUCT.md` y `.github/SECURITY.md`

---

## [`00-00-01-05`] - 2026-10-26

### Cambiado

- Migrados los métodos de instalación de 270 fichas en `json/comandos/` a los valores definidos por el esquema.

### Corregido

- Corregidos los `id` de `json/comandos/seguridad/apparmor_status.json`, `json/comandos/monolinea/limpiar_historial_de_terminal_de_sesion_actual.json` y `json/comandos/monolinea/limpieza_residual.json` para que coincidan con sus nombres de archivo.

---

## [`00-00-01-04`] - 2026-10-26

### Añadido

- Plantilla de incidencia `.github/ISSUE_TEMPLATE/nuevo_comando.md` para proponer comandos o corregir fichas.
- `.github/ISSUE_TEMPLATE/config.yml`: desactiva las incidencias en blanco y enlaza la guía de contribución, la política de seguridad y la accesibilidad.
- Comprobaciones en `.github/scripts/validate_commands.py`: el `id` debe coincidir con el nombre del archivo, la categoría con la carpeta y no puede haber `id` repetidos.
- Avisos de seguridad en `.github/scripts/validate_commands.py` para comandos destructivos con nivel `bajo` o `medio`, sin advertencias o sin confirmación.
- Campo opcional `instalacion.notas` en `.github/schemas/comando.schema.json`.
- Nueva distribución `json/distribuciones/lunariaos.json` (LunariaOS).

### Cambiado

- Reescrito `.github/CONTRIBUTING.md`: flujo paso a paso, reglas por tipo de aporte (documentación, fichas de comandos y distribuciones).
- Rehecho `README.md`: inicio rápido, consultas de ejemplo con `jq`, estructura de las fichas de comandos, categorías, rutas de aprendizaje recomendadas, estructura del repositorio, automatización y documentos del proyecto.
- Mejoradas la plantilla de Pull Request y las plantillas de incidencias `correccion_documentacion.md`, `documentacion.md` y `critico.md`.
- `instalacion.metodo` pasa a un conjunto cerrado de valores (`gestor_paquetes`, `incluido_en_sistema`, `builtin_shell`, `compilacion` y `no_estandar`). El texto anterior se conserva en `instalacion.notas`.
- `.github/workflows/commands_db_gen.yaml` solo publica desde `main`, valida en Pull Requests sin publicar y guarda `.github/db/` en el repositorio.

### Corregido

- `.github/scripts/validate_markdown.py` ya no marca como rotos los enlaces con ancla, ignora los bloques de código, valida también las imágenes y muestra el número de línea.
- Corregidos los `id` de `apparmor_status` (antes `apparmor`), `limpiar_historial_de_terminal_de_sesion_actual` (antes con una `l` de más) y `limpieza_residual` (antes `limpieza_residual_linea_produccion`).
- `documentacion/redes/ssh/uso.md` no estaba enlazado en `README.md`.
- Corrección general del fichero `CHANGELOG` y su formato.

### Eliminado

- Retirada del `README.md` y el repositorio general el GIF de vista previa sobre `linuxcore.site`.

---

## [`00-00-01-03`] - 2026-10-23

### Añadido

- `.github/dependabot.yml` con revisión mensual de las acciones de GitHub.
- `ACCESSIBILITY.md` con los criterios de accesibilidad del proyecto.

### Cambiado

- Ampliado y reorganizado `documentacion/bases_de_datos/mysql_mariadb/usuarios_y_permisos.md`.

---

## [`00-00-01-02`] - 2026-10-23

### Añadido

- Directorio `docker/`.
- Workflow `.github/workflows/docker-publish.yaml` para publicar la imagen en `ghcr.io`.

### Cambiado

- Optimizado el `Dockerfile` y movido a `docker/Dockerfile`.
- Nueva entrada en `README.md` que referencia el contenedor.
- Cambio de insignias (adaptación a cambios recientes).

---

## [`00-00-01-01`] - 2026-10-23

### Cambiado

- Movido el `Dockerfile` a la raíz del repositorio.

### Eliminado

- Eliminado el workflow relacionado con el `Dockerfile`.

---

## [`00-00-01-00`] - 2026-10-22

### Añadido

- Contenedor Docker (`.github/dockerfile`) y workflow de publicación automática (`.github/workflows/docker-publish.yml`).

---

## [`00-00-00-06`] - 2026-10-22

### Corregido

- Corregido el enlace de `README.md` a `teoria_borg.md`.

### Eliminado

- Eliminada la referencia a un archivo inexistente, `diagnosticar_ssh.md`.

---

## [`00-00-00-05`] - 2026-10-22

### Añadido

- Creado `documentacion/redes/ssh/uso.md` con comandos y casos de uso de `ssh`.

### Cambiado

- Ediciones generales en `README.md`:
  - Redireccionamiento a "linuxcore.site".
  - Diseño y formato de las insignias.
  - Formato de colaboradores.
- Reescrita la teoría de `ssh` en `documentacion/redes/ssh/teoria_ssh.md`.
- Ampliada y revisada la teoría de seguridad en `documentacion/seguridad/teoria_seguridad.md`.
- Corrección y ampliación de apuntes en `documentacion/programacion/php/variables.php`.

### Corregido

- Corregido el enlace roto de `README.md` a `documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md`.
- Corregido el enlace de contribuciones en `README.md` y `.github/CONTRIBUTING.md`.

### Eliminado

- Eliminada la sección `documentacion/seguridad/ofensiva/`.
- Retirados los nombres de las entidades que no deseaban aparecer en `.github/AGRADECIMIENTOS.md`.

---

## [`00-00-00-04`] - 2026-10-22

### Añadido

- Nueva distribución `Raspbian` en `json/distribuciones/raspbian.json`.
- Comando `pinky` en `json/comandos/usuarios/pinky.json`.

### Cambiado

- Revertido el cambio de formato de las tablas de `README.md` introducido en `00-00-00-03` (vuelven a Markdown).
- Modificación ligera en el formato de colaboradores.
- Movido `documentacion/infraestructura/contenedores/borg/teoria_borg.md` a `documentacion/infraestructura/copias_seguridad/borg/teoria_borg.md`.

### Corregido

- Corregida la detección de visualizaciones de `README.md`.

---

## [`00-00-00-03`] - 2026-10-21

### Cambiado

- Renombrado `CHANGELOG` a `CHANGELOG.md`.
- Ajustes menores de formato en `CHANGELOG.md`.
- Formato de las tablas de `README.md` cambiado de Markdown a HTML.

---

## [`00-00-00-02`] - 2026-10-21

### Corregido

- Enlaces rotos en `README.md` y `documentacion/redes/*`.

---

## [`00-00-00-01`] - 2026-10-21

### Añadido

- Creación de `CHANGELOG`.
- Marcador `documentacion/seguridad/osint/en.espera` para la sección OSINT, en preparación.

### Cambiado

- Fusionados los archivos duplicados `dhcp_FUSIONAR.md` y `teoria_dhcp_FUSIONAR.md` en `documentacion/redes/dhcp/teoria_dhcp.md`.
- Renombrado `documentacion/redes/samba/smb_FUSIONAR.conf` a `smb_test2.conf`.
- Actualizada la ruta de referencia a `ddns.key.example` en `documentacion/redes/dns/bind9/dinamico/procedimiento.md`.
- `README.md` adaptado a la nueva estructura del repositorio.
- Renombrado `ddns.key` a `ddns.key.example` en `documentacion/redes/dns/bind9/dinamico/`.

---

<div align="center">
  <p><b>Linux Core - Nisamov | MIT License - 2026</b></p>
  <p><b>Contacto:</b> <a href="mailto:nisamov.contact@gmail.com">nisamov.contact@gmail.com</a></p>
  <p align="center">
    <img src=".github/media/bottom.png" alt="LinuxCore Footer" width="100%">
  </p>
</div>