# Documentacion General de `libpam-passwdqc`

## Descripcion del Modulo

`libpam-passwdqc` es un modulo PAM (Pluggable Authentication Modules) desarrollado por Openwall diseñado para auditar la fortaleza de las contraseñas y enforzar politicas de seguridad complejas. A diferencia de otros modulos como `pam_pwquality` o `pam_cracklib`, `passwdqc` soporta la validacion de frases de paso (*passphrases*) formadas por palabras comunes organizadas aleatoriamente, evaluando la entropia real del secreto en lugar de requerir unicidad arbitraria de caracteres.

## Archivos de Configuracion Relevantes

* `/etc/pam.d/common-password`: Archivo del sistema de autenticacion en distribuciones basadas en Debian/Ubuntu donde se integra el modulo `pam_passwdqc.so` dentro del apilamiento (*stack*) de contraseñas.
* `/etc/passwdqc.conf` o `/etc/security/passwdqc.conf`: Archivo de configuracion global opcional de `passwdqc` donde se definen los parametros de politicas de forma centralizada sin necesidad de pasarlos como argumentos directamente en la linea de PAM.
* `/etc/pam.d/system-auth`: Archivo equivalente en sistemas basados en RHEL/CentOS/Fedora/Arch Linux para la gestion de politicas de autenticacion globales.

## Instalacion

Para incorporar el modulo en distribuciones basadas en Debian o Ubuntu, se ejecutan los siguientes comandos:

```sh
sudo apt update
sudo apt install libpam-passwdqc
```

## Sintaxis de Integracion en PAM

La directiva tipica en `/etc/pam.d/common-password` sigue la sintaxis de modulos PAM:

```sh
password required pam_passwdqc.so min=disabled,24,12,8,7 passphrase=3 retry=3 ask_oldauthtok enforce=everyone
```

## Parametros y Opciones Detalladas

# Documentacion General de libpam-passwdqc

## Descripcion del Modulo

`libpam-passwdqc` es un modulo PAM (Pluggable Authentication Modules) desarrollado por Openwall diseñado para auditar la fortaleza de las contraseñas y enforzar politicas de seguridad complejas. A diferencia de otros modulos como `pam_pwquality` o `pam_cracklib`, `passwdqc` soporta la validacion de frases de paso (*passphrases*) formadas por palabras comunes organizadas aleatoriamente, evaluando la entropia real del secreto en lugar de requerir unicidad arbitraria de caracteres.

## Archivos de Configuracion Relevantes

* `/etc/pam.d/common-password`: Archivo del sistema de autenticacion en distribuciones basadas en Debian/Ubuntu donde se integra el modulo `pam_passwdqc.so` dentro del apilamiento (*stack*) de contraseñas.
* `/etc/passwdqc.conf` o `/etc/security/passwdqc.conf`: Archivo de configuracion global opcional de `passwdqc` donde se definen los parametros de politicas de forma centralizada sin necesidad de pasarlos como argumentos directamente en la linea de PAM.
* `/etc/pam.d/system-auth`: Archivo equivalente en sistemas basados en RHEL/CentOS/Fedora/Arch Linux para la gestion de politicas de autenticacion globales.

## Instalacion

Para incorporar el modulo en distribuciones basadas en Debian o Ubuntu, se ejecutan los siguientes comandos:

```bash
sudo apt update
sudo apt install libpam-passwdqc

```

## Sintaxis de Integracion en PAM

La directiva tipica en `/etc/pam.d/common-password` sigue la sintaxis de modulos PAM:

```text
password required pam_passwdqc.so min=disabled,24,12,8,7 passphrase=3 retry=3 ask_oldauthtok enforce=everyone

```

## Parametros y Opciones Detalladas

| Parametro | Valores / Opciones | Descripcion |
| --- | --- | --- |
| `config` | `/ruta/al/archivo` | Especifica la ruta absoluta de un archivo de configuracion alternativo en lugar de pasar las opciones directas en la linea del modulo PAM. |
| `min` | `N0,N1,N2,N3,N4` | Define los limites de longitud minima segun complejidad: `N0` (una clase, recomendado `disabled`), `N1` (dos clases), `N2` (frases de paso), `N3` (tres clases), `N4` (cuatro clases). |
| `max` | `N` | Define la longitud maxima de la contraseña permitida (por defecto suele ser 40 u 85 segun la version). |
| `passphrase` | `N` | Numero minimo de palabras requeridas para que una secuencia sea considerada una frase de paso valida (por defecto `passphrase=3`). Las palabras deben estar separadas por espacios o puntuacion. |
| `match` | `N` | Comprueba secuencias o subsecuencias repetidas de caracteres dentro de la contraseña para evitar patrones simples. |
| `similar` | `permit` | `deny` | Determina si se rechaza (`deny`) o se permite (`permit`) una contraseña que sea similar a la anterior o que contenga derivaciones del nombre de usuario (*login*) o datos personales. |
| `random` | `N` | `disabled` | Define la longitud en bits de una contraseña aleatoria sugerida por el modulo cuando la contraseña ingresada no cumple los criterios de fortaleza (ej. `random=47` o `disabled`). |
| `enforce` | `everyone` | `users` | `none` | Nivel de aplicacion de la politica: `everyone` (aplica a todos, incluido `root`), `users` (aplica solo a usuarios ordinarios), `none` (desactiva la verificacion obligatoria y actua solo como advertencia). |
| `retry` | `N` | Establece el numero maximo de reintentos permitidos durante el cambio de contraseña en caso de fallar la validacion. |
| `ask_oldauthtok` | N/A | Fuerza al modulo a solicitar la contraseña actual antes de permitir el ingreso de la contraseña nueva. |
| `use_first_pass` / `try_first_pass` | N/A | Gestiona el paso de tokens de autenticacion entre modulos PAM previa o sucesivamente configurados. |
