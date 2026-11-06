# Restic: repositorios cifrados y recuperación

Restic es una herramienta de copias de seguridad que almacena instantáneas deduplicadas y cifradas en repositorios locales o remotos compatibles. El cifrado depende de una contraseña del repositorio; perderla puede impedir recuperar los datos.

## Conceptos

- **Repositorio:** destino que contiene datos cifrados, índices y metadatos de las copias.
- **Instantánea (*snapshot*):** vista de los archivos respaldados en un momento determinado.
- **Deduplicación:** bloques iguales pueden almacenarse una sola vez dentro del repositorio.
- **Retención:** política para conservar o eliminar instantáneas antiguas.

La deduplicación no sustituye a la copia aislada: si una cuenta comprometida puede borrar el repositorio, las copias podrían perderse. Se recomienda almacenamiento con controles de acceso y una copia independiente.

## Preparación

Restic debe instalarse desde el gestor de paquetes o las publicaciones oficiales verificadas. El repositorio debe definirse en un destino controlado y la contraseña debe guardarse mediante un gestor seguro o un archivo con permisos mínimos. La contraseña no debe publicarse ni incrustarse en scripts o en el historial del terminal.

Los comandos siguientes sirven como referencia para un repositorio local de laboratorio. Las rutas deben sustituirse por directorios propios y vacíos, y el destino debe verificarse antes de la ejecución:

```bash
restic -r /ruta/segura/repositorio init
restic -r /ruta/segura/repositorio backup /ruta/propia/datos
restic -r /ruta/segura/repositorio snapshots
restic -r /ruta/segura/repositorio check
```

`init` crea la estructura del repositorio y no debe ejecutarse sobre una ubicación con datos que se quieran conservar. `backup` lee los directorios indicados; antes de la ejecución, debe comprobarse que no incluyan secretos innecesarios.

## Restauración de prueba

La restauración escribe archivos en el destino. Para el ensayo debe utilizarse un directorio temporal vacío y revisarse el contenido antes de trasladar archivos a producción:

```bash
restic -r /ruta/segura/repositorio restore latest --target /ruta/temporal/restauracion
```

La selección de instantánea, exclusiones y rutas depende de la necesidad. Deben validarse los permisos, propietarios, integridad de la aplicación y consistencia de los datos. La restauración no debe ejecutarse directamente sobre producción sin respaldo previo, aprobación y un plan de reversión.

## Operación

La automatización debe utilizar credenciales protegidas, registrar códigos de salida y alertas, aplicar una política de retención revisada y ejecutar comprobaciones y restauraciones periódicas. La contraseña y las instrucciones de recuperación deben mantenerse fuera del repositorio y del equipo que contienen la copia.
