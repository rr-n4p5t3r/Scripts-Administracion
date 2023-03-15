# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar actualizacion automatica de firewall checkpoint

# Configuración de variables
:local updateServer "updates.checkpoint.com"
:local latestImage ""
:local downloadFolder "/var/log/updates"

# Obtener la imagen de actualización más reciente
/tool fetch url=("https://" . $updateServer . "/rss/subscribe.xml") mode=https dst-path="subscribe.xml"
:local rssFile [/file find where name="subscribe.xml"]
:if ($rssFile != "") do={
    :local latestLine [/file get $rssFile contents]
    :local latestMatch ([:toarray $latestLine] find ("\<link\>http://" . $updateServer . "/packages/") > 0)
    :if ([:len $latestMatch] > 0) do={
        :local latestLine $latestLine [[:pick $latestMatch 0] + 6 .. [:find $latestLine ".tgz" "from" [:pick $latestMatch 0] + 6]]
        :set latestImage ($updateServer . "/packages/" . $latestLine . ".tgz")
    }
    /file remove $rssFile
}

# Descargar la imagen de actualización más reciente
:if ($latestImage != "") do={
    :local downloadPath ("http://" . $latestImage)
    /file remove $downloadFolder
    /file mkdir $downloadFolder
    /tool fetch url=$downloadPath mode=http dst-path=($downloadFolder . "/" . $latestImage)
}

# Instalar la imagen de actualización descargada
:if ([:len [/usr/bin/fw_update -u -t tgz -s $downloadFolder/$latestImage]] > 0) do={
    /sbin/reboot
    :log info ("Actualización de imagen completada. Nueva versión: " . $latestImage)
} else{
    :log warning "No se pudo descargar la imagen de actualización."
}
