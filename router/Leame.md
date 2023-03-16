***Script Actualiza Router Mikrotik***

En este script, la variable ***currentVersion*** se establece en la versión actual del sistema. Luego, se establece la variable ***latestVersionUrl*** en la URL de 
la última versión de ***RouterOS***.

El script descarga la última versión de RouterOS desde la URL proporcionada y utiliza un bucle para extraer el número de versión de la última versión 
descargada. A continuación, el script compara la versión actual con la última versión y, si son diferentes, instala la última versión y reinicia el 
router después de la actualización.

Ten en cuenta que debes actualizar la variable ***latestVersionUrl*** en el script con la URL correcta de la última versión de RouterOS antes de ejecutar el 
script en tu propio router Mikrotik.

***Script Backup Router Mikrotik***

En este script, la variable ***date*** y ***time*** se establecen utilizando el comando ***/system clock get*** para obtener la fecha y la hora actual del router Mikrotik. 
Luego, se establece la variable ***fileName*** como el nombre de archivo de la copia de seguridad utilizando la fecha y la hora obtenidas anteriormente.

El script crea una carpeta de backup (especificada en la variable ***backupFolder***) si no existe todavía. A continuación, se crea una copia de seguridad 
utilizando el comando ***/system backup save*** y se le asigna el nombre de archivo que se ha generado.

Por último, el script mueve el archivo de backup a la carpeta de backup recién creada utilizando el comando ***/file move***.

Ten en cuenta que puedes cambiar el nombre de la carpeta de backup y el formato del nombre de archivo de la copia de seguridad a tu gusto. Además, 
puedes programar la ejecución del script en el router Mikrotik utilizando el programador de tareas integrado en el sistema.
