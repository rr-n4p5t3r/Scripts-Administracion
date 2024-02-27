# Configuración inicial
$repositorio = "usuario/repositorio"  # Cambia esto por tu nombre de usuario y nombre del repositorio en GitHub
$ruta_repositorio_local = "C:\Ruta\A\Tu\Repositorio\Local"  # Cambia esto por la ruta a tu repositorio local

# Añadir la URL remota del repositorio de GitHub
function ConfigurarRemoto {
    # Cambiar directorio al repositorio local
    Set-Location $ruta_repositorio_local
    
    # Agregar la URL remota del repositorio de GitHub
    git remote add origin "https://github.com/$repositorio.git"
}

# Función para realizar el commit y empujar los cambios a GitHub
function RealizarCommit {
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $mensaje_commit = "Commit automático realizado el $fecha"
    
    # Cambiar directorio al repositorio local
    Set-Location $ruta_repositorio_local
    
    # Agregar todos los cambios al área de preparación
    git add .
    
    # Realizar el commit con el mensaje especificado
    git commit -m $mensaje_commit
    
    # Empujar los cambios al repositorio remoto en GitHub
    git push origin main  # Cambia 'main' por el nombre de tu rama si es diferente
}

# Función principal para ejecutar el script cada 15 minutos
function EjecutarScript {
    # Configurar el repositorio remoto
    ConfigurarRemoto
    
    # Bucle infinito para ejecutar el script cada 15 minutos
    while ($true) {
        # Realizar el commit y empujar los cambios
        RealizarCommit
        
        # Esperar 15 minutos antes de volver a ejecutar
        Start-Sleep -Seconds (15 * 60)
    }
}

# Llamada a la función principal
EjecutarScript
