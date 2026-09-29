# ==========================================
# PowerShell Profile
# ==========================================

$ProfileRoot = $PSScriptRoot

# Functions
. "$ProfileRoot\functions\navigation.ps1"
. "$ProfileRoot\functions\prompt.ps1"
. "$ProfileRoot\functions\install-powershell-context.ps1"
. "$ProfileRoot\functions\uninstall-powershell-context.ps1"

# Completions
. "$ProfileRoot\completions\python.ps1"