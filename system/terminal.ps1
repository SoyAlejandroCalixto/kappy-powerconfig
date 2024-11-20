. $PSScriptRoot\..\lib\PkgsI.ps1
. $PSScriptRoot\..\lib\WriteFile.ps1
Write-Host "`n-- TERMINAL SETUP --" -ForegroundColor Blue

Write-Host "`nInstalling terminal packages..." -ForegroundColor Green

PkgsI -p @(
    'JanDeDobbeleer.OhMyPosh',
    'wez.wezterm',
    'Microsoft.PowerShell'
)

Write-Host "`nInstalling PowerShell modules..." -ForegroundColor Green

if (-not (Get-Module Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Repository PSGallery
}
if (-not (Get-Module PSReadLine)) {
    Install-Module -Name PSReadLine -AllowClobber -Force
}

Write-Host "`n`$PROFILE setup..." -ForegroundColor Green

WriteFile -path $PROFILE -content @"

oh-my-posh init pwsh --config "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" | Invoke-Expression
fastfetch --logo "Windows" --color blue --title-color-at green --separator-output-color green -s title:separator:os:kernel:uptime:shell:terminal:cpuUsage:memory:disk:custom:colors
Import-Module Terminal-Icons
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

"@

Write-Host "`nWezTerm setup..." -ForegroundColor Green

WriteFile -path "$env:USERPROFILE\.wezterm.lua" -content @"

local wezterm = require("wezterm")
return {
	font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
	font_size = 12.0,
	color_scheme = "OneDark (base16)",
	hide_tab_bar_if_only_one_tab = true,
	window_close_confirmation = "NeverPrompt",
	default_prog = { 'pwsh' },
	initial_rows = 32,
	initial_cols = 90,
	use_fancy_tab_bar = false,
    colors = {
        tab_bar = {
          background = "#282c34",
          active_tab = {
            bg_color = "#c679dc",
            fg_color = "#000000",
          },
          inactive_tab = {
            bg_color = "#301d36",
            fg_color = "#abb3be",
          },
          inactive_tab_hover = {
            bg_color = "#301d36",
            fg_color = "#abb3be",
          },
          new_tab = {
            bg_color = "#301d36",
            fg_color = "#808080",
          },
          new_tab_hover = {
            bg_color = "#301d36",
            fg_color = "#808080",
          },
        },
    }
}

"@

Write-Host "`nOh My Posh setup..." -ForegroundColor Green

WriteFile -path "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" -content @"

{
  "`$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "alignment": "left",
      "segments": [
        {
          "background": "#61afef",
          "foreground": "#282c34",
          "leading_diamond": "\ue0b6",
          "powerline_symbol": "\ue0b0",
          "style": "diamond",
          "template": "\ue62a {{ .UserName }}@{{ .HostName }} ",
          "type": "session"
        },
        {
          "background": "#c8ccd4",
          "foreground": "#282c34",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "style": "full"
          },
          "style": "powerline",
          "template": " \ue5ff {{ .Path }} ",
          "type": "path"
        },
        {
          "background": "#e5c07b",
          "background_templates": [
            "{{ if or (.Working.Changed) (.Staging.Changed) }}#FFEB3B{{ end }}",
            "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFA300{{ end }}",
            "{{ if gt .Ahead 0 }}#FF7070{{ end }}",
            "{{ if gt .Behind 0 }}#90F090{{ end }}"
          ],
          "foreground": "#282c34",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "fetch_stash_count": true,
            "fetch_status": true,
            "fetch_upstream_icon": true
          },
          "style": "powerline",
          "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
          "type": "git"
        }
      ],
      "type": "prompt"
    }
  ],
  "console_title_template": "{{ .Folder }}",
  "final_space": true,
  "version": 2
}

"@