
Las tuberias permiten que la salida de un comando se convierta en la entrada de otro comando. Se representan con el símbolo | (pipe).

Se presenta con "|" y se utiliza para encadenar comandos, de manera que la salida de un comando se pase como entrada al siguiente comando.

cat /etc/passwd | grep /bin/bash | wc -l

