# scoop installation if not installed
$isScoopInstalled = Get-Command scoop -ErrorAction SilentlyContinue 

if (-not $isScoopInstalled) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

enum PackageManager {
    scoop
    winget
}

function PkgsI {
    param ([string]$pm, [string[]]$p, [switch]$asAdmin)
    
    foreach ($pkg in $p) {
        Write-Host "`nInstalling $pkg..." -ForegroundColor Green
        if ($pm -eq "scoop") {
            if ($asAdmin) {
                sudo scoop install $pkg
            } else {
                scoop install $pkg
            }
        } else {
            if ($asAdmin) {
                sudo winget install $pkg --silent --accept-package-agreements --accept-source-agreements
            } else {
                winget install $pkg --silent --accept-package-agreements --accept-source-agreements
            }
        }
    }
}
