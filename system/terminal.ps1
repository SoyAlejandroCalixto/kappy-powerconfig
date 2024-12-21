. $PSScriptRoot\..\lib\PkgsI.ps1
. $PSScriptRoot\..\lib\WriteFile.ps1
Write-Host "`n-- Terminal setup --" -ForegroundColor Blue

# terminal packages
PkgsI -p @(
    'JanDeDobbeleer.OhMyPosh',
    'wez.wezterm',
    'Microsoft.PowerShell',
    'Nvim.Nvim',
    'fzf'
)

# profile
WriteFile -path $PROFILE -content @"

clear
oh-my-posh init pwsh --config "C:\Users\kappy\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" | Invoke-Expression
fastfetch --logo $PROFILE\..\on_terminal_enter.txt --logo-color-1 blue --logo-color-2 blue --logo-padding-right 2 --color green -s os:kernel:uptime:shell:cpuUsage:memory --key-type icon --separator "  "
Import-Module Terminal-Icons
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
Set-Alias vim nvim

"@

# fastfetch ascii
WriteFile -path $PROFILE\..\on_terminal_enter.txt -content @"
   ___
___|$|___
|Z@%#%@Z|
   |$|
   |$|
   |Z|
"@

# powershell modules
sudo Install-Module -Name Terminal-Icons -Repository PSGallery
sudo Install-Module -Name PSReadLine -AllowClobber -Force

# wezterm config
WriteFile -path "$env:USERPROFILE\.wezterm.lua" -content @"

local wezterm = require("wezterm")
return {
    window_background_opacity = 0.8,
    win32_system_backdrop = "Acrylic",
    font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
    font_size = 13.0,
    freetype_load_target = "Light",
    color_scheme = "OneDark (base16)",
    hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = "NeverPrompt",
    default_prog = { 'pwsh', '-NoLogo' },
    initial_rows = 32,
    initial_cols = 90,
    use_fancy_tab_bar = false,

    colors = {
        tab_bar = {
            background = "#282c34",
            active_tab = { bg_color = "#c679dc", fg_color = "#000000" },
            inactive_tab = { bg_color = "#301d36", fg_color = "#abb3be" },
            inactive_tab_hover = { bg_color = "#301d36", fg_color = "#abb3be"},
            new_tab = { bg_color = "#301d36", fg_color = "#808080" },
            new_tab_hover = { bg_color = "#301d36", fg_color = "#808080" },
        },
    }
}

"@

# nvim config
git clone https://github.com/SoyAlejandroCalixto/nvim-config $env:USERPROFILE\AppData\Local\nvim

# oh my posh config
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
