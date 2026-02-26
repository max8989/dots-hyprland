# Carter — Memories
<!-- linux-agent-sidecar/memories.md -->
<!-- Carter (Linux System Advisor) persistent memory file -->
<!-- Updated each session via [SS] Save session -->

## User Profile

- **Name:** Maxime
- **System:** Arch Linux, Hyprland (Wayland)
- **Shell:** bash
- **Editor:** Neovim (lazy.nvim)
- **Dotfiles repo:** ~/dots-hyprland (GNU Stow)
- **AUR Helper:** paru
- **Skill level:** Expert — skip basics, explain the why

## Preferences

- Notification style: concise, terminal-friendly
- Alert thresholds: disk >80%, cache >5GB
- Dismissed warnings: []
- Preferred update workflow: paru -Su

## Session History

<!-- Append after each session -->

### Session: 2026-02-25
- Alerts surfaced: [4 AUR updates pending (claude-code, opencode-bin, chrome, cursor), iwlwifi log noise, keyring timer false alarm]
- User decisions: [Repo scan requested, memories populated]
- Rice suggestions shown: [Sunshine/Moonlight Hyprland integration mentioned]

## Known Setup Notes

- Dotfiles repo path: ~/dots-hyprland
- Stow packages: hyprland, hyprlock, hyprmocha, hyprpaper, kanata, kitty, nvim, opencode, polybar, rofi, scripts, starship, swayosd, systemd, waybar, wlogout, wofi, backgrounds

## Installed Stow Packages

| Package | Purpose |
|---------|---------|
| hyprland | WM config (hyprland.conf, keybindings.conf, hypridle.conf) |
| hyprlock | Lock screen |
| hyprmocha | Catppuccin Mocha color theme for Hypr |
| hyprpaper | Wallpaper daemon |
| kanata | Keyboard remapping (Caps Lock → nav layer / Escape) |
| kitty | Terminal emulator |
| nvim | Neovim config (lazy.nvim) |
| opencode | OpenCode AI config |
| polybar | (Legacy/alternate bar, not active in Hyprland autostart) |
| rofi | App launcher + clipboard + file browser + vim cheatsheet |
| scripts | Custom utility scripts |
| starship | Shell prompt |
| swayosd | OSD for volume/brightness feedback |
| systemd | User systemd units (battery-level, reminders-notify timers) |
| waybar | Status bar with custom scripts |
| wlogout | Logout screen |
| wofi | Wayland-native launcher (power menu) |
| backgrounds | Wallpaper images |

## Hyprland Setup

- **Monitor layout:** Primary (highres auto 1x scaling) + DP-2 (2560x1440@60, right) + DP-1 (1920x1080@60, right) + SUNSHINE virtual (1280x720@30, headless, for game streaming)
- **Layout:** dwindle (force_split=2, i3-style right/bottom)
- **Theme:** Catppuccin Mocha (border: cyan-green gradient `rgba(33ccffee) → rgba(00ff99ee)`)
- **Rounding:** 6px, blur disabled
- **Cursor:** catppuccin-frappe-dark-cursors size 28
- **Keyboard layouts:** us, ca (toggle: Ctrl+Space)
- **Input method:** fcitx5 (Alt+Space toggle)

## Hyprland Autostart

- hyprpaper, waybar, swaync, hypridle, swayosd-server
- wl-paste (cliphist — text + image)
- dbus-update-activation-environment (Wayland/XDG)
- hyprswitch (Alt+Tab switcher)
- kanata (keyboard remapping)
- localsend (file sharing, hidden)
- polkit-gnome

## Key Application Stack

| Role | App |
|------|-----|
| Terminal | kitty |
| Editor | zed (primary), neovim |
| Browser | zen-browser |
| File manager | nautilus |
| Launcher | rofi (drun, file browser, clipboard) |
| Bar | waybar |
| Notifications | swaync |
| Wallpaper | hyprpaper + wallpaper-switcher.sh |
| Lock screen | hyprlock (via hypridle) |
| Logout | wlogout |
| Clipboard | cliphist + wl-paste |
| Volume/brightness OSD | swayosd |
| Media control | playerctl |
| Audio | wpctl (pipewire) |
| Bluetooth | bluetoothctl |
| Network | nmcli |
| Screenshots | grim + slurp (via screenshot.sh) |
| Screen record | wf-recorder (via screen_record.sh) |
| Game streaming | Sunshine (virtual headless monitor) |
| Keyboard remap | kanata |
| File sharing | localsend |
| Window switcher | hyprswitch |
| Power management | hypridle + brightnessctl |
| RSS | custom rss-feed.sh + rss-summarize.py |

