# Redirecciones en Bash

Las redirecciones permiten enviar entradas y salidas a archivos, dispositivos o flujos de errores.

## Flujos estándar

| Número | Flujo |
| --- | --- |
| `0` | Entrada estándar. |
| `1` | Salida estándar. |
| `2` | Salida de errores. |

## Salida a archivos

```bash
comando > fichero.txt
comando >> fichero.txt
```

- `>` sobrescribe el archivo.
- `>>` añade el resultado al final.

Antes de sobrescribir un archivo debe comprobarse su contenido y confirmarse que no contiene datos necesarios.

## Errores

```bash
comando 2> errores.txt
comando 2>> errores.txt
comando &> resultado.txt
comando 2> /dev/null
```

`&>` redirige salida estándar y errores al mismo archivo. `/dev/null` descarta información sin guardarla.

## Entrada desde archivo

```bash
comando < fichero.txt

while read -r linea; do
    echo "$linea"
done < fichero.txt
```

## Comando tee

`tee` muestra la salida estándar y la guarda en un archivo:

```bash
echo "Evento registrado" | tee registro.log
echo "Otro evento" | tee -a registro.log
```

La opción `-a` añade contenido al final; sin ella el archivo se sobrescribe.

## Here-documents

```bash
cat << 'EOF'
Primera línea
Segunda línea
EOF
```

El delimitador elegido debe coincidir al inicio de su línea final.