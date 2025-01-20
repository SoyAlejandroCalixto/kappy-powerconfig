. $PSScriptRoot\..\lib\PkgsI.ps1
Write-Host "`n-- Installing packages --" -ForegroundColor Blue

# winget packages
PkgsI -p @(
    'Microsoft.VisualStudioCode',
    'Microsoft.VisualStudio.2022.Community',
    'Microsoft.PowerToys',
    'DolphinEmulator.Dolphin',
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
    'Rainmeter.Rainmeter',
    'Telegram.TelegramDesktop',
    'Audacity.Audacity',
    'qBittorrent.qBittorrent',
    'Libretro.RetroArch',
    'HandBrake.HandBrake',
    'fastfetch',
    'Google.AndroidStudio',
    'Schniz.fnm',
    'Python.Python.3.13',
    'Spotify.Spotify',
)


# scoop buckets and packages
scoop bucket add games
scoop bucket add versions
scoop bucket add nerd-fonts

PkgsI -pm "scoop" -p @(
    'mingw',
    'versions/zed-nightly',
    'nerd-fonts/CascadiaCode-NF'
)

# packages that require admin privileges
PkgsI -pm "scoop" -p @( 
    'games/battlenet'
) -asAdmin

Write-Host "`nApplications provided by installer only will open their download pages in your browser for installation..." -ForegroundColor Green

$appsProvidedByInstaller = @(
    'https://suyu.dev/',
    'https://www.blackmagicdesign.com/es/products/davinciresolve',
    'https://www.amd.com/es/products/software/adrenalin.html'
)
foreach ($app in $appsProvidedByInstaller) {
    Start-Process $app
}
