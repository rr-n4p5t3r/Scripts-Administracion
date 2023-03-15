#!/bin/bash

# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar la actualizacion automatica de una nube nextcloud

# Define variables
ncpath='/var/www/nextcloud'
ncuser='www-data'
ncgroup='www-data'

# Change directory to Nextcloud path
cd $ncpath

# Download latest version of Nextcloud
wget https://download.nextcloud.com/server/releases/latest.tar.bz2

# Extract downloaded file
tar -xjf latest.tar.bz2

# Backup current configuration
cp $ncpath/config/config.php $ncpath/config/config-backup.php

# Copy over apps and config to new version
cp -r $ncpath/apps/* $ncpath-new/apps/
cp -r $ncpath/config/* $ncpath-new/config/

# Delete old Nextcloud version
rm -rf $ncpath

# Rename new version to original Nextcloud path
mv $ncpath-new $ncpath

# Fix permissions
chown -R $ncuser:$ncgroup $ncpath
chmod -R 755 $ncpath

# Restore config file
cp $ncpath/config-backup.php $ncpath/config/config.php

# Clean up downloaded files
rm latest.tar.bz2
