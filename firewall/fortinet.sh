# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Configuración de variables
:local currentVersion [/sys version | find "FortiOS"]
:local latestVersionUrl "https://support.fortinet.com/Download/FirmwareImages.aspx"

# Descargar la última versión de FortiOS
/tool fetch url=$latestVersionUrl mode=https dst-path=/latestFortiOS.html

# Extraer el número de versión de la última versión descargada
:local latestVersion [/tool fetch url=($latestVersionUrl) mode=https http-method=get http-data="os=1" dst-path=- | /tool fetch parse mode=html | /tool fetch find src-path="//a[contains(@href,'FortiOS')]" src-pattern="FortiOS[0-9]+\.[0-9]+(\.[0-9]+)?" | /tool fetch replace pattern="^FortiOS" replace-with=""]

# Comparar la versión actual con la última versión
:if ($currentVersion != $latestVersion) do={
   # Descargar la última versión de FortiOS
   :local latestVersionDownloadUrl ("https://support.fortinet.com/Download/FilesDownload.aspx?FileType=FortiOS&product="+[/sys hardware | find "FGT"]+"&release="+$latestVersion)
   /tool fetch url=$latestVersionDownloadUrl mode=https dst-path=/latestFortiOS.img

   # Instalar la última versión
   /sys upgrade image=/latestFortiOS.img
}
