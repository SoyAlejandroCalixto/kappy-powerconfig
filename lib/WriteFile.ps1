function WriteFile {
    param ([string]$path, [string]$content)
    
    $dir = Split-Path $path
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
    $content > $path
}