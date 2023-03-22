# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para verificar el estado de los consumibles de una impresora ricoh mp350+

import time
from pysnmp.hlapi import *

# Configuración de la impresora
ip = '192.168.1.150'  # Dirección IP de la impresora
community = 'public'  # Comunidad SNMP
printer_oid = '1.3.6.1.2.1.43.11.1.1.9.1.4'  # OID para el estado del consumible

# Función para verificar el estado del consumible
def check_consumable():
    errorIndication, errorStatus, errorIndex, varBinds = next(
        getCmd(SnmpEngine(),
               CommunityData(community),
               UdpTransportTarget((ip, 161)),
               ContextData(),
               ObjectType(ObjectIdentity(printer_oid)))
    )
    if errorIndication:
        print(errorIndication)
    elif errorStatus:
        print('%s at %s' % (errorStatus.prettyPrint(),
                            errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
    else:
        for varBind in varBinds:
            print('Estado del consumible:', varBind[1])

# Bucle principal para verificar el estado del consumible cada 10 segundos
while True:
    check_consumable()
    time.sleep(10)
