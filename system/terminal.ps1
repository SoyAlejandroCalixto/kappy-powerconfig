. $PSScriptRoot\..\lib\PkgsI.ps1
. $PSScriptRoot\..\lib\WriteFile.ps1
Write-Host "`n-- Terminal setup --" -ForegroundColor Blue

# profile
WriteFile -path $PROFILE -content @"
clear
Invoke-Expression (&starship init powershell)
Import-Module Terminal-Icons
Set-Alias vim nvim
"@

# powershell modules
gsudo Install-Module -Name Terminal-Icons -Repository PSGallery
gsudo Install-Module -Name PSReadLine -AllowClobber -Force

# oh my posh config
WriteFile -path "$env:USERPROFILE\AppData\Local\Programs\\ghostty\config\config.ghostty" -content @"
theme = Catppuccin Macchiato
font-family = CaskaydiaCove Nerd Font
font-size = 14
font-thicken = true

window-padding-x = 8
window-padding-y = 8
background-opacity = 0.8
background-blur = 20

cursor-style = bar
cursor-style-blink = true

shell-integration-features = ssh-env,ssh-terminfo
"@