## Waybar Modules / Scripts

- battery-level.sh, battery-state.sh
- bluetooth-menu.sh
- brightness-control.sh
- cpu-info.sh, cpu-temp.sh
- current-theme.sh, theme-switcher.sh
- memory-info.sh
- mic-status.sh
- power-menu.sh (wofi-based)
- reminders.sh, reminders-popup.sh, reminders-notify.sh
- system-update.sh
- volume-control.sh
- wifi-menu.sh, wifi-status.sh

## Waybar Themes

Catppuccin: frappe, latte, macchiato, mocha | Gruvbox: dark, light

## Neovim Plugins (lazy.nvim)

### UI
- `goolord/alpha-nvim` — dashboard/start screen
- `akinsho/bufferline.nvim` — buffer tabs
- `nvim-lualine/lualine.nvim` — statusline
- `nvim-neo-tree/neo-tree.nvim` — file explorer
- `nvim-tree/nvim-web-devicons` — icons
- `rachartier/tiny-inline-diagnostic.nvim` — inline diagnostics
- `VonHeikemen/fine-cmdline.nvim` — fancy command line
- `MeanderingProgrammer/render-markdown.nvim` — markdown rendering (Mermaid support)

### Colorscheme
- `nyoom-engineering/oxocarbon.nvim`

### LSP / Completion
- `neovim/nvim-lspconfig` — LSP client
- `williamboman/mason.nvim` — LSP/tool installer
- `williamboman/mason-lspconfig.nvim` — mason ↔ lspconfig bridge
- `seblyng/roslyn.nvim` — C#/Razor LSP (Roslyn)
- `hrsh7th/nvim-cmp` — completion engine
- `hrsh7th/cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-cmdline`
- `L3MON4D3/LuaSnip` — snippet engine
- `saadparwaiz1/cmp_luasnip`
- `rafamadriz/friendly-snippets`
- `nvimtools/none-ls.nvim` — null-ls fork (formatters/linters)

### LSP Servers (Mason)
- lua_ls, ts_ls, eslint, emmet_ls, cssls, tailwindcss, pyright, ruff, roslyn (C#), solargraph (Ruby)
- Formatters: stylua, prettier, csharpier, xmlformatter
- Debuggers: debugpy, codelldb, netcoredbg (AUR)

### Treesitter
- `nvim-treesitter/nvim-treesitter`

### Debugging (DAP)
- `mfussenegger/nvim-dap`
- `mfussenegger/nvim-dap-python`
- `rcarriga/nvim-dap-ui`
- `nvim-neotest/nvim-nio`
- `nvim-neotest/neotest` + `Issafalcon/neotest-dotnet`

### Git
- `lewis6991/gitsigns.nvim`
- `isakbm/gitgraph.nvim`
- `sindrets/diffview.nvim`
- `kdheepak/lazygit.nvim`

### Navigation / Telescope
- `nvim-telescope/telescope.nvim`
- `nvim-telescope/telescope-ui-select.nvim`
- `ibhagwan/fzf-lua`
- `chentoast/marks.nvim`

### Terminal / Tools
- `akinsho/toggleterm.nvim`
- `mgierada/lazydocker.nvim`

### AI
- `yetone/avante.nvim`

### Markdown / Images
- `iamcco/markdown-preview.nvim`
- `3rd/image.nvim`
- `HakonHarnes/img-clip.nvim`

### Misc
- `sudormrfbin/cheatsheet.nvim`
- `antoinemadec/FixCursorHold.nvim`
- `nvim-lua/plenary.nvim`
- `nvim-lua/popup.nvim`
- `MunifTanjim/nui.nvim`

## Kanata Layout

CapsLock (tap=Esc, hold=nav layer):
- hold+hjkl → arrow keys
- hold+u/o → Home/End
- hold+Backspace/\ → Delete
- hold+q → toggle CapsLock
- hold+1-0/-/= → F1-F12

## Systemd User Units

- battery-level.service/.timer
- reminders-notify.service/.timer
