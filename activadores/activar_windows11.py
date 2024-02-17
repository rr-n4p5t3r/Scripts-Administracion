import subprocess

def activar_windows(clave_producto):
    # Instalar la clave de producto
    subprocess.run(["slmgr", "/ipk", clave_producto])

    # Configurar el servidor KMS
    subprocess.run(["slmgr", "/skms", "kms8.msguides.com"])

    # Activar Windows
    subprocess.run(["slmgr", "/ato"])

if __name__ == "__main__":
    claves = {
        "Home": "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99",
        "Pro": "W269N-WFGWX-YVC9B-4J6C9-T83GX",
        "Education": "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2",
        "Enterprise": "NPPR9-FWDCX-D2C8J-H872K-2YT43"
    }

    for edition, key in claves.items():
        print(f"Activando Windows 11 {edition}...")
        activar_windows(key)
