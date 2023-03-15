# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar backup automatico de un router mikrotik

# Configuración de variables
:local backupFolder "/backup"
:local backupName ([/system identity get name] . "-" . [/system clock get date] . "-" . [/system clock get time])
:local backupFile ($backupFolder . "/" . $backupName . ".backup")

# Crear la carpeta de backups si no existe
/file print detail where name=$backupFolder
:if ([:len [/file find where name=$backupFolder]] = 0) do={
    /file mkdir $backupFolder
}

# Crear el backup
/system backup save name=$backupName password=""
:delay 5s

# Verificar si se creó el archivo de backup y copiarlo a la carpeta de backups
:if ([:len [/file find where name=$backupName.backup]] > 0) do={
   /file copy source=$backupName.backup destination=$backupFile
}

# Eliminar los backups antiguos (si existen más de 7)
:local backups [:len [/file find where name~".*\.backup"]]
:if ($backups > 7) do={
   :local toRemove ($backups - 7)
   :local files [/file find where name~".*\.backup" sort=creation]
   :foreach i in=($files) do={
      :if ($toRemove > 0) do={
         /file remove $i
         :set toRemove ($toRemove - 1)
      }
   }
}
