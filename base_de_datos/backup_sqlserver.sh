#!/bin/bash

# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar backup automatico de bases de datos sql server

# Configuración
DB_USER="usuario_db" # Nombre de usuario de la base de datos
DB_PASS="contraseña_db" # Contraseña de la base de datos
DB_NAME="nombre_bd" # Nombre de la base de datos
BACKUP_DIR="/ruta/del/backup" # Directorio donde se guardará el backup
DATE=$(date +"%Y%m%d_%H%M%S") # Fecha y hora actual

# Crear el directorio de backups si no existe
if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR
fi

# Crear el nombre del archivo de backup
BACKUP_FILE="$DB_NAME-$DATE.bak"

# Crear el backup de la base de datos
sqlcmd -S localhost -U $DB_USER -P $DB_PASS -Q "BACKUP DATABASE [$DB_NAME] TO DISK='$BACKUP_DIR/$BACKUP_FILE'"

# Comprimir el backup
gzip $BACKUP_DIR/$BACKUP_FILE

# Eliminar backups antiguos (más de 7 días)
find $BACKUP_DIR/* -mtime +7 -exec rm {} \;
