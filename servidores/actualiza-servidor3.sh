#!/bin/bash

# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar la actualizacion automatica de un servidor en Debian

# Actualizar paquetes existentes
apt-get update

# Actualizar paquetes instalados
apt-get upgrade -y

# Limpiar paquetes obsoletos y temporales
apt-get autoremove -y
apt-get autoclean

# Reiniciar el servidor si es necesario
if [ -f /var/run/reboot-required ]; then
  reboot
fi
