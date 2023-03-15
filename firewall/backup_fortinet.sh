# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar backup automatico de un firewall fortinet

# Configuración de variables
:local date [/system clock get date]
:local time [/system clock get time]
:local fileName ("backup-" . $date . "-" . $time . ".conf")
:local backupFolder "backup"

# Crear la carpeta de backup si no existe
:if ([:len [/disk/volume/getall]] > 0) do={
    :local rootPath [/disk/volume/getall where (status="Healthy" and name="root") value-name=path]
    :local backupPath ($rootPath . $backupFolder)
    :if ([:len [/file/find $backupPath]] = 0) do={
        /file mkdir $backupPath
    }
}

# Crear una copia de seguridad
/backup/config $fileName

# Mover el archivo de backup a la carpeta de backup
/file move $fileName ($backupPath . "/" . $fileName)
