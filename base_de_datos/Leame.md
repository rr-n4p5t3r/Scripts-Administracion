***Script Backup PostgreSQL***

Este script utiliza el comando ***pg_dump para*** crear un archivo de backup de la base de datos especificada en formato comprimido. 
El archivo se guarda en un directorio especificado en la variable ***BACKUP_DIR***, y se le asigna un nombre basado en el nombre de la base de datos y la fecha y 
hora actuales.

También incluye una línea que elimina automáticamente los backups antiguos (más de 7 días) para evitar que el directorio de backups se llene con archivos 
innecesarios. Si deseas mantener backups más antiguos, puedes cambiar el número ***7*** en la línea ***find*** a un número mayor.

***Script Backup MySQL***

Este script utiliza el comando ***mysqldump*** para crear un archivo de backup de la base de datos especificada en formato comprimido. 
El archivo se guarda en un directorio especificado en la variable ***BACKUP_DIR***, y se le asigna un nombre basado en el nombre de la base de datos y la fecha 
y hora actuales.

También incluye una línea que elimina automáticamente los backups antiguos (más de 7 días) para evitar que el directorio de backups se llene con 
archivos innecesarios. Si deseas mantener backups más antiguos, puedes cambiar el número ***7*** en la línea ***find*** a un número mayor.

***Script Backup Oracle***

Este script utiliza el comando ***exp*** para crear un archivo de backup de la base de datos especificada en formato comprimido. El archivo se guarda en un directorio 
especificado en la variable ***BACKUP_DIR***, y se le asigna un nombre basado en el ***SID*** de la base de datos y la fecha y hora actuales.

También incluye una línea que elimina automáticamente los backups antiguos (más de 7 días) para evitar que el directorio de backups se llene con archivos 
innecesarios. Si deseas mantener backups más antiguos, puedes cambiar el número ***7*** en la línea ***find*** a un número mayor.

***Script Backup SQL Server***

Este script utiliza el comando ***sqlcmd*** para crear un archivo de backup de la base de datos especificada en formato comprimido. El archivo se guarda en un 
directorio especificado en la variable ***BACKUP_DIR***, y se le asigna un nombre basado en el nombre de la base de datos y la fecha y hora actuales.

También incluye una línea que elimina automáticamente los backups antiguos (más de 7 días) para evitar que el directorio de backups se llene con 
archivos innecesarios. Si deseas mantener backups más antiguos, puedes cambiar el número ***7*** en la línea ***find*** a un número mayor.
