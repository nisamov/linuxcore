# Condiciones de evaluación en Bash

Bash dispone de varias formas de evaluar expresiones numéricas, cadenas, archivos y códigos de salida.

## Expresiones compatibles

| Forma | Uso |
| --- | --- |
| `[ expresión ]` | Evalúa condiciones de forma tradicional y relativamente portable. |
| `[[ expresión ]]` | Añade coincidencia de patrones, expresiones regulares y operadores lógicos. |
| `(( expresión ))` | Evalúa expresiones aritméticas. |
| `( comando )` | Ejecuta comandos en un subshell y evalúa su código de salida. |
| `comando` | Utiliza directamente el código de salida del comando. |

Un resultado de cero significa verdadero en el control de flujo basado en el estado de un comando.

## Comparaciones numéricas

| Operador | Significado |
| --- | --- |
| `-lt` | Menor que. |
| `-gt` | Mayor que. |
| `-le` | Menor o igual que. |
| `-ge` | Mayor o igual que. |
| `-eq` | Igual. |
| `-ne` | Distinto. |

Ejemplo:

```bash
if (( numero >= 5 && numero <= 10)); then
    echo "El número está entre 5 y 10"
fi
```

Dentro de `[ ]`, los operadores numéricos anteriores son los apropiados. Los símbolos como `>=` pertenecen a `(( ))` o pueden utilizarse en comparaciones específicas de `[[ ]]`.

## Comparación de cadenas

| Operador | Significado |
| --- | --- |
| `==` o `=` | Igualdad. |
| `!=` | Diferencia. |
| `<` | Menor en orden alfabético. |
| `>` | Mayor en orden alfabético. |
| `-n` | No está vacía. |
| `-z` | Está vacía. |
| `=~` | Coincidencia con una expresión regular en `[[ ]]`. |

```bash
if [[ -n "$nombre" && "$nombre" =~ ^[A-Z] ]]; then
    echo "El nombre no está vacío y empieza por una mayúscula"
fi
```

## Operadores lógicos

- `!`: negación.
- `&&`: conjunción.
- `\|\|`: disyunción.
- `-a`: conjunción dentro de `[ ]`.
- `-o`: disyunción dentro de `[ ]`.

Es preferible usar `[[ ]]` o `(( ))` para expresiones lógicas largas y evitar encadenamientos ambiguos.

## Comprobación de archivos

| Operador | Comprueba |
| --- | --- |
| `-e` | Que la ruta existe. |
| `-f` | Que existe un archivo regular. |
| `-d` | Que existe un directorio. |
| `-s` | Que existe y no está vacío. |
| `-r` | Que puede leer la ruta. |
| `-w` | Que puede escribir en ella. |
| `-x` | Que tiene permiso de ejecución o acceso. |
| `-h` o `-L` | Que es un enlace simbólico. |
| `-b` | Que es un dispositivo de bloques. |
| `-c` | Que es un dispositivo de caracteres. |
| `-p` | Que es una tubería FIFO. |
| `-S` | Que es un socket. |

```bash
if [[ -f /ruta/archivo && -r /ruta/archivo ]]; then
    cat /ruta/archivo
fi
```

## Comparar archivos

| Operador | Significado |
| --- | --- |
| `archivo1 -nt archivo2` | El primero es más reciente. |
| `archivo1 -ot archivo2` | El primero es más antiguo. |
| `archivo1 -ef archivo2` | Ambos apuntan al mismo archivo o al mismo inodo. |