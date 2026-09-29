function Uninstall-PowerShellContext {
    $folderKey = "HKCU:\Software\Classes\Directory\shell\OpenPowerShellHere"
    $backgroundKey = "HKCU:\Software\Classes\Directory\Background\shell\OpenPowerShellHere"

    Remove-Item $folderKey -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item $backgroundKey -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "PowerShell eliminado del menu contextual." -ForegroundColor Green
}