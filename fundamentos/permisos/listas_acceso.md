# Listas de Acceso (ACL)

Las Listas de Control de Acceso (ACLs, por sus siglas en inglés) permiten establecer permisos avanzados para archivos y directorios en sistemas de archivos compatibles. A diferencia de los permisos tradicionales de UNIX (propietario, grupo y otros), las ACLs permiten definir permisos para múltiples usuarios y grupos adicionales, proporcionando un control mucho más granular sobre quién puede acceder o modificar los archivos.

Con ACLs, un administrador puede otorgar acceso a un usuario o grupo específico sin modificar los permisos tradicionales del archivo o directorio. Esto resulta muy útil en entornos con varios usuarios y necesidades de permisos diferenciadas.

En RHEL 9 y otros sistemas Linux modernos, las ACLs se implementan en sistemas de archivos como ext4 y XFS. Para poder usar ACLs, el sistema de archivos debe soportarlas y estar habilitado.

| Tipo de entrada | Etiqueta de permisos | Forma en texto |
| --- | --- | --- |
| Owner (dueño) | ACL_USER_OBJ | `user::rwx` o `u::rwx` |
| Named user (usuario nombrado) | ACL_USER | `user:usuario:rwx` o `u:usuario:rwx` |
| Owning group (grupo dueño) * | ACL_GROUP_OBJ | `group::rwx` o `g::rwx` |
| Named group (grupo nombrado) | ACL_GROUP | `group:grupo:rwx` o `g:grupo:rwx` |
| Mask (máscara) | ACL_MASK | `mask::rwx` o `m::rwx` |
| Others (otros) * | ACL_OTHER | `other::rwx` o `o::rwx` |

> Las entradas marcadas con * (Owning group y Others) corresponden a los permisos tradicionales de UNIX.

La **máscara ACL** limita los permisos efectivos que pueden tener los usuarios o grupos nominales.  
Esto significa que, aunque un usuario tenga permisos explícitos en la ACL, **no podrá superar los permisos establecidos en la máscara**.
