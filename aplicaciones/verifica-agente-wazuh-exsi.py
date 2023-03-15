# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para verificar la existencia del agente de wazuh en un servidor EXSi

import subprocess

# Verificar si el agente de Wazuh está instalado en el servidor ESXi
wazuh_installed = False
try:
    subprocess.check_output(['ssh', 'root@<ESXi_server_ip_address>', 'vim-cmd', 'vmsvc/getallvms'])
    wazuh_installed = True
except subprocess.CalledProcessError:
    pass

# Si el agente de Wazuh no está instalado, instalarlo
if not wazuh_installed:
    try:
        # Descargar el paquete del agente de Wazuh
        subprocess.check_output(['curl', '-o', '/tmp/wazuh-agent.deb', 'https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.2.5-1_amd64.deb'])
        
        # Copiar el paquete del agente de Wazuh al servidor ESXi
        subprocess.check_output(['scp', '/tmp/wazuh-agent.deb', 'root@<ESXi_server_ip_address>:/tmp'])
        
        # Instalar el paquete del agente de Wazuh en el servidor ESXi
        subprocess.check_output(['ssh', 'root@<ESXi_server_ip_address>', 'esxcli', 'software', 'install', '-d', '/tmp/wazuh-agent.deb'])
    except subprocess.CalledProcessError as e:
        print(f"Error al instalar el agente de Wazuh: {e}")
    else:
        print("El agente de Wazuh se ha instalado correctamente.")
else:
    print("El agente de Wazuh ya está instalado en el servidor ESXi.")
