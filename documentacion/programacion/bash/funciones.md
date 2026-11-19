# Funciones en Bash

Las funciones agrupan instrucciones reutilizables y pueden recibir argumentos posicionales.

## Definir una función

```bash
saludar() {
    local nombre=${1:-persona usuaria}
    echo "Hola, $nombre"
}

saludar LinuxCore
```

`local` limita el alcance de una variable a la función.

## Devolver valores

Las funciones finales tienen dos tipos de salida:

- Texto escrito en salida estándar mediante `echo` o `printf`.
- Código numérico devuelto mediante `return`.

```bash
sumar() {
    if (( $# != 2)); then
        echo "Uso: sumar numero1 numero2" >&2
        return 2
    fi

    echo $(( $1 + $2 ))
}

resultado=$(sumar 7 5)
echo "La suma es $resultado"
```

El código de salida se puede consultar inmediatamente con `$?`.

## Función booleana

```bash
archivo_legible() {
    local ruta=${1:-}
    [[ -n "$ruta" && -f "$ruta" && -r "$ruta" ]]
}

if archivo_legible /ruta/archivo; then
    echo "Puede leerse"
else
    echo "No puede leerse"
fi
```

## Buenos usos

- Prefiere nombres descriptivos.
- Comprueba argumentos antes de usarlos.
- Usa `local` para variables internas.
- Evita que una función modifique datos no relacionados.
- Documenta qué texto y qué código devuelve una función pública.