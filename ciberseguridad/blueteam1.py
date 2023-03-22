# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para detectar actividades sospechosas sobre un dispositivo o servicio y enviarlo por 
# correo electronico

import os
import smtplib

# Ruta del archivo de registro
log_file = "/var/log/syslog"

# Patrón de búsqueda de actividad sospechosa
pattern = "ataque"

# Función para buscar el patrón en el archivo de registro
def search_log_file(log_file, pattern):
    with open(log_file, "r") as f:
        for line in f:
            if pattern in line:
                return True
    return False

# Si se detecta actividad sospechosa, envía una notificación por correo electrónico al equipo Blue Team
if search_log_file(log_file, pattern):
    sender_email = "blue_team@example.com"
    receiver_email = "blue_team_alerts@example.com"
    password = "my_password"
    message = "Se ha detectado actividad sospechosa en el archivo de registro."

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message)
    server.quit()

    print("Se ha enviado una notificación al equipo Blue Team.")
else:
    print("No se ha detectado actividad sospechosa.")
