. $PSScriptRoot\..\lib\config.ps1
Write-Host "`n-- Settings setup --" -ForegroundColor Blue

SetTheme dark
TaskbarCentered $true
MouseAcceleration $false
AutomaticUpdates $false
TaskbarSearchBar $false
TaskView $false

AddStartupApp -name "rainmeter" -path "C:\Program Files\Rainmeter\Rainmeter.exe"