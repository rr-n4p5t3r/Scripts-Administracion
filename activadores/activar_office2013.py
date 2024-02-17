import os
import subprocess

# Comprobar la existencia del archivo ospp.vbs en diferentes ubicaciones
office_paths = [
    os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office15"),
    os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office15"),
    os.path.join(os.getenv("ProgramFiles"), "Microsoft Office", "Office14"),
    os.path.join(os.getenv("ProgramFiles(x86)"), "Microsoft Office", "Office14")
]

ospp_vbs_path = None
for path in office_paths:
    if os.path.exists(os.path.join(path, "ospp.vbs")):
        ospp_vbs_path = path
        break

if ospp_vbs_path is None:
    print("No se encontró el archivo ospp.vbs en las ubicaciones esperadas.")
    exit(1)

# Instalar las claves de producto e intentar activar Office
keys_to_install = [
    "VYBBJ-TRJPB-QFQRF-QFT4D-H3GVB",
    "YC7DK-G2NP3-2QQC3-J6H88-GVGXT"
]

for key in keys_to_install:
    subprocess.run(["cscript", os.path.join(ospp_vbs_path, "ospp.vbs"), "/inpkey:" + key])

# Configurar el host KMS y el puerto KMS
subprocess.run(["cscript", os.path.join(ospp_vbs_path, "ospp.vbs"), "/sethst:s8.uk.to"])
subprocess.run(["cscript", os.path.join(ospp_vbs_path, "ospp.vbs"), "/setprt:1688"])

# Activar Office
subprocess.run(["cscript", os.path.join(ospp_vbs_path, "ospp.vbs"), "/act"])
