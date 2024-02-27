git diff | Out-File -FilePath diff_log.txt
$blockNumber = 0
$blockContent = @()

Get-Content diff_log.txt | ForEach-Object {
    if ($_ -match '^diff --git') {
        if ($blockContent.Count -gt 0) {
            $blockContent | Out-File -FilePath ("diff_block_" + $blockNumber + ".diff")
            $blockNumber++
            $blockContent = @()
        }
    }
    $blockContent += $_
}

# Escribir el último bloque si queda alguno
if ($blockContent.Count -gt 0) {
    $blockContent | Out-File -FilePath ("diff_block_" + $blockNumber + ".diff")
}

Remove-Item diff_log.txt