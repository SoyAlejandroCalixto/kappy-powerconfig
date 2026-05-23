. $PSScriptRoot\..\lib\PkgsI.ps1
. $PSScriptRoot\..\lib\WriteFile.ps1
Write-Host "`n-- Terminal setup --" -ForegroundColor Blue

# terminal packages
PkgsI -p @(
    'JanDeDobbeleer.OhMyPosh',
    'wez.wezterm',
    'Microsoft.PowerShell',
    'Neovim.Neovim',
    'gerardog.gsudo',
    'fzf',
    'gokcehan.lf',
    'yt-dlp'
)

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

# wezterm config
WriteFile -path "$env:USERPROFILE\.wezterm.lua" -content @"


"@

# oh my posh config
WriteFile -path "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" -content @"
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

shell-integration = zsh
shell-integration-features = ssh-env,ssh-terminfo
window-theme = ghostty
"@
