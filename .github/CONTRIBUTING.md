<p align="center">
  <img src="https://raw.githubusercontent.com/nisamov/linuxcore/main/.github/media/top.png" alt="LinuxCore Header" width="100%">
</p>

<div align="center">
  <h1>Guía de contribución | Linux Core</h1>
</div>

Gracias por querer aportar a LinuxCore. Esta guía explica qué se puede aportar, dónde va cada cosa, qué pasos seguir, qué archivos no se pueden tocar y qué comprobaciones se ejecutan antes de que un cambio se publique en [linuxcore.site](https://linuxcore.site).

Si solo quieres avisar de un error o proponer un tema, no necesitas hacer un Pull Request: abre una incidencia desde la sección [Cómo informar de un problema o proponer contenido](#cómo-informar-de-un-problema-o-proponer-contenido).

## Qué se puede aportar

| Tipo de aporte | Dónde va | Cómo se comprueba |
| --- | --- | --- |
| Documentación (teoría, procedimientos, diagnóstico) | `documentacion/<área>/<tema>/` | `validate_markdown.py` |
| Ficheros de ejemplo y configuración (`.conf`, `.sh`, `.php`, `.sql`) | Junto al documento al que acompañan | Revisión manual |
| Ficha de un comando | `json/comandos/<categoría>/<comando>.json` | `validate_commands.py` |
| Ficha de una distribución | `json/distribuciones/<distribucion>.json` | `distros_db_gen.py` |
| Corrección de erratas o enlaces rotos | El archivo afectado | `validate_markdown.py` |
| Scripts, flujos de trabajo y plantillas | `.github/` | Revisión del mantenedor |
| Entrada en el registro de cambios (obligatoria en todo Pull Request) | [`CHANGELOG.md`](../CHANGELOG.md) | Comprobación automática del Pull Request |

La carpeta `json/servicios/` está en preparación: sus archivos todavía están vacíos y no se aceptan fichas de servicios hasta que se defina su formato.

El idioma oficial del repositorio es el español. Todo el contenido, los mensajes de commit y la descripción del Pull Request deben estar en español.

## Archivos protegidos y obligatorios

Tres archivos tienen reglas especiales. Se comprueban de forma automática en cada Pull Request y, si no se cumplen, el cambio no puede fusionarse.

| Archivo | Regla | Motivo |
| --- | --- | --- |
| `.github/db/` | No se puede modificar. | Todo su contenido se genera de forma automática. Tocarlo a mano rompe la estandarización de los datos. |
| [`.github/AGRADECIMIENTOS.md`](AGRADECIMIENTOS.md) | No se puede modificar. | Está reservado al creador del repositorio. Los reconocimientos los añade el mantenedor. |
| [`CHANGELOG.md`](../CHANGELOG.md) | Hay que actualizarlo en todo Pull Request. | Es el registro de cambios del proyecto y debe reflejar cada contribución. |

Si tu cambio genera archivos en `.github/db/` al ejecutar las validaciones, descártalos antes de hacer commit con `git restore .github/db/`.

### Cómo actualizar el CHANGELOG

- Añade una entrada por cada Pull Request, en español, que describa qué se ha añadido o cambiado.
- Sigue el formato de las entradas más recientes del archivo: usa la categoría que corresponda de las que ya existen, como Añadido o Cambiado, y mantén el mismo estilo de redacción.
- No reescribas ni reordenes entradas anteriores.
- Si no sabes qué versión corresponde a tu entrada, indícalo en las notas del Pull Request y el mantenedor la ajustará al fusionar.

## Antes de empezar

Necesitas:

- Una cuenta de GitHub.
- `git` instalado.
- Python 3.10 o superior (solo para ejecutar las validaciones).
- La librería `jsonschema`, si vas a tocar fichas de comandos.

Si es tu primera contribución, empieza por algo pequeño: corregir una errata, mejorar una explicación o completar la descripción de una distribución.

## Flujo de trabajo paso a paso

1. Haz un fork del repositorio desde el botón **Fork** de [nisamov/linuxcore](https://github.com/nisamov/linuxcore).
2. Clona tu fork y entra en la carpeta:

   ```bash
   git clone https://github.com/<tu-usuario>/linuxcore.git
   cd linuxcore
   ```

3. Crea una rama para tu cambio. No trabajes directamente sobre `main`. Se recomienda un prefijo que indique el tipo de cambio:

   ```bash
   git checkout -b doc/teoria-postfix
   ```

   Prefijos sugeridos: `doc/` para documentación, `cmd/` para fichas de comandos, `distro/` para distribuciones y `fix/` para correcciones.

4. Realiza los cambios siguiendo las secciones de esta guía y las normas de [ACCESSIBILITY.md](../ACCESSIBILITY.md). No toques `.github/db/` ni `.github/AGRADECIMIENTOS.md`.
5. Añade una entrada en [`CHANGELOG.md`](../CHANGELOG.md) siguiendo las indicaciones de [Cómo actualizar el CHANGELOG](#cómo-actualizar-el-changelog).
6. Ejecuta las validaciones descritas en [Validaciones antes de enviar](#validaciones-antes-de-enviar).
7. Registra los cambios con el nombre de la versión por `CHANGELOG.md`:

   ```bash
   git add documentacion/redes/correo/teoria_postfix.md README.md CHANGELOG.md
   git commit -m "00-03-25-47"
   ```

8. Sube la rama a tu fork:

   ```bash
   git push origin doc/teoria-postfix
   ```

9. Abre un Pull Request hacia la rama `main` de `nisamov/linuxcore` desde la pestaña [Pull requests](https://github.com/nisamov/linuxcore/pulls), rellena la plantilla que aparece y marca las casillas de la sección **Requisitos obligatorios**.
10. Espera la revisión. Si se piden cambios, súbelos a la misma rama: el Pull Request se actualiza solo.
11. Cuando el cambio se fusiona, el sitio web lo recoge de forma automática en un máximo de 15 minutos.

Un Pull Request debe tratar un único tema. Si quieres aportar varias cosas independientes, abre un Pull Request por cada una.

## Aportar documentación

### Dónde colocar el archivo

La documentación está en `documentacion/`, organizada en áreas: `bases_de_datos`, `infraestructura`, `programacion`, `redes`, `seguridad`, `servicios` y `sistema`. Dentro de cada área hay una carpeta por tema.

- Elige la carpeta existente más cercana al tema. Si no hay ninguna, crea una nueva dentro del área adecuada.
- Usa nombres en minúsculas, sin espacios ni tildes y con guiones bajos, por ejemplo `teoria_postfix.md`.
- Usa el prefijo `teoria_` para documentos conceptuales y `diagnosticar_` para guías de resolución de problemas.
- Guarda los ficheros de configuración o los scripts de ejemplo junto al documento que los explica, con el nombre real del fichero cuando sea posible.
- Añade una fila con enlace a tu documento en la tabla correspondiente de [README.md](../README.md).

### Estructura recomendada de un procedimiento

Los procedimientos deben incluir requisitos, pasos, verificación y reversión. Esta es una estructura de partida:

````markdown
# Título descriptivo del procedimiento

Una o dos frases que expliquen para qué sirve y cuándo se aplica.

## Requisitos previos

- Sistema y versión probados.
- Permisos necesarios.
- Paquetes que deben estar instalados.

## Procedimiento

1. Primer paso, con el comando y su finalidad.
2. Segundo paso.

## Verificación

Cómo comprobar que el resultado es el esperado.

## Reversión

Cómo deshacer el cambio, si es posible.

## Advertencias

Riesgos: borrado de datos, corte de servicio o cambios en el sistema.
````

### Reglas de estilo

Estas reglas proceden de [ACCESSIBILITY.md](../ACCESSIBILITY.md), donde se explican con más detalle:

- No añadas imágenes, GIF, vídeos ni emojis, ni siquiera como decoración. Describe la situación con texto y bloques de código.
- No numeres los títulos (`## 1. Título`) ni uses separadores `---`.
- Mantén la jerarquía de títulos (`#`, `##`, `###`) sin saltar niveles.
- Escribe enlaces con texto que se entienda fuera de contexto. Evita «aquí» o «más».
- Indica el lenguaje en cada bloque de código (`bash`, `json`, `sql`, `php`).
- Antes de un comando, explica qué hace y qué permisos necesita. Si puede borrar datos, alterar el sistema o interrumpir un servicio, indícalo de forma explícita antes del bloque.
- Explica las siglas la primera vez que aparezcan.
- No incluyas contraseñas, claves ni datos personales. En los ejemplos usa valores ficticios y, para claves, un archivo con extensión `.example` como `ddns.key.example`.

## Aportar una ficha de comando

Las fichas de comandos alimentan el buscador de [linuxcore.site](https://linuxcore.site). Cada ficha es un archivo JSON validado contra el esquema [`comando.schema.json`](schemas/comando.schema.json).

### Ubicación y nombre

- Ruta: `json/comandos/<categoría>/<comando>.json`.
- Categorías existentes: `almacenamiento`, `archivos`, `compresion`, `info_sistema`, `miscelaneo`, `monolinea`, `paquetes`, `procesos`, `red`, `seguridad`, `servicios` y `usuarios`.
- El nombre del archivo debe coincidir con el valor del campo `id`, y el campo `categoria` con la carpeta.
- Una ficha por comando. Para varias herramientas de una misma familia (por ejemplo `lvcreate` y `lvextend`), crea una ficha por herramienta.

### Campos obligatorios

El esquema exige estos campos de primer nivel: `id`, `nombre`, `descripcion`, `clasificacion`, `sintaxis`, `parametros`, `requisitos`, `seguridad`, `instalacion`, `ejemplos` y `automatizacion`. Los valores admitidos que valida el esquema son:

| Campo | Valores o formato |
| --- | --- |
| `seguridad.nivel` | `bajo`, `medio`, `alto` o `critico` |
| `parametros[].tipo` | `boolean`, `string`, `integer`, `number`, `subcomando`, `path`, `size`, `comando`, `command`, `posicional`, `mode`, `special`, `integer[]`, `string[]` o `duration` |
| `ejemplos[]` | Objeto con `nombre`, `comando`, `descripcion` y `resultado_esperado` |
| `automatizacion.variables` | Lista de nombres en texto, por ejemplo `["DISPOSITIVO"]` |
| `instalacion.paquetes` | Objeto con las claves `debian_ubuntu`, `arch_linux` y `rhel_centos` |
| `tags` | Lista sin duplicados |

### Ejemplo completo

```json
{
  "id": "badblocks",
  "nombre": "badblocks",
  "descripcion": "Busca bloques defectuosos en un dispositivo mediante pruebas de lectura, escritura o lectura-escritura no destructiva.",
  "clasificacion": {
    "categoria": "almacenamiento",
    "subcategoria": "discos",
    "tags": ["disco", "diagnostico", "filesystem"]
  },
  "sintaxis": {
    "principal": "badblocks [opciones] dispositivo [ultimo_bloque] [primer_bloque]",
    "alternativas": []
  },
  "parametros": [
    {
      "flag": "-b",
      "argumento": "block_size",
      "tipo": "integer",
      "requerido": false,
      "default": 1024,
      "valores": [],
      "descripcion": "Especifica el tamaño de los bloques en bytes.",
      "conflictos": [],
      "requiere": []
    }
  ],
  "requisitos": {
    "permisos": ["root"],
    "dependencias": [],
    "paquetes": ["e2fsprogs"]
  },
  "seguridad": {
    "nivel": "critico",
    "destructivo": true,
    "requiere_root": true,
    "requiere_confirmacion": true,
    "advertencias": [
      "El modo -w destruye los datos del dispositivo.",
      "El uso de -f sobre un dispositivo montado puede provocar la pérdida de datos."
    ]
  },
  "instalacion": {
    "instalable": true,
    "metodo": "gestor_paquetes",
    "paquetes": {
      "debian_ubuntu": "sudo apt install e2fsprogs -y",
      "arch_linux": "sudo pacman -S e2fsprogs",
      "rhel_centos": "sudo dnf install e2fsprogs -y"
    }
  },
  "ejemplos": [
    {
      "nombre": "prueba_lectura",
      "comando": "sudo badblocks -s -v /dev/sda",
      "descripcion": "Realiza una prueba de lectura mostrando el progreso y la información detallada.",
      "resultado_esperado": "Lista de bloques defectuosos y mensajes de progreso."
    }
  ],
  "automatizacion": {
    "idempotente": false,
    "interactivo": false,
    "apto_script": true,
    "variables": ["DISPOSITIVO"],
    "validaciones": [
      "El dispositivo existe.",
      "El dispositivo no está montado cuando se utiliza un modo destructivo."
    ],
    "rollback": null
  }
}
```

### Criterios para el bloque de seguridad

El esquema solo comprueba que los campos existan y que `nivel` tenga un valor permitido. La coherencia depende de ti y del revisor:

- `destructivo` es `true` si el comando puede borrar o sobrescribir datos, terminar procesos o modificar la configuración del sistema.
- `requiere_confirmacion` es `true` si una persona debería confirmar antes de ejecutarlo, y en todo comando que destruya datos.
- Un comando destructivo debe tener al menos una entrada en `advertencias` y un `nivel` de `alto` o `critico` cuando el daño sea difícil de revertir.
- `requiere_root` es `true` solo si el comando necesita privilegios de superusuario para su uso habitual.
- Los ejemplos deben poder copiarse y ejecutarse como texto. Si un ejemplo es peligroso, la advertencia debe explicarlo.

### Datos que debes verificar

Comprueba cada parámetro y ejemplo contra `man <comando>` o la documentación oficial. No copies descripciones de otros sitios sin reformularlas. Si una opción solo existe en una implementación concreta (por ejemplo GNU frente a BSD), indícalo en la descripción.

## Aportar una ficha de distribución

Las fichas de `json/distribuciones/` se validan al generar la base de datos con `distros_db_gen.py`. Requisitos:

- Los campos `nombre`, `descripcion`, `web_oficial`, `fecha_origen` y `distribucion_base` son cadenas de texto.
- Los campos `autores`, `gestor_paquetes` y `fuentes` son listas de cadenas.
- `nombre` no puede estar vacío.
- La descripción debe ser neutra y técnica, en línea con el [Código de Conducta](CODE_OF_CONDUCT.md). Incluye al menos una fuente verificable en `fuentes`.

```json
{
  "nombre": "Ejemplo Linux",
  "descripcion": "Descripción breve y objetiva de la distribución.",
  "web_oficial": "https://ejemplo.org",
  "fecha_origen": "2020",
  "autores": ["Equipo de Ejemplo"],
  "distribucion_base": "Debian",
  "gestor_paquetes": ["apt", "dpkg"],
  "fuentes": ["https://ejemplo.org/acerca-de"]
}
```

## Validaciones antes de enviar

Ejecuta estas comprobaciones desde la raíz del repositorio. Las dos primeras son las que cubren la mayoría de los cambios.

Comprobar que no hay enlaces internos rotos en ningún archivo Markdown:

```bash
python3 .github/scripts/validate_markdown.py
```

Comprobar las fichas de comandos contra el esquema (instala antes la dependencia):

```bash
python3 -m pip install 'jsonschema>=4.18,<5'
python3 .github/scripts/validate_commands.py
```

Comprobar las fichas de distribuciones. Este script regenera `.github/db/distros.json`, que es un archivo protegido, por lo que debes descartar ese cambio después para no incluirlo en tu Pull Request:

```bash
python3 .github/scripts/distros_db_gen.py
git restore .github/db/
```

Qué cubren y qué no cubren estas comprobaciones:

- `validate_markdown.py` solo detecta enlaces relativos que apuntan a archivos inexistentes. No revisa la ortografía, los anclajes (`#sección`), las imágenes ni las normas de accesibilidad.
- `validate_commands.py` valida la estructura de cada ficha. No comprueba que el comando funcione, que el `id` coincida con el nombre del archivo ni que los criterios de seguridad sean coherentes.
- Revisa a mano la lista de comprobaciones de [ACCESSIBILITY.md](../ACCESSIBILITY.md) y, si cambias ficheros de configuración o scripts, pruébalos en una máquina virtual o un contenedor.

## Qué ocurre con tu Pull Request

Al abrir o actualizar un Pull Request se ejecutan comprobaciones automáticas:

- Requisitos obligatorios, en todos los Pull Request. Comprueba que las tres casillas de la sección **Requisitos obligatorios** de la plantilla están marcadas, que no se ha modificado `.github/db/` ni `.github/AGRADECIMIENTOS.md` y que `CHANGELOG.md` forma parte del cambio. Si falla, el Pull Request no puede fusionarse. Solo verifica que el CHANGELOG se ha modificado: que la entrada sea correcta lo revisa el mantenedor.
- Detección de claves secretas, en cada `push` y en cada Pull Request.
- Validación de Markdown, cuando el cambio afecta a archivos `.md` o a su script.

La validación de fichas de comandos y la generación de la base de datos se ejecutan al fusionar los cambios en `main`, no antes. Por eso es importante ejecutarlas tú en local: un JSON incorrecto no se detectará hasta después de la fusión.

Si una comprobación falla, abre el detalle en la pestaña **Checks** del Pull Request, corrige el problema y vuelve a subir la rama. Si el fallo es de una casilla sin marcar, edita la descripción del Pull Request y la comprobación se repetirá sola.

Después de la fusión, el sitio web se actualiza de forma automática cada 15 minutos y la base de datos JSON se publica en la [última versión](https://github.com/nisamov/linuxcore/releases/latest).

## Lista de comprobación del Pull Request

La plantilla del Pull Request incluye esta lista. Antes de enviarlo, confirma que:

- No has modificado `.github/db/` ni `.github/AGRADECIMIENTOS.md`.
- Has añadido una entrada en `CHANGELOG.md` con el formato del archivo.
- Los cambios están en español y siguen el estilo del repositorio.
- Has respetado la estructura de carpetas y las extensiones de archivo.
- Has ejecutado las validaciones que corresponden a tu cambio.
- Has añadido la entrada al `README.md` si creaste un documento nuevo.
- No has incluido contraseñas, claves ni datos personales.
- Has revisado erratas y la sintaxis de los bloques de código.

## Cómo informar de un problema o proponer contenido

No hace falta abrir un Pull Request para colaborar. En [Issues](https://github.com/nisamov/linuxcore/issues) hay tres plantillas:

- **Corrección de documentación**: errores, erratas o enlaces rotos en un documento concreto.
- **Documentación**: petición de un tema nuevo o de una ampliación.
- **Hallazgo crítico**: errores graves, contenido incorrecto o problemas estructurales.

Indica siempre la ruta del archivo afectado y, si puedes, la corrección propuesta. Para barreras de accesibilidad, sigue las indicaciones de la sección «Cómo comunicar un problema» de [ACCESSIBILITY.md](../ACCESSIBILITY.md).

Los problemas de seguridad deben tratarse según la [Política de Seguridad](SECURITY.md). No publiques credenciales ni datos sensibles en incidencias ni en Pull Requests.

## Recomendaciones de herramientas

Estas extensiones de Visual Studio Code facilitan la edición, aunque no son obligatorias:

- [Data Preview](https://marketplace.visualstudio.com/items?itemName=RandomFractalsInc.vscode-data-preview), para revisar JSON.
- [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced), para previsualizar documentos.
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense), para autocompletar rutas de enlaces.
- [Indent Rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow), para revisar sangrías.
- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments), para resaltar comentarios en scripts.

## Normas de convivencia y licencia

Todas las contribuciones están sujetas al [Código de Conducta](CODE_OF_CONDUCT.md). Al enviar un Pull Request aceptas que tu aportación se publique bajo la [licencia MIT](../LICENSE) del proyecto.

Para dudas que no encajen en una incidencia, escribe a [nisamov.contact@gmail.com](mailto:nisamov.contact@gmail.com).

---

<div align="center">
  <p><b>Linux Core - Nisamov | MIT License - 2026</b></p>
  <p><b>Contacto:</b> <a href="mailto:nisamov.contact@gmail.com">nisamov.contact@gmail.com</a></p>
  <p align="center">
    <img src="https://raw.githubusercontent.com/nisamov/linuxcore/main/.github/media/bottom.png" alt="LinuxCore Footer" width="100%">
  </p>
</div>