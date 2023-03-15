# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Configuración de variables
:local currentVersion [/system package get system version]
:local latestVersion ""
:local latestVersionUrl "http://download2.mikrotik.com/routeros/6.48.3/routeros-mipsbe-6.48.3.npk"

# Descargar la última versión de RouterOS
/tool fetch url=$latestVersionUrl mode=http

# Extraer el número de versión de la última versión descargada
:foreach i in=[/file find name~"routeros.*\.npk\$"] do={
   :set latestVersion [/file get $i name]
}

# Comparar la versión actual con la última versión
:if ($currentVersion != $latestVersion) do={
   # Instalar la última versión
   /system package update install=yes source=[/file find name~"routeros.*\.npk\$"]
   # Reiniciar el router después de la actualización
   /system reboot
}
