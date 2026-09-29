
# Powershell-profile

Repositorio que contiene mi perfil personalizado de PowerShell.

El perfil está dividido en archivos según su responsabilidad para mantenerlo modular, fácil de mantener y versionar.

## ¿Qué hace?

Actualmente incluye:

- Funciones de navegación, como `github`.
- Personalización del prompt con `shortpath` / `spath` y `fullpath` / `fpath`.
- Autocompletado de módulos de Python para comandos como `python -m` y `poetry run python -m`.

## Estructura

```text
Powershell-profile/
├── profile.ps1
├── functions/
│   ├── navigation.ps1
│   └── prompt.ps1
├── completions/
│   └── python.ps1
└── docs/
    ├── functions.md
    └── completions.md
```
