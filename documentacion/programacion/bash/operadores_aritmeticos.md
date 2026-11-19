# Operadores aritméticos en Bash

Bash realiza cálculos con enteros de forma nativa. Para operaciones con decimales se utilizan programas externos como `bc` o `awk`.

## Operadores

| Operador | Función |
| --- | --- |
| `+` | Suma. |
| `-` | Resta. |
| `*` | Multiplicación. |
| `/` | División entera. |
| `%` | Resto de una división. |
| `**` | Exponenciación. |
| `++` | Incremento. |
| `--` | Decremento. |

## Operaciones entre paréntesis dobles

```bash
a=5
b=2

echo $((a + b))
echo $((5 % 2))
echo $((2 ** 3))

((a++))
((a += 10))
echo "$a"
```

`$(( ... ))` devuelve el resultado como texto. `(( ... ))` modifica variables o evalúa condiciones sin imprimir el resultado.

## Operadores de asignación

```bash
numero=10
numero+=5
numero-=2
numero*=3
numero/=3
numero%=4
```

## Let y expr

`let` puede asignar una expresión directamente:

```bash
let resultado=a+b
let "resultado = a * b"
```

`expr` es un comando externo y necesita espacios entre operandos; el asterisco debe escaparse:

```bash
expr 1 + 1
expr 5 \* 2
```

## Diferentes bases

```bash
echo $((0xFF))
echo $((010))
echo $((2#1010))
```

Los resultados son `255`, `8` y `10` respectivamente.

## Punto flotante

Con `bc`:

```bash
echo 'scale=2; 5 / 2' | bc
```

Con `awk`:

```bash
awk 'BEGIN {print 5 / 2}'
```

## Operadores de combinación de comandos

| Operador | Comportamiento |
| --- | --- |
| `;` | Ejecuta comandos secuencialmente. |
| `&&` | Ejecuta el siguiente solo si el anterior termina con código cero. |
| `\|\|` | Ejecuta el siguiente solo si el anterior termina con error. |
| `&` | Ejecuta un proceso en segundo plano. |
| `( )` | Agrupa comandos en un subshell. |
| `{ }` | Agrupa comandos en el mismo shell. |

```bash
apt update && apt upgrade -y
apt update \|\| true
{ apt update && apt upgrade -y; }
```

Los comandos anteriores pueden modificar paquetes del sistema y requieren permisos de administrador.