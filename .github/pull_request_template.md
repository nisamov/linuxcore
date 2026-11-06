## Solicitud de Incorporación

Explica en pocas frases qué cambia este Pull Request y por qué.

## Tipo de cambio

- [ ] Nueva documentación
- [ ] Corrección de documentación (errata, enlace roto, procedimiento incorrecto)
- [ ] Nueva ficha de comando
- [ ] Corrección o mejora de una ficha de comando
- [ ] Nueva ficha de distribución o corrección de una existente
- [ ] Mejora de automatización, scripts o plantillas
- [ ] Ajuste de estructura (mover o renombrar archivos)
- [ ] Otro: _______

## Archivos afectados

Enumera los archivos principales modificados, creados o movidos.

## Requisitos obligatorios

Las tres casillas de esta sección deben estar marcadas para que el Pull Request pueda fusionarse.

- [ ] No he modificado `.github/db/`: su contenido se genera de forma automática.
- [ ] No he modificado `.github/AGRADECIMIENTOS.md`: está reservado al creador del repositorio.
- [ ] He añadido una entrada en `CHANGELOG.md` que describe este cambio, siguiendo el formato del archivo.

## Validaciones ejecutadas

Marca solo las que correspondan a tu cambio. Las instrucciones están en la [guía de contribución](https://github.com/nisamov/linuxcore/blob/main/.github/CONTRIBUTING.md).

- [ ] `python3 .github/scripts/validate_markdown.py` termina sin errores (cualquier cambio en archivos `.md`).
- [ ] `python3 .github/scripts/validate_commands.py` termina sin errores (cambios en `json/comandos/`).
- [ ] `python3 .github/scripts/distros_db_gen.py` termina sin errores y no he incluido cambios en `.github/db/` (cambios en `json/distribuciones/`).

## Revisión del contenido

- [ ] El contenido está en español y es técnico y neutro.
- [ ] He verificado la información con `man`, la documentación oficial o una fuente fiable.
- [ ] He advertido de forma explícita de los comandos que pueden borrar datos, alterar el sistema o interrumpir un servicio.
- [ ] No incluyo contraseñas, claves, direcciones privadas ni datos personales.
- [ ] Si he creado un documento nuevo en `documentacion/`, lo he añadido a las tablas de `README.md`.
- [ ] Si he tocado `documentacion/`, he seguido las normas de [accesibilidad del proyecto](https://github.com/nisamov/linuxcore/blob/main/ACCESSIBILITY.md).

## Notas para quien revise

Indica contexto adicional: fuentes consultadas, decisiones que dudas, riesgos conocidos o partes que quieres que se revisen con más atención.
