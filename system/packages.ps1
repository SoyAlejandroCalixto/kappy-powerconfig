. $PSScriptRoot\..\lib\PkgsI.ps1
Write-Host "`n-- INSTALLING PACKAGES --" -ForegroundColor Blue

# winget packages ->
PkgsI -p @(
    'Microsoft.VisualStudioCode',
    'Microsoft.VisualStudio.2022.Community',
    'Microsoft.PowerToys',
    'DolphinEmulator.Dolphin',
    'PCSX2Team.PCSX2',
    'Brave.Brave',
    'Nvidia.GeForceExperience',
    'VideoLAN.VLC',
    'Git.Git',
    'Spotify.Spotify',
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
    'RamenSoftware.Windhawk',
    'Google.AndroidStudio',
    'Schniz.fnm',
    'Python.Python.3.13'
)

# scoop buckets and packages ->
scoop bucket add games
scoop bucket add versions

PkgsI -pm "scoop" -p @(
    'games/battlenet'
    'versions/zed-nightly'
)

Write-Host "`nApplications provided by installer only will open their download pages in your browser for installation..." -ForegroundColor Green

$appsProvidedByInstaller = @(
    'https://suyu.dev/',
    'https://www.blackmagicdesign.com/es/products/davinciresolve',
    'https://www.meldaproduction.com/downloads',
    'https://www.voxengo.com/product/marvelgeq/'
)
foreach ($app in $appsProvidedByInstaller) {
    Start-Process $app
}