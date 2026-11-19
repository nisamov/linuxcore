# Alias y funciones en Bash

Un alias crea una abreviatura para una instrucción o combinación de comandos. Está pensado para facilitar el uso interactivo de una sesión.

## Definir y consultar alias

No deben existir espacios alrededor del signo `=`:

```bash
alias upd8="sudo apt update && sudo apt upgrade -y"
alias
alias upd8
```

Para eliminar uno o todos los alias:

```bash
unalias upd8
unalias -a
```

Los alias definidos en una terminal desaparecen al cerrar la sesión. Para conservarlos, añádelos a `~/.bashrc` o `~/.bash_aliases`.

```bash
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi
```

Después de modificar el archivo, carga los cambios:

```bash
source ~/.bashrc
```

## Ejecutar el comando original

Si un alias reemplaza un comando habitual, puede ejecutarse la versión original anteponiendo una barra invertida, usando `command` o indicando la ruta absoluta:

```bash
\rm archivo.txt
command rm archivo.txt
/bin/rm archivo.txt
```

El último ejemplo modifica o elimina datos según las opciones usadas. Comprueba las rutas antes de ejecutar operaciones destructivas.

## Alias con funciones

Los alias no procesan argumentos posicionales como `$1` o `$2`. Para recibir parámetros se utiliza una función:

```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
}

mkcd proyecto
```

## Ejemplos útiles

```bash
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias ports='ss -tulanp'
alias free='free -m -h'
alias df='df -h'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
```

Las opciones interactivas `-i` pueden solicitar confirmación y ayudar a evitar eliminaciones o sobrescrituras accidentales.