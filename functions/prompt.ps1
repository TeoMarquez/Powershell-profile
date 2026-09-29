$global:ShortPathPrompt = $false

function prompt {
    $location = (Get-Location).Path

    if ($global:ShortPathPrompt) {
        $folder = Split-Path $location -Leaf

        if ([string]::IsNullOrEmpty($folder)) {
            $folder = $location
        }

        "PS ...\$folder> "
    }
    else {
        "PS $location> "
    }
}

function shortpath {
    $global:ShortPathPrompt = $true
}

function fullpath {
    $global:ShortPathPrompt = $false
}

Set-Alias spath shortpath
Set-Alias fpath fullpath