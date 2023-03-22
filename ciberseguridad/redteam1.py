# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para escanear puertos en una direccion IP predeterminada

import socket

def scan_port(ip_address, port):
    """
    Esta función se utiliza para escanear un puerto en una dirección IP.
    Devuelve verdadero si el puerto está abierto y falso si está cerrado.
    """
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(2)
        result = sock.connect_ex((ip_address, port))
        if result == 0:
            return True
        else:
            return False
    except Exception as e:
        print(f"Error al escanear el puerto {port}: {e}")
        return False

def main():
    # Dirección IP y rango de puertos a escanear
    ip_address = "127.0.0.1"
    start_port = 1
    end_port = 1024

    # Escaneo de puertos
    for port in range(start_port, end_port+1):
        if scan_port(ip_address, port):
            print(f"El puerto {port} está abierto en {ip_address}")
        else:
            print(f"El puerto {port} está cerrado en {ip_address}")

if __name__ == "__main__":
    main()
