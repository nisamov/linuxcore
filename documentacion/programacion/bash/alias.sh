#!/bin/bash

# Un alias es un atajo o abreviatura para ejecutar un comando largo o una 
# combinación de comandos con sus respectivas opciones.
#
# No debe haber espacios alrededor del signo '='.
# Sintaxis correcta: alias nombre="comando"
# Sintaxis incorrecta: alias nombre = "comando"

# Crear/Sobrescribir un alias en la sesión actual:
alias upd8="sudo apt update && sudo apt upgrade -y"

# Listar todos los alias definidos actualmente:
alias

# Consultar la definición de un alias específico:
alias upd8

# Eliminar un alias de la sesión actual:
unalias upd8

# Eliminar todos los alias activos en la sesión actual:
unalias -a

# Si tienes un alias como 'alias rm="rm -i"' y necesitas ejecutar el comando 
# original sin la interactividad del alias, puedes usar 3 métodos:

\rm archivo.txt             # Anteponer una barra invertida (\)
command rm archivo.txt      # Usar el comando integrado 'command'
/bin/rm archivo.txt         # Especificar la ruta absoluta del ejecutable

# Los alias definidos directamente en la terminal desaparecen al cerrar la sesión.
# Para hacerlos permanentes:
# Agregarlos al archivo de configuración de tu shell:
#    - Bash: ~/.bashrc (o ~/.bash_profile en macOS)
#    - Zsh:  ~/.zshrc
# Cargar los cambios inmediatamente sin reiniciar la terminal:
#    source ~/.bashrc   # o bien: . ~/.bashrc

# En lugar de saturar ~/.bashrc, se recomienda crear un archivo independiente ~/.bash_aliases
# ~/.bashrc incluye nativamente este bloque para cargarlo automáticamente:
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# Los alias NO aceptan argumentos o parámetros de posición ($1, $2, etc.).
# Si necesitas pasar argumentos dentro del comando, debes usar una FUNCIÓN.

# Los alias no procesan argumentos internos:
# alias mkcd="mkdir $1 && cd $1"

# Usar una función para aceptar argumentos:
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Seguridad (Prevenir borrados/sobrescrituras accidentales)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Navegación rápida por directorios
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Visualización de archivos y colores
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Administración del Sistema y Red
alias path='echo -e ${PATH//:/\\n}'      # Muestra cada ruta de $PATH en una nueva línea
alias ports='ss -tulanp'                 # Muestra puertos abiertos y procesos escuchando
alias myip='curl ifconfig.me'            # Obtiene la IP pública
alias free='free -m -h'                  # Muestra RAM en MB/GB
alias df='df -h'                         # Muestra espacio en disco en formato legible

# Git (Atajos frecuentes)
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'