# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar monitoreo de los servicios de php en linux

import psutil
import time

while True:
    # Obtener una lista de todos los procesos que coinciden con el nombre de PHP
    php_procs = [p for p in psutil.process_iter(attrs=['pid', 'name']) if 'php' in p.info['name']]
    
    if len(php_procs) > 0:
        # Si se encontraron procesos de PHP, obtener el uso de CPU y memoria
        cpu_usage = sum(p.cpu_percent() for p in php_procs)
        mem_usage = sum(p.memory_info().rss for p in php_procs)
        print(f"Uso de CPU: {cpu_usage}%\tUso de memoria: {mem_usage/1024/1024:.2f} MB")
    else:
        # Si no se encontraron procesos de PHP, mostrar un mensaje
        print("No se encontraron procesos de PHP")
    
    # Esperar 5 segundos antes de volver a comprobar
    time.sleep(5)
