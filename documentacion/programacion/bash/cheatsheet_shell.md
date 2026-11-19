# Chuleta rápida de Bash

Referencia breve para consultar sintaxis y comandos habituales de Bash. Para explicaciones completas, consulta [la guía de programación en Bash](guia_shell_script.md).

## Argumentos y variables

| Elemento | Resultado |
| --- | --- |
| `$0` | Nombre del script. |
| `$1` | Primer argumento. |
| `$#` | Número de argumentos. |
| `$@` | Argumentos separados y conservados individualmente. |
| `$*` | Argumentos unidos en una cadena. |
| `${1:-valor}` | Primer argumento o `valor` si está vacío o no existe. |
| `${#cadena}` | Número de caracteres de una cadena. |
| `${cadena:0:3}` | Subcadena desde la posición cero con tres caracteres. |
| `${cadena^^}` | Convierte una cadena a mayúsculas. |
| `${cadena,,}` | Convierte una cadena a minúsculas. |

```bash
#!/bin/bash
if (( $# != 2)); then
    echo "Uso: $0 <nombre> <curso>" >&2
    exit 1
fi
```

## Condiciones

```bash
if [[ -z "$1" ]]; then
    echo "Falta el argumento"
elif [[ "$1" == as* ]]; then
    echo "Empieza por as"
fi

if (( nota >= 5)); then
    echo "Aprobado"
fi

case "$1" in
    -a|--alta) echo "Alta" ;;
    -b|--baja) echo "Baja" ;;
    *) echo "Opción no válida" ;;
esac
```

| Operador numérico | Significado |
| --- | --- |
| `-eq` | Igual. |
| `-ne` | Distinto. |
| `-lt` | Menor que. |
| `-le` | Menor o igual que. |
| `-gt` | Mayor que. |
| `-ge` | Mayor o igual que. |

| Operador de cadena | Significado |
| --- | --- |
| `[[ -z "$a" ]]` | La cadena está vacía. |
| `[[ -n "$a" ]]` | La cadena no está vacía. |
| `[[ "$a" == "$b" ]]` | Las cadenas son iguales. |
| `[[ "$a" != "$b" ]]` | Las cadenas son distintas. |

## Bucles

```bash
for usuario in ana ben eva; do
    echo "$usuario"
done

for archivo in *.txt; do
    echo "$archivo"
done

for i in {1..5}; do
    echo "$i"
done

for (( i=0; i<5; i++)); do
    echo "$i"
done

intentos=0
while (( intentos < 3)); do
    read -r -p "Clave: " clave
    ((intentos++))
done
```

## Código de salida

```bash
comando
echo "$?"
exit 3
```

- `0`: el comando terminó correctamente.
- `1` a `255`: el comando terminó con un error.
- `$?` contiene el código del último comando ejecutado.

```bash
if id ana &> /dev/null; then
    echo "El usuario existe"
else
    echo "El usuario no existe"
fi
```

## Redirecciones y tuberías

| Operador | Acción |
| --- | --- |
| `>` | Sobrescribe la salida estándar. |
| `>>` | Añade la salida estándar al final. |
| `2>` | Sobrescribe la salida de errores. |
| `2>>` | Añade la salida de errores al final. |
| `&>` | Redirige salida y errores al mismo archivo. |
| `<` | Usa un archivo como entrada estándar. |
| `2> /dev/null` | Descarta la salida de errores. |
| `\|` | Pasa la salida estándar al siguiente comando. |

```bash
getent passwd ana > ana.txt
echo "$(date) alta" >> altas.log
ls /home /noexiste > ok.txt 2> mal.txt
cat /etc/passwd | grep /bin/bash | wc -l
echo "Hola" | tee -a registro.log
```

## Combinación de comandos

| Operador | Comportamiento |
| --- | --- |
| `;` | Ejecuta secuencialmente. |
| `&&` | Ejecuta lo siguiente si el anterior terminó con código cero. |
| `\|\|` | Ejecuta lo siguiente si el anterior terminó con error. |
| `( )` | Ejecuta los comandos en un subshell. |

```bash
date; whoami; pwd
mkdir -p copia && cd copia
id ana &> /dev/null || useradd ana
(cd /home; ls); pwd
```

## Filtrado

```bash
cut -d ':' -f1,7 /etc/passwd
sort -t ':' -k3 -n /etc/passwd
sort fich | uniq -c
wc -l < /etc/passwd
head -n 5 fichero
 tail -n 5 fichero
tr '[:lower:]' '[:upper:]' < fichero
```

Combinaciones habituales:

```bash
cut -d ':' -f7 /etc/passwd | sort | uniq -c | sort -rn
sort -t ':' -k3 -n /etc/passwd | tail -n 3 | cut -d ':' -f1
```

## Globbing

| Patrón | Coincidencia |
| --- | --- |
| `?` | Exactamente un carácter. |
| `*` | Cero o más caracteres. |
| `[1-5]*` | Empieza por un dígito del uno al cinco. |
| `*[[:upper:]]*` | Contiene al menos una letra mayúscula. |
| `*[[:lower:]]*` | Contiene al menos una letra minúscula. |

## Expresiones regulares

```bash
grep -E 'Failed|Accepted' auth.log
grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' fichero
grep -cE '^[6-9][0-9]{8}$' telefonos.txt

if [[ $dni =~ ^[0-9]{8}[A-Z]$ ]]; then
    echo "Formato válido"
fi
```

| Símbolo | Significado |
| --- | --- |
| `^` | Inicio de línea. |
| `$` | Final de línea. |
| `.` | Cualquier carácter excepto salto de línea. |
| `[abc]` | Uno de los caracteres indicados. |
| `[^abc]` | Cualquier carácter excepto los indicados. |
| `*` | Cero o más repeticiones. |
| `+` | Una o más repeticiones. |
| `?` | Cero o una repetición. |
| `{n,m}` | Entre `n` y `m` repeticiones. |
| `\|` | Alternativa. |
| `( )` | Agrupación. |

## sed

```bash
sed 's/ASIR/ASIX/' fichero
sed 's/;/ /g' fichero
sed -n '3p' fichero
sed '/^#/d' fichero
sed '1d' fichero
sed 's/^/# /' fichero
sed -i.bak 's/a/b/g' fichero
```

`-i.bak` modifica el archivo original y crea una copia con la extensión `.bak`.

## awk

```bash
awk -F ';' '{print $1, $NF}' alumnos.csv
awk -F ';' 'NR == 1 {next} $5 >= 5 {aprobados++} END {print aprobados+0}' notas.csv
```

- `$1`, `$NF`, `$0`: primer campo, último campo y línea completa.
- `NR`: número de registro.
- `NF`: número de campos de la línea actual.
- `BEGIN{}`: ejecutado antes de leer.
- `END{}`: ejecutado después de leer.

## Fechas

```bash
date +%F
date +%d/%m/%Y
date +%H:%M
date -d '+1 week' +%F
copia="copia_$(date +%Y%m%d).tar.gz"
```

## Búsqueda y depuración

```bash
find /var/log -type f -name '*.log'
find /tmp -type f -mtime -7 -print
find /tmp -type f -name '*.tmp' -print0 | xargs -0 rm -f
bash -x script.sh
```

La última combinación elimina archivos temporales. Previsualiza primero con `find` sin `rm`.
