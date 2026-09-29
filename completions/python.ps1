function Complete-PythonModule {
    param(
        $wordToComplete,
        $commandAst,
        $cursorPosition
    )

    $elements = $commandAst.CommandElements

    # "python".
    $pythonNames = @(
        "python",
        "python.exe",
        "python3",
        "py"
    )

    # Carpetas que nunca son módulos.
    $excludedDirs = @(
        "node_modules",
        "venv",
        "env",
        "dist",
        "build",
        "site-packages"
    )

    # Buscar "python -m" dentro de los argumentos.
    $pythonIndex = -1
    $moduleIndex = -1

    for ($i = 0; $i -lt $elements.Count; $i++) {
        $value = $elements[$i].Extent.Text.Trim("'`"")

        if ($value -in $pythonNames) {
            $pythonIndex = $i
        }

        if ($pythonIndex -ge 0 -and $value -eq "-m") {
            $moduleIndex = $i
            break
        }
    }

    # Si no estamos después de "python -m", no hacemos nada.
    if ($moduleIndex -eq -1) {
        return
    }

    # Obtener la parte del módulo que ya escribió el usuario.
    $partial = $wordToComplete.Trim("'`"")

    # La raíz es donde estamos parados al ejecutar el comando.
    $root = (Get-Location).Path

    # Separar:
    #
    # extractor.ex
    # └───────┘
    #
    # extractor.
    # └───────┘
    #
    $lastDot = $partial.LastIndexOf(".")

    if ($lastDot -ge 0) {
        $modulePrefix = $partial.Substring(0, $lastDot)
        $partialName = $partial.Substring($lastDot + 1)

        $searchDirectory = Join-Path `
            $root `
            ($modulePrefix -replace "\.", [IO.Path]::DirectorySeparatorChar)

        $outputPrefix = "$modulePrefix."
    }
    else {
        $modulePrefix = ""
        $partialName = $partial

        $searchDirectory = $root
        $outputPrefix = ""
    }

    # Si la carpeta no existe, no hay módulos para completar.
    if (!(Test-Path $searchDirectory -PathType Container)) {
        return
    }

    # Archivos Python.
    Get-ChildItem `
        -Path $searchDirectory `
        -File `
        -Filter "*.py" `
        -ErrorAction SilentlyContinue |
    Where-Object {
        $_.BaseName -ne "__init__" -and
        $_.BaseName -like "$partialName*"
    } |
    ForEach-Object {

        $moduleName = "$outputPrefix$($_.BaseName)"

        [System.Management.Automation.CompletionResult]::new(
            $moduleName,
            $moduleName,
            [System.Management.Automation.CompletionResultType]::ParameterValue,
            $moduleName
        )
    }

    # Directorios Python.
    Get-ChildItem `
        -Path $searchDirectory `
        -Directory `
        -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -notlike "__*" -and
        $_.Name -notlike ".*" -and
        $_.Name -notin $excludedDirs -and
        $_.Name -like "$partialName*"
    } |
    ForEach-Object {

        $moduleName = "$outputPrefix$($_.Name)"

        [System.Management.Automation.CompletionResult]::new(
            $moduleName,
            $moduleName,
            [System.Management.Automation.CompletionResultType]::ParameterValue,
            $moduleName
        )
    }
}


Register-ArgumentCompleter -Native `
    -CommandName python, python.exe, python3, py, poetry, uv `
    -ScriptBlock {
        param(
            $wordToComplete,
            $commandAst,
            $cursorPosition
        )

        Complete-PythonModule `
            -wordToComplete $wordToComplete `
            -commandAst $commandAst `
            -cursorPosition $cursorPosition
    }