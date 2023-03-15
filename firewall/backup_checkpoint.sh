# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar backup automatico de un firewall checkpoint

# Configuración de variables
:local backupFolder "/var/log/backups"
:local backupFile ("fwbackup_" . [/system clock get date] . "_" . [/system clock get time] . ".tgz")

# Crear la carpeta de respaldo si no existe
:if ([:len [/file find where name=$backupFolder]] = 0) do={
    /file mkdir $backupFolder
}

# Crear una copia de seguridad
:if ([:len [/usr/bin/backup -b $backupFolder/$backupFile]] > 0) do={
    :log info ("Copia de seguridad creada correctamente en la ubicación: " . $backupFolder . "/" . $backupFile)
} else {
    :log warning "No se pudo crear la copia de seguridad."
}
