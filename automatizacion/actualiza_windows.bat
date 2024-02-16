@echo off
:: Actualizar el sistema operativo usando Windows Update
schtasks /run /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
