function convert {
    $convertDll = 'C:\Users\Mateo\Documents\GitHub\personal\convert-imageType\bin\Release\net9.0\convert.dll'
    if (-not (Test-Path -LiteralPath $convertDll -PathType Leaf)) {
        throw "No se encontró la CLI compilada en '$convertDll'. Compila el proyecto con 'dotnet build -c Release'."
    }

    if (-not $env:FFMPEG_PATH) {
        $installedFfmpeg = 'C:\Users\Mateo\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg.Essentials_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.1-essentials_build\bin\ffmpeg.exe'
        if (Test-Path -LiteralPath $installedFfmpeg -PathType Leaf) {
            $env:FFMPEG_PATH = $installedFfmpeg
        }
    }

    & dotnet $convertDll @args
}
