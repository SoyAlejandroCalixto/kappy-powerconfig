$isScoopInstalled = Get-Command scoop -ErrorAction SilentlyContinue
if (-not $isScoopInstalled) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    if (!(Get-Command git -ErrorAction SilentlyContinue)) {
        winget install Git.Git # git is required as previous dependency for scoop installation
    }
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

enum PackageManager {
    scoop
    winget
}

function PkgsI {
    param ([string]$pm, [string[]]$p)
    
    foreach ($pkg in $p) {
        Write-Host "`nInstalling $pkg..." -ForegroundColor Green

        if ($pm -eq "scoop") {
            scoop install $pkg
        } else {
            winget install $pkg --silent --accept-package-agreements --accept-source-agreements
        }
    }
}