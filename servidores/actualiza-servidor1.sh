#!/bin/bash

# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar la actualizacion automatica de un servidor en Debian

# Definir variables globales
LOGFILE=/var/log/actualizacion-servidor.log

# Añadir fecha y hora al log
echo "--------" >> $LOGFILE
date >> $LOGFILE

# Actualizar paquetes existentes
echo "Actualizando paquetes existentes..." | tee -a $LOGFILE
apt-get update >> $LOGFILE 2>&1

# Actualizar paquetes instalados
echo "Actualizando paquetes instalados..." | tee -a $LOGFILE
apt-get upgrade -y >> $LOGFILE 2>&1

# Limpiar paquetes obsoletos y temporales
echo "Eliminando paquetes obsoletos y temporales..." | tee -a $LOGFILE
apt-get autoremove -y >> $LOGFILE 2>&1
apt-get autoclean >> $LOGFILE 2>&1

# Reiniciar el servidor si es necesario
if [ -f /var/run/reboot-required ]; then
  echo "Se requiere reiniciar el servidor. Reiniciando..." | tee -a $LOGFILE
  reboot
fi
