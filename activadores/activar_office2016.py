import os
import subprocess

# Cambiar al directorio de instalación de Office 2016
if os.path.isdir(os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office16")):
    os.chdir(os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office16"))
elif os.path.isdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16")):
    os.chdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16"))
else:
    print("No se encontró el directorio de instalación de Office 2016")
    exit(1)

# Obtener el nombre del archivo de licencia
for file_name in os.listdir(os.path.join("..", "root", "Licenses16")):
    if file_name.startswith("proplusvl_kms") and file_name.endswith(".xrm-ms"):
        license_file = file_name
        break
else:
    print("No se encontró el archivo de licencia")
    exit(1)

# Instalar la licencia
subprocess.run(["cscript", "ospp.vbs", "/inslic:" + os.path.join("..", "root", "Licenses16", license_file)])

# Instalar la clave de producto
subprocess.run(["cscript", "ospp.vbs", "/inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99"])

# Desinstalar claves anteriores (si existen)
keys_to_uninstall = ["BTDRB", "KHGM9", "CPQVG"]
for key in keys_to_uninstall:
    subprocess.run(["cscript", "ospp.vbs", "/unpkey:" + key], stdout=subprocess.DEVNULL)

# Configurar el host KMS
subprocess.run(["cscript", "ospp.vbs", "/sethst:e8.us.to"])

# Configurar el puerto KMS
subprocess.run(["cscript", "ospp.vbs", "/setprt:1688"])

# Activar Office
subprocess.run(["cscript", "ospp.vbs", "/act"])
