# Tuberías en Bash

Una tubería conecta la salida estándar de un comando con la entrada estándar del siguiente.

## Sintaxis

```bash
comando1 | comando2 | comando3
```

Ejemplo:

```bash
cat /etc/passwd | grep '/bin/bash' | wc -l
```

El primer comando entrega líneas al segundo, que filtra las coincidencias y pasa el resultado al tercero, que cuenta líneas.

## Ejemplos habituales

```bash
getent passwd | sort
cut -d ':' -f7 /etc/passwd | sort | uniq -c
find /var/log -type f -name '*.log' | less
```

## Agrupar y procesar flujos

```bash
(echo 'primera línea'; echo 'segunda línea') | sort
```

Los paréntesis crean un subshell que reúne varios resultados antes de enviarlos por la tubería.

## Pipefail

```bash
set -o pipefail
comando1 | comando2
```

Con `pipefail`, una tubería termina con error si cualquiera de sus comandos falla, no solo el último.

## xargs

Convierte las líneas recibidas en argumentos de otro comando:

```bash
find /tmp -type f -name '*.tmp' -print0 | xargs -0 rm -f
```

- `-print0` termina cada nombre con un carácter nulo.
- `-0` permite a `xargs` leer nombres separados por ese carácter.

La combinación puede eliminar archivos. Antes de ejecutarla, revisa el resultado de `find` sin `rm`:

```bash
find /tmp -type f -name '*.tmp'
```