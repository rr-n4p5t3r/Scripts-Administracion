import os
import subprocess

# Cambiar el directorio al de instalación de Office 2021
os.chdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16"))

# Intentar cambiar al directorio de 32 bits si no existe el de 64 bits
if not os.path.isdir(os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office16")):
    os.chdir(os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office16"))

# Obtener el nombre del archivo de licencia
for file_name in os.listdir(os.path.join("..", "root", "Licenses16")):
    if file_name.startswith("ProPlus2021VL_KMS") and file_name.endswith(".xrm-ms"):
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
subprocess.run(["cscript", "ospp.vbs", "/unpkey:6F7TH"], stdout=subprocess.DEVNULL)

# Instalar la nueva clave de producto
subprocess.run(["cscript", "ospp.vbs", "/inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH"])

# Configurar el host KMS
subprocess.run(["cscript", "ospp.vbs", "/sethst:e8.us.to"])

# Activar Office
subprocess.run(["cscript", "ospp.vbs", "/act"])
