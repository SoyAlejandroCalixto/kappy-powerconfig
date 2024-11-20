. $PSScriptRoot\..\lib\config.ps1
Write-Host "`n-- SETTINGS SETUP --" -ForegroundColor Blue

Write-Host "`nPersonalization setup..." -ForegroundColor Green
SetTheme dark
TaskbarCentered $true

Write-Host "`nMiscellaneous tasks setup..." -ForegroundColor Green
MouseAcceleration $false
AutomaticUpdates $false