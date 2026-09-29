function github {
    param(
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

            $githubRoot = Join-Path $HOME "Documents\GitHub"
            $word = $wordToComplete.Trim("'`"") -replace '/', '\'

            # Path explícito (., .., .\x, ..\x, ~, C:\..., \x):
            # no devolvemos nada y PowerShell usa su autocompletado normal.
            if ($word -match '^(\.{1,2}(\\|$)|~|[A-Za-z]:|\\)') { return }

            $lastSep = $word.LastIndexOf('\')
            if ($lastSep -ge 0) {
                $parent = $word.Substring(0, $lastSep + 1)
                $leaf   = $word.Substring($lastSep + 1)
            }
            else {
                $parent = ''
                $leaf   = $word
            }

            $searchDir = Join-Path $githubRoot $parent
            if (!(Test-Path -LiteralPath $searchDir -PathType Container)) { return }

            $pattern = [WildcardPattern]::Escape($leaf) + '*'

            Get-ChildItem -LiteralPath $searchDir -Directory -ErrorAction SilentlyContinue |
                Where-Object { $_.Name -like $pattern } |
                ForEach-Object {
                    $text = "$parent$($_.Name)\"
                    if ($text -match "[\s']") {
                        $text = "'" + ($text -replace "'", "''") + "'"
                    }

                    [System.Management.Automation.CompletionResult]::new(
                        $text,
                        $_.Name,
                        [System.Management.Automation.CompletionResultType]::ParameterValue,
                        $_.FullName
                    )
                }
        })]
        [string]$subpath
    )

    $githubRoot = Join-Path $HOME "Documents\GitHub"

    # Sin argumento: ir a la raíz de GitHub.
    if ([string]::IsNullOrWhiteSpace($subpath)) {
        Set-Location -LiteralPath $githubRoot
        return
    }

    $normalized = $subpath -replace '/', '\'

    # Path explícito (., .., .\x, ..\x, ~, ruta absoluta):
    # respetar el directorio desde el que se ejecutó.
    if ($normalized -match '^(\.{1,2}(\\|$)|~)' -or [IO.Path]::IsPathRooted($normalized)) {
        Set-Location -LiteralPath $subpath
        return
    }

    # Nombre simple o subruta: asumir que está dentro de GitHub.
    Set-Location -LiteralPath (Join-Path $githubRoot $normalized)
}