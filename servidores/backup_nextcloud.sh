#!/bin/bash

# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar backup automatico de una nube nextcloud

# Define variables
ncpath='/var/www/nextcloud'
backupdir='/mnt/backups/nextcloud'
now=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup directory if it doesn't exist
mkdir -p $backupdir

# Dump Nextcloud database
mysqldump -u [db_user] -p[db_password] [db_name] > $backupdir/nextcloud-sqlbkp_$now.sql

# Compress Nextcloud data directory
tar czf $backupdir/nextcloud-datadir_$now.tar.gz -C $ncpath data

# Compress Nextcloud config directory
tar czf $backupdir/nextcloud-config_$now.tar.gz -C $ncpath config

# Clean up backups older than 7 days
find $backupdir -type f -mtime +7 -exec rm {} \;