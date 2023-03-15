# Creado por n4p5t3r 
# Email: ciberseguridad@rrsolucionesit.com
# Descripcion: script para realizar actualizacion automatica de un firewall paloalto

# Configuración de variables
:local updateServer "updates.paloaltonetworks.com"
:local latestImage ""
:local downloadFolder "updates"

# Obtener la imagen de actualización más reciente
/tool fetch url=("https://" . $updateServer . "/rss/panupv2") mode=https dst-path="update.rss"
:local rssFile [/file find where name="update.rss"]
:if ($rssFile != "") do={
    :local latestLine [/file get $rssFile contents]
    :local latestMatch ([:toarray $latestLine] find ("href=\"" . $updateServer . "/software/panos/") > 0)
    :if ([:len $latestMatch] > 0) do={
        :local latestLine $latestLine [[:pick $latestMatch 0] + 5 .. [:find $latestLine "\" "from" [:pick $latestMatch 0] + 5]]
        :set latestImage ($updateServer . "/software/panos/" . $latestLine)
    }
    /file remove $rssFile
}

# Descargar la imagen de actualización más reciente
:if ($latestImage != "") do={
    :local downloadPath ("tftp://" . $latestImage)
    /file remove $downloadFolder
    /file mkdir $downloadFolder
    /tool fetch url=$downloadPath mode=tftp dst-path=($downloadFolder . "/image.tgz")
}

# Instalar la imagen de actualización descargada
:if ([:len [/swm/download-image version=$latestImage]] > 0) do={
    /swm/install-image file-path=($downloadFolder . "/image.tgz")
    :log info ("Actualización de imagen completada. Nueva versión: " . $latestImage)
} else={
    :log warning "No se pudo descargar la imagen de actualización."
}
