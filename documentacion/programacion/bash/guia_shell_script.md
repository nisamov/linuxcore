# Guía de programación en Bash

Bash es un intérprete de comandos y un lenguaje de automatización disponible en la mayoría de sistemas Linux. Permite combinar programas pequeños mediante tuberías, variables, estructuras de control y funciones.

## Requisitos previos

- Un sistema Linux con Bash instalado.
- Permisos suficientes para ejecutar o modificar los recursos utilizados por el script.
- Conocimiento básico de comandos del sistema y del sistema de archivos.

## Crear un script

La primera línea indica qué intérprete debe ejecutar el archivo:

```bash
#!/bin/bash
```

Ejemplo:

```bash
#!/bin/bash

nombre=${1:-usuario}
echo "Hola, $nombre"
```

Otorga permisos de ejecución y ejecútalo:

```bash
chmod 755 saluda.sh
./saluda.sh Ana
```

Otorgar permisos puede modificar el control de acceso del archivo. Antes de usar `sudo` o permisos amplios, comprueba la propiedad y el propósito del script.

## Entrada, salida y argumentos

| Elemento | Descripción |
| --- | --- |
| `$0` | Nombre del script. |
| `$1` a `$9` | Primeros argumentos posicionales. |
| `$#` | Número de argumentos recibidos. |
| `$@` | Todos los argumentos conservados por separado. |
| `$*` | Todos los argumentos combinados en una cadena. |
| `${variable:-valor}` | Usa `valor` si la variable está vacía o no está definida. |

Ejemplo:

```bash
#!/bin/bash

if (( $# != 2)); then
    echo "Uso: $0 <nombre> <curso>" >&2
    exit 1
fi

echo "Hola $1, estás en $2"
```

El código `exit 1` indica que el script terminó con un error. Cero indica éxito y los valores entre uno y 255 indican distintos errores.

## Variables y cadenas

Las variables no requieren declarar su tipo:

```bash
cadena="Linux"
numero=5
cadena+="Core"
```

| Operación | Sintaxis |
| --- | --- |
| Longitud | `${#cadena}` |
| Subcadena | `${cadena:inicio:longitud}` |
| Mayúsculas | `${cadena^^}` |
| Minúsculas | `${cadena,,}` |
| Valor predeterminado | `${variable:-predeterminado}` |

Compara cadenas dentro de `[[ ... ]]`:

```bash
if [[ -z "$1" ]]; then
    echo "Falta el argumento" >&2
    exit 1
fi

if [[ "$1" == as* ]]; then
    echo "Empieza por as"
fi
```

## Operadores y condiciones

Para números, `(( ))` permite operaciones aritméticas:

```bash
if (( nota >= 5)); then
    echo "Aprobado"
elif (( nota >= 4)); then
    echo "Convocatoria extraordinaria"
else
    echo "Suspenso"
fi
```

| Comparación | Numérica | Cadena |
| --- | --- | --- |
| Igual | `-eq` o `==` dentro de `(( ))` | `[[ "$a" == "$b" ]]` |
| Distinto | `-ne` | `[[ "$a" != "$b" ]]` |
| Menor | `-lt` o `<` dentro de `(( ))` | — |
| Mayor | `-gt` o `>` dentro de `(( ))` | — |
| Vacía | — | `[[ -z "$a" ]]` |

## Bucles

Ejemplos de `while` y `for`:

```bash
intentos=0
while (( intentos < 3)); do
    read -r -p "Clave: " clave
    ((intentos++))
done

for usuario in ana ben eva; do
    echo "$usuario"
done

for archivo in *.txt; do
    echo "Procesando $archivo"
done

for (( i=0; i<5; i++)); do
    echo "$i"
done
```

El comodín `*.txt` es una expansión de nombre realizada por Bash. No es una expresión regular.

## Arrays y funciones

```bash
usuarios=(ana ben eva)

echo "${usuarios[0]}"
echo "Hay ${#usuarios[@]} usuarios"

for usuario in "${usuarios[@]}"; do
    echo "$usuario"
done
```

```bash
saludar() {
    local nombre=${1:-usuario}
    echo "Hola, $nombre"
}

saludar Ana
```

Las variables locales evitan alterar el estado de otras funciones o del resto del script.

## Tuberías y redirecciones

Una tubería pasa la salida estándar de un comando a la entrada estándar del siguiente:

```bash
cat /etc/passwd | grep /bin/bash | wc -l
```

Redirige o descarta cada flujo por separado:

```bash
comando > salida.txt
comando >> salida.txt
comando 2> errores.txt
comando &> todo.txt
comando 2> /dev/null
comando < entrada.txt
```

