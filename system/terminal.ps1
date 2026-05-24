. $PSScriptRoot\..\lib\PkgsI.ps1
. $PSScriptRoot\..\lib\WriteFile.ps1
Write-Host "`n-- Terminal setup --" -ForegroundColor Blue

# profile (.zshrc equivalent for powershell)
WriteFile -path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -content @"
clear
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
atuin init powershell | Out-String | Invoke-Expression
(&mise activate pwsh) | Out-String | Invoke-Expression
Invoke-Expression "$(direnv hook pwsh)"
Import-Module Terminal-Icons
Set-Alias vim nvim
"@

# powershell modules
gsudo Install-Module -Name Terminal-Icons -Repository PSGallery
gsudo Install-Module -Name PSReadLine -AllowClobber -Force

# starship config
WriteFile -path "$env:USERPROFILE\.config\starship.toml" -content (Invoke-RestMethod "https://raw.githubusercontent.com/SoyAlejandroCalixto/arch4devs/refs/heads/main/.config/starship.toml")
