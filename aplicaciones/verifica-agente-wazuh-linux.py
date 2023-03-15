# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para verificar la existencia del agente de wazuh en un servidor linux

import os
import subprocess

# Verificar si el agente de Wazuh está instalado
wazuh_installed = False
try:
    subprocess.check_output(['sudo', 'systemctl', 'status', 'wazuh-agent'])
    wazuh_installed = True
except subprocess.CalledProcessError:
    pass

# Si el agente de Wazuh no está instalado, instalarlo
if not wazuh_installed:
    try:
        os.system("curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -")
        os.system("echo 'deb https://packages.wazuh.com/4.x/apt/ stable main' | sudo tee /etc/apt/sources.list.d/wazuh.list")
        subprocess.check_output(['sudo', 'apt-get', 'update'])
        subprocess.check_output(['sudo', 'apt-get', 'install', '-y', 'wazuh-agent'])
    except subprocess.CalledProcessError as e:
        print(f"Error al instalar el agente de Wazuh: {e}")
    else:
        print("El agente de Wazuh se ha instalado correctamente.")
else:
    print("El agente de Wazuh ya está instalado en el servidor.")
