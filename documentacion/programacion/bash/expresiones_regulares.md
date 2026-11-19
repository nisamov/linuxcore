# Expresiones regulares en Bash

Una expresión regular describe patrones de texto para buscar, validar o extraer información.

## Uso en Bash

Bash usa expresiones regulares POSIX extendidas dentro de `[[ variable =~ patrón ]]`:

```bash
if [[ $1 =~ ^[A-Z] ]]; then
    echo "Empieza por una letra mayúscula"
fi

if [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Solo contiene números"
fi
```

El operador `=~` no debe utilizarse con `test` ni `[ ]`.

## Selección de caracteres

| Patrón | Significado |
| --- | --- |
| `.` | Cualquier carácter excepto salto de línea. |
| `^` | Inicio de línea o negación dentro de corchetes. |
| `$` | Final de línea. |
| `[abc]` | Uno de los caracteres indicados. |
| `[^abc]` | Cualquier carácter excepto los indicados. |
| `[a-q]` | Rango de letras. |
| `[0-6]` | Rango de dígitos. |

## Clases POSIX

| Clase | Significado |
| --- | --- |
| `[[:upper:]]` | Letras mayúsculas. |
| `[[:lower:]]` | Letras minúsculas. |
| `[[:digit:]]` | Dígitos. |
| `[[:alpha:]]` | Letras. |
| `[[:alnum:]]` | Letras y dígitos. |
| `[[:space:]]` | Espacios en blanco. |
| `[[:punct:]]` | Caracteres de puntuación. |

Bash no interpreta directamente `\d`, `\w` o `\s` como en otros motores. Sus equivalencias POSIX son `[0-9]`, `[[:alnum:]]` y `[[:space:]]`.

## Cuantificadores

| Símbolo | Significado |
| --- | --- |
| `?` | Cero o una vez. |
| `*` | Cero o más veces. |
| `+` | Una o más veces. |
| `{n}` | Exactamente `n` veces. |
| `{m,}` | Al menos `m` veces. |
| `{n,m}` | Entre `n` y `m` veces. |

```bash
[[ $dni =~ ^[0-9]{8}[A-Z]$ ]]
[[ $telefono =~ ^[0-9]{9}$ ]]
```

## Unión y agrupación

- `|` permite alternativas.
- `( )` agrupa expresiones.
- `\.` busca un punto literal.
- `\+` busca un símbolo más literal.

```bash
[[ $entrada =~ ^(sla|ha)ve$ ]]
[[ $entrada =~ \.[.]?$ ]]
```

## Ejemplos

```bash
[[ $1 =~ ^Pablo$ ]]       # Exactamente Pablo
[[ $1 =~ ^Pablo ]]        # Comienza por Pablo
[[ $1 =~ Pablo$ ]]        # Termina en Pablo
[[ $1 =~ ^niñ[oa]$ ]]     # Niño o niña
[[ $1 =~ ^....$ ]]        # Exactamente cuatro caracteres
[[ $1 =~ ^[^.] ]]         # No comienza por punto
[[ $1 =~ [Ax5] ]]         # Contiene A, x o 5
[[ $1 =~ boy|girl|thing ]] # Contiene una de las opciones
```