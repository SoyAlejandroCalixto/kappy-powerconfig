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
oh-my-posh init pwsh --config "C:\Users\kappy\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" | Invoke-Expression
Import-Module Terminal-Icons
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
Set-Alias vim nvim

"@

# powershell modules
gsudo Install-Module -Name Terminal-Icons -Repository PSGallery
gsudo Install-Module -Name PSReadLine -AllowClobber -Force

# wezterm config
WriteFile -path "$env:USERPROFILE\.wezterm.lua" -content @"

local wezterm = require("wezterm")

wezterm.on('update-right-status', function(window, pane)
    local cwd = tostring(pane:get_current_working_dir())
    cwd = cwd:gsub("file:///C:/", "")
    cwd = cwd:gsub("file://w11", " ") -- for WSL
    cwd = cwd:gsub("Users/"..os.getenv("USERNAME").."/", "~")
    cwd = cwd:gsub("/home/"..os.getenv("USERNAME"), "~") -- for WSL
    cwd = " "..cwd.." 󰝰 "

    local hostname = wezterm.hostname()
    hostname = " "..hostname.."  "

    local elements = {
        { Foreground = { Color = "#c6a0f6" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#c6a0f6" } },
        { Text = cwd },
        { Foreground = { Color = "#8aadf4" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#8aadf4" } },
        { Text = hostname },
    }

    window:set_right_status(wezterm.format(elements))
end)

return {
    window_background_opacity = 0.9,
    win32_system_backdrop = "Acrylic",
    font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
    font_size = 14.0,
    freetype_load_target = "Light",
    color_scheme = "Catppuccin Macchiato",
    window_close_confirmation = "NeverPrompt",
    default_prog = { 'pwsh', '-NoLogo' },
    initial_rows = 32,
    initial_cols = 90,
    use_fancy_tab_bar = false,
    window_padding = {
        right = 0,
        left = 0,
        top = 0,
        bottom = 0,
    },
    colors = {
        tab_bar = {
            background = "#21222c",
            active_tab = { bg_color = "#c6a0f6", fg_color = "#000000" },
            inactive_tab = { bg_color = "#25074B", fg_color = "#c6a0f6" },
            inactive_tab_hover = { bg_color = "#25074B", fg_color = "#c6a0f6"},
            new_tab = { bg_color = "#25074B", fg_color = "#c6a0f6" },
            new_tab_hover = { bg_color = "#25074B", fg_color = "#c6a0f6" },
        },
    },
}

"@

# oh my posh config
WriteFile -path "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\thecyberden.omp.json" -content @"

{
  "`$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "alignment": "left",
      "segments": [
        {
          "background": "#ba91f5",
          "foreground": "#282c34",
          "leading_diamond": "\ue0b6",
          "powerline_symbol": "\ue0b0",
          "style": "diamond",
          "template": "\ue62a {{ .UserName }}@{{ .HostName }} ",
          "type": "session"
        },
        {
          "background": "#f8f8f2",
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
