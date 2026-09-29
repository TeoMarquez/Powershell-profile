function Install-PowerShellContext {
    $pwsh = (Get-Command powershell.exe).Source

    $command = "`"$pwsh`" -NoExit -Command `"Set-Location -LiteralPath '%V'`""

    # Carpetas
    $folderKey = "HKCU:\Software\Classes\Directory\shell\OpenPowerShellHere"
    $folderCommand = "$folderKey\command"

    New-Item -Path $folderKey -Force | Out-Null
    Set-ItemProperty -Path $folderKey -Name "(Default)" -Value "Abrir PowerShell aqui"
    Set-ItemProperty -Path $folderKey -Name "Icon" -Value "$pwsh"

    New-Item -Path $folderCommand -Force | Out-Null
    Set-ItemProperty -Path $folderCommand -Name "(Default)" -Value $command

    # Fondo de carpetas
    $backgroundKey = "HKCU:\Software\Classes\Directory\Background\shell\OpenPowerShellHere"
    $backgroundCommand = "$backgroundKey\command"

    New-Item -Path $backgroundKey -Force | Out-Null
    Set-ItemProperty -Path $backgroundKey -Name "(Default)" -Value "Abrir PowerShell aqui"
    Set-ItemProperty -Path $backgroundKey -Name "Icon" -Value "$pwsh"

    New-Item -Path $backgroundCommand -Force | Out-Null
    Set-ItemProperty -Path $backgroundCommand -Name "(Default)" -Value $command

    Write-Host "PowerShell agregado al menu contextual." -ForegroundColor Green
}