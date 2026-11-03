#!/bin/bash

# La depuracion es el proceso de identificacion y correccion de los errores de programacion

# Tambien se llama asi debugging porque se parece a la elimiacion de bug, el nombre informal de los errores de programacion.
# Para depurar un script de bash, debe ser ejecutado con la bandera -x de la forma:
## bash -x script.sh
# Depurar una pequeña seccion de codigo se hace envolviendo la parte del codigo a depurar con las banderas -x y +x de la forma:
    # set -x
    # Código a depurar
    # set +x