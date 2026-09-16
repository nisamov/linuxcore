# COPIAS LÓGICAS (mysqldump)

Copiar una base de datos específica desde un servidor remoto
```sql
mysqldump -u usuario -h 192.168.x.x -p nombre_db > backup_db.sql
```

Copiar VARIAS bases de datos (esto incluirá los comandos CREATE DATABASE)
```sql
mysqldump -u usuario -h 192.168.x.x -p --databases libreria empresa cine > copia_multidb.sql
```

Copia de seguridad TOTAL de todo el servidor
```sql
mysqldump -u usuario -h 192.168.x.x -p --all-databases > copia_total.sql
```

## RESTAURAR una copia
Si el .sql no tiene "CREATE DATABASE", se crea anteriormente en MariaDB.
```sql
mysql -u usuario -h 192.168.x.x -p nombre_db_destino < backup_db.sql
```

# COPIAS FÍSICAS (mariadb-backup)
Copia los archivos binarios directamente. Mucho más rápido en DBs gigantes.*/

Realizar Backup Completo inicial
```sql
sudo mariadb-backup --backup \
  --target-dir=/home/osboxes/copiacompleta \
  --user="root" -p
```

Realizar Backup Incremental (Solo lo que cambió desde la completa)
El --target-dir es donde se guarda lo nuevo, --incremental-basedir es la base.
```sql
sudo mariadb-backup --backup \
  --target-dir=/home/osboxes/inc_martes \
  --incremental-basedir=/home/osboxes/copiacompleta \
  --user="root" -p
```

PREPARAR (Fusión): Se deben aplicar los incrementales a la base completa
Primero se prepara la completa:
```sql
sudo mariadb-backup --prepare --target-dir=/home/osboxes/copiacompleta
```

Luego se fusiona el incremental en la completa:
```sql
sudo mariadb-backup --prepare \
  --target-dir=/home/osboxes/copiacompleta \
  --incremental-dir=/home/osboxes/inc_martes
```

# ADMINISTRACIÓN Y BLOQUEOS

Borrar bases de datos
```sql
DROP DATABASE IF EXISTS base1;
DROP DATABASE IF EXISTS base2;
```

Bloqueo de seguridad para evitar escrituras durante copias manuales
```sql
FLUSH TABLES WITH READ LOCK;
```

Ver posición actual del log binario (útil para backups incrementales manuales)
```sql
SHOW MASTER STATUS;
```

Liberar el bloqueo
```sql
UNLOCK TABLES;
```

# RECUPERACIÓN POR LOG BINARIO (Point-in-Time Recovery)
Sirve para recuperar datos entre el último backup y el momento del fallo.

El `SET sql_log_bin=OFF` evita que la restauración se vuelva a escribir en el log actual, evitando bucles.

```sh
sudo mysqlbinlog --start-position=123 --stop-position=456 /var/lib/mysql/logbinario.000002 \
    mysql -u usuario -p
```