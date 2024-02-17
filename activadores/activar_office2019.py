import os
import subprocess

# Cambiar al directorio de instalación de Office 2019
if os.path.isdir(os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office16")):
    os.chdir(os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office16"))
elif os.path.isdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16")):
    os.chdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16"))
else:
    print("No se encontró el directorio de instalación de Office 2019")
    exit(1)

# Obtener el nombre del archivo de licencia
for file_name in os.listdir(os.path.join("..", "root", "Licenses16")):
    if file_name.startswith("ProPlus2019VL") and file_name.endswith(".xrm-ms"):
        license_file = file_name
        break
else:
    print("No se encontró el archivo de licencia")
    exit(1)

# Instalar la licencia
subprocess.run(["cscript", "ospp.vbs", "/inslic:" + os.path.join("..", "root", "Licenses16", license_file)])

# Configurar el puerto KMS
subprocess.run(["cscript", "ospp.vbs", "/setprt:1688"])

# Desinstalar la clave anterior (si existe)
subprocess.run(["cscript", "ospp.vbs", "/unpkey:6MWKP"], stdout=subprocess.DEVNULL)

# Instalar la nueva clave de producto
subprocess.run(["cscript", "ospp.vbs", "/inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP"])

# Configurar el host KMS
subprocess.run(["cscript", "ospp.vbs", "/sethst:e8.us.to"])

# Activar Office
subprocess.run(["cscript", "ospp.vbs", "/act"])
