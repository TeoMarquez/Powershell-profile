# Powershell-profile

Repositorio que contiene mi perfil personalizado de PowerShell.

El perfil está dividido en archivos según su responsabilidad para mantenerlo modular, fácil de mantener y versionar.

## ¿Qué hace?

Actualmente incluye:

* Funciones de navegación, como `github`.
* Personalización del prompt con `shortpath` / `spath` y `fullpath` / `fpath`.
* Autocompletado de módulos de Python para comandos como `python -m` y `poetry run python -m`.
* Integración con el menú contextual del Explorador para abrir PowerShell directamente en una carpeta.
* Integración con la herramienta de [convert-imageType](https://github.com/TeoMarquez/convert-imageType).

## Instalación

El repositorio no reemplaza directamente el archivo `$PROFILE` de PowerShell. En su lugar, el `$PROFILE` puede utilizarse como punto de entrada para cargar el perfil versionado.

Por ejemplo, si el repositorio se encuentra en:

```powershell
$HOME\Documents\GitHub\personal\Powershell-profile
```

agrega lo siguiente al archivo `$PROFILE`:

```powershell
$ProfileRepo = Join-Path $HOME "Documents\GitHub\personal\Powershell-profile"

. "$ProfileRepo\profile.ps1"
```

De esta forma, `$PROFILE` solamente se encarga de localizar el repositorio y cargar `profile.ps1`. El resto de la configuración permanece dentro del repositorio y puede versionarse mediante Git.

Si el repositorio se encuentra en otra ubicación, modifica `$ProfileRepo` para apuntar a ella.

## Estructura

```text
Powershell-profile/
├── profile.ps1
├── functions/
│   ├── navigation.ps1
│   ├── prompt.ps1
│   ├── install-powershell-context.ps1
│   ├── uninstall-powershell-context.ps1
│   └── convert-image.ps1
├── completions/
│   └── python.ps1
└── docs/
    ├── functions.md
    └── completions.md
```
