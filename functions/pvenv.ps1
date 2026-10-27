
function pvenv {
    $argumentsList = @($args)

    # Ayuda
    if ($argumentsList.Count -eq 1 -and $argumentsList[0] -in @("--help", "--h", "-h")) {
        @"
pvenv - Gestion de entornos virtuales de Python

Uso:
  pvenv                  Activa .\venv
  pvenv <nombre>         Activa un entorno
  pvenv --init [nombre]  Crea un entorno (alias: --i)
  pvenv --list           Lista los entornos (alias: --ls)
  pvenv --del <nombre>   Elimina un entorno (alias: --d)
  pvenv --quit           Desactiva el entorno (alias: --q, -q)
  pvenv --help           Muestra esta ayuda (alias: --h)

Los entornos se crean, buscan y eliminan desde el directorio actual.
La activacion afecta a la sesion actual de PowerShell.
"@ | Write-Output
        return
    }

    # Validar cantidad de argumentos
    if ($argumentsList.Count -gt 2) {
        Write-Error "Uso: pvenv [nombre | --init [nombre] | --list | --del nombre | --help]"
        return
    }
    
    # Desactivar entorno virtual
    if ($argumentsList.Count -eq 1 -and $argumentsList[0] -in @("--quit", "--q", "-q")) {
        if (Test-Path Function:\deactivate) {
            deactivate
            return
        }

        Write-Host "No hay ningun entorno virtual activo."
        return
    }

    # Listar entornos virtuales
    if ($argumentsList.Count -eq 1 -and $argumentsList[0] -in @("--list", "--ls")) {
        $environments = Get-ChildItem -Directory | Where-Object {
            Test-Path -LiteralPath (Join-Path $_.FullName "pyvenv.cfg") -PathType Leaf
        }

        if (-not $environments) {
            Write-Host "No se encontraron entornos virtuales en el directorio actual."
            return
        }

        $environments | Select-Object Name, FullName
        return
    }

    # Determinar operacion y nombre
    $init = $false
    $delete = $false
    $name = "venv"

    if ($argumentsList.Count -gt 0) {
        switch ($argumentsList[0]) {
            { $_ -in @("--init", "--i") } {
                $init = $true
                if ($argumentsList.Count -eq 2) {
                    $name = $argumentsList[1]
                }
                break
            }
            { $_ -in @("--del", "--d") } {
                $delete = $true
                if ($argumentsList.Count -ne 2) {
                    Write-Error "Uso: pvenv --del <nombre>"
                    return
                }
                $name = $argumentsList[1]
                break
            }
            default {
                if ($argumentsList[0].StartsWith("-")) {
                    Write-Error "Argumento desconocido: $($argumentsList[0]). Usa pvenv --help."
                    return
                }
                $name = $argumentsList[0]
            }
        }
    }

    if ([string]::IsNullOrWhiteSpace($name)) {
        Write-Error "El nombre del entorno no puede estar vacio."
        return
    }

    # Resolver ruta desde el directorio actual
    $environmentPath = $ExecutionContext.SessionState.Path.
        GetUnresolvedProviderPathFromPSPath($name)

    # Crear entorno
    if ($init) {
        if (Test-Path -LiteralPath $environmentPath) {
            Write-Error "Ya existe la ruta '$name'. No se modifico."
            return
        }

        Write-Host "Creando entorno virtual: $name"
        & python -m venv $environmentPath

        if ($LASTEXITCODE -ne 0) {
            Write-Error "No se pudo crear el entorno virtual."
            return
        }

        Write-Host "Entorno creado correctamente: $name"
        return
    }

    # Eliminar entorno
    if ($delete) {
        $configPath = Join-Path $environmentPath "pyvenv.cfg"

        if (-not (Test-Path -LiteralPath $configPath -PathType Leaf)) {
            Write-Error "'$name' no parece ser un entorno virtual valido."
            return
        }

        $confirmation = Read-Host "Eliminar permanentemente el entorno '$name'? (s/N)"

        if ($confirmation -notin @("s", "S", "si", "SI", "sí", "Sí")) {
            Write-Host "Operacion cancelada."
            return
        }

        Remove-Item -LiteralPath $environmentPath -Recurse -Force
        Write-Host "Entorno eliminado: $name"
        return
    }

    # Activar entorno
    $activateScript = Join-Path $environmentPath "Scripts\Activate.ps1"

    if (-not (Test-Path -LiteralPath $activateScript -PathType Leaf)) {
        Write-Error "No se encontro un entorno virtual activable en '$name'."
        return
    }

    . $activateScript
    
}