`tee` muestra la salida y la guarda en un archivo:

```bash
echo "Hola" | tee -a registro.log
```

Los operadores `&&`, `||` y `;` permiten encadenar comandos:

```bash
mkdir -p /tmp/copias && cd /tmp/copias
id ana &> /dev/null || useradd ana
date; whoami; pwd
```

`&&` continúa solo si el comando anterior termina con código cero. `||` continúa solo si termina con error.

## Filtros habituales

| Comando | Uso |
| --- | --- |
| `grep` | Busca líneas por texto o expresión regular. |
| `cut` | Selecciona columnas o caracteres. |
| `sort` | Ordena líneas. |
| `uniq` | Cuenta o elimina repeticiones consecutivas. |
| `wc` | Cuenta líneas, palabras o caracteres. |
| `head` / `tail` | Muestra el principio o el final de una entrada. |
| `tr` | Sustituye o elimina caracteres. |

Ejemplos:

```bash
cut -d ':' -f1,7 /etc/passwd
sort -t ':' -k3 -n /etc/passwd
cut -d ':' -f7 /etc/passwd | sort | uniq -c | sort -rn
cut -d ':' -f1 /etc/passwd | tr '[:lower:]' '[:upper:]'
```

## Expresiones regulares

Bash admite expresiones regulares mediante coincidencia dentro de `[[ ]]` y herramientas como `grep -E`, `sed` y `awk`:

```bash
if [[ $dni =~ ^[0-9]{8}[A-Z]$ ]]; then
    echo "DNI con formato válido"
fi

grep -E 'Failed|Accepted' /var/log/auth.log
```

Los patrones básicos difieren entre herramientas. Una expresión válida para `grep -E` no tiene que ser válida como patrón glob de Bash.

## Editar texto con sed

| Operación | Ejemplo |
| --- | --- |
| Sustituir primera coincidencia | `s/ASIR/ASIX/` |
| Sustituir todas las coincidencias | `s/;/ /g` |
| Mostrar una línea | `sed -n '3p'` |
| Eliminar una línea | `sed '3d'` |
| Eliminar líneas coincidentes | `sed '/^#/d'` |
| Añadir al principio | `sed 's/^/# /'` |
| Editar con copia de seguridad | `sed -i.bak 's/a/b/g' archivo` |

Antes de usar `sed -i`, prepara una copia o una comprobación, porque puede modificar el archivo original sin confirmación.

## Procesar campos con awk

```bash
awk -F ';' '{print $1, $NF}' alumnos.csv
awk -F ';' 'NR == 1 {next} $5 >= 5 {aprobados++} END {print aprobados+0}' notas.csv
```

`BEGIN` se ejecuta antes de leer datos, `END` después de procesar el archivo y `NR` contiene el número de registro actual.

## Buscar y procesar archivos

```bash
find /var/log -type f -name '*.log'
find /var/log -type f -mtime -7 -print
find /tmp -type f -name '*.tmp' -exec rm -f {} \;
```

La última orden elimina archivos y puede borrar datos. Usa primero `find` sin `-exec` para revisar la lista que coincide.

`xargs` convierte líneas de entrada en argumentos:

```bash
find /tmp -type f -name '*.tmp' -print0 | xargs -0 rm -f
```

`-print0` y `-0` permiten manejar nombres que contienen espacios o caracteres especiales.

## Depuración

Ejecuta el script mostrando cada paso:

```bash
bash -x script.sh
```

Para depurar solo una sección:

```bash
set -x
# instrucciones a revisar
set +x
```

Las opciones también permiten detenerse ante errores:

```bash
set -e
set -u
set -o pipefail
```

- `set -e`: termina si un comando falla.
- `set -u`: informa de variables no definidas.
- `set -o pipefail`: hace que una tubería falle si alguno de sus comandos falla.

## Fechas

```bash
fecha=$(date +%F)
hora=$(date +%H:%M)
copia="copia_${fecha}.tar.gz"

date -d '+1 week' +%F
```

Para calcular diferencias:

```bash
objetivo=$(date -u -d '2026-12-25' +%s)
ahora_actual=$(date -u -d "$(date +%F)" +%s)
echo $(( (objetivo - hora_actual) / 86400 ))
```

## Buenas prácticas

- Cita las variables con `"$variable"` para evitar expansiones y separaciones inesperadas.
- Usa `readonly` para valores que no deban cambiar.
- Comprueba argumentos y permisos antes de realizar operaciones.
- Añade mensajes de error a la salida estándar de errores.
- Comienza las operaciones destructivas con una previsualización.
- Evita mezclar salida y salida de error sin necesidad.
- Crea copias de seguridad antes de modificar archivos de configuración.
