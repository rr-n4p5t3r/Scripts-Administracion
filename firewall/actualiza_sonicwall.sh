# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para actualziar de forma automatica un firewall sonciwall

# Configuración de variables
:local updateUrl "https://download.sonicwall.com/sgms/"
:local firmwareName "sonicwall_firmware.sma"
:local backupFolder "/var/log/backups"
:local backupFile ("fwbackup_" . [/system clock get date] . "_" . [/system clock get time] . ".exp")

# Crear la carpeta de respaldo si no existe
:if ([:len [/file find where name=$backupFolder]] = 0) do={
    /file mkdir $backupFolder
}

# Realizar una copia de seguridad antes de la actualización
:if ([:len [/usr/bin/sonicwall_backup -d $backupFolder/$backupFile]] > 0) do={
    :log info ("Copia de seguridad creada correctamente en la ubicación: " . $backupFolder . "/" . $backupFile)
} else {
    :log warning "No se pudo crear la copia de seguridad."
}

# Descargar la actualización
/tool fetch url=($updateUrl . $firmwareName) mode=https dst-path=$backupFolder/$firmwareName

# Verificar si la descarga fue exitosa
:if ([:len [/file find where name=$backupFolder/$firmwareName]] > 0) do={
    :log info "Descarga exitosa del archivo de actualización"
} else {
    :log warning "La descarga del archivo de actualización ha fallado"
}

# Iniciar la actualización
:if ([:len [/usr/bin/firmware_update -f $backupFolder/$firmwareName]] > 0) do={
    :log info "Actualización iniciada"
} else {
    :log warning "La actualización ha fallado"
}
