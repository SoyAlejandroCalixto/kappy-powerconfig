. $PSScriptRoot\..\lib\PkgsI.ps1
Write-Host "`n-- Installing packages --" -ForegroundColor Blue

# winget packages
PkgsI -p @(
    'Microsoft.PowerToys',
    'PCSX2Team.PCSX2',
    'Brave.Brave',
    'VideoLAN.VLC',
    'Git.Git',
    'OBSProject.OBSStudio',
    'Bitwarden.Bitwarden',
    'Discord.Discord',
    'M2Team.NanaZip',
    'WhatsApp',
    'Valve.Steam',
    'qBittorrent.qBittorrent',
    'Libretro.RetroArch',
    'HandBrake.HandBrake',
    'fastfetch',
    'Canva.Affinity',
    'Microsoft.VisualStudioCode',
    'Stremio.Stremio',
    'Starship.Starship',
    'Microsoft.PowerShell',
    'Neovim.Neovim',
    'gerardog.gsudo',
    'fzf',
    'yt-dlp',
    'sxyazi.yazi',
    'ajeetdsouza.zoxide',
    'Atuinsh.Atuin',
    'jdx.mise',
    'direnv.direnv'
)

# scoop buckets and packages
scoop bucket add extras
scoop bucket add games
scoop bucket add versions
scoop bucket add nerd-fonts

PkgsI -pm "scoop" -p @(
    'mingw',
    'nerd-fonts/CascadiaCode-NF',
    'games/dolphin-dev',
    'games/eden',
    'extras/pear-desktop',
)

Write-Host "`nApplications provided by installer only will open their download pages in your browser for installation..." -ForegroundColor Green

$appsProvidedByInstaller = @(
    'https://www.amd.com/es/support/download/drivers.html'
)
foreach ($app in $appsProvidedByInstaller) {
    Start-Process $app
}
