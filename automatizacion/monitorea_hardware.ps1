# Obtener información del sistema, incluida la temperatura de la CPU
Get-WmiObject -Namespace "root\cimv2" -Class Win32_TemperatureProbe
