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
        "Home N": "3KHY7-WNT83-DGQKR-F7HPR-844BM",
        "Single Language": "7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH",
        "Professional": "W269N-WFGWX-YVC9B-4J6C9-T83GX",
        "Professional N": "MH37W-N47XK-V7XM9-C7227-GCQG9",
        "Enterprise": "NPPR9-FWDCX-D2C8J-H872K-2YT43",
        "Enterprise N": "DPHK2-TTNVB-4X9Q3-TJR4H-KHJW4",
        "Enterprise LTSC": "M7XTQ-FN8P6-TTKYV-9D4CC-J462D",
        "Enterprise LTSB": "DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ",
        "Education": "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2",
        "Education N": "2WH4N-8QGBV-H22JP-CT43Q-MDWWJ"
    }

    for edition, key in claves.items():
        print(f"Activando Windows 10 {edition}...")
        activar_windows(key)
