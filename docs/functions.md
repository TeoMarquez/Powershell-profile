# Functions

Funciones personalizadas del perfil de PowerShell.

## `navigation.ps1`

| Comando             | Descripción                                |
| ------------------- | ------------------------------------------- |
| `github`          | Va a la raíz de`~/Documents/GitHub`.     |
| `github <path>`   | Va a un path relativo a la raíz de GitHub. |
| `github .\<path>` | Usa el directorio actual como base.         |

## `prompt.ps1`

| Comando       | Alias     | Descripción                                       |
| ------------- | --------- | -------------------------------------------------- |
| `shortpath` | `spath` | Muestra solamente la última carpeta en el prompt. |
| `fullpath`  | `fpath` | Muestra la ruta completa en el prompt.             |

## `install-powershell-context.ps1`

| Comando                       | Descripción                                                                   |
| ----------------------------- | ------------------------------------------------------------------------------ |
| `Install-PowerShellContext` | Agrega "Abrir PowerShell aqui" al menú contextual del Explorador de archivos. |

La opción permite abrir PowerShell directamente en la carpeta seleccionada o en la carpeta actual.

## `uninstall-powershell-context.ps1`

| Comando                         | Descripción                                                                     |
| ------------------------------- | -------------------------------------------------------------------------------- |
| `Uninstall-PowerShellContext` | Elimina "Abrir PowerShell aqui" del menú contextual del Explorador de archivos. |
