# Powershell-profile

Repositorio que contiene mi perfil personalizado de PowerShell.

El perfil está dividido en archivos según su responsabilidad para mantenerlo modular, fácil de mantener y versionar.

## ¿Qué hace?

Actualmente incluye:

- Funciones de navegación, como `github`.
- Personalización del prompt con `shortpath` / `spath` y `fullpath` / `fpath`.
- Autocompletado de módulos de Python para comandos como `python -m` y `poetry run python -m`.
- Integración con el menú contextual del Explorador para abrir PowerShell directamente en una carpeta.

## Estructura

```text
Powershell-profile/
├── profile.ps1
├── functions/
│   ├── navigation.ps1
│   ├── prompt.ps1
│   ├── install-powershell-context.ps1
│   └── uninstall-powershell-context.ps1
├── completions/
│   └── python.ps1
└── docs/
    ├── functions.md
    └── completions.md
```
