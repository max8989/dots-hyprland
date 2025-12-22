# Hyprland Desktop Configuration

![Hyprland Desktop Setup](/images/desktop-config.gif)

## NeoVim Configurations
![Neovim Configuration](/images/neovim-configs.png)

## Hardware Specs
Running on a **ThinkPad X1 Carbon 7th Gen** with Intel i7-8565U (8 cores @ 4.6GHz), 16GB RAM, and Intel UHD Graphics 620 at 2560x1440 resolution.

A complete Wayland desktop environment configuration featuring Hyprland window manager, optimized for development workflows on Arch Linux.

## Features

- **Modern Wayland Desktop**: Full Hyprland setup with smooth animations and gestures
- **Development-Ready**: Comprehensive Neovim configuration with LSP, debugging, and Git integration  
- **Theme System**: Multiple Catppuccin and Gruvbox theme variants with dynamic switching
- **Professional Workflow**: Integrated terminal, launcher, notifications, and system monitoring
- **GNU Stow Management**: Clean, organized dotfile deployment system

## Components

| Component | Tool | Description |
|-----------|------|-------------|
| **Window Manager** | Hyprland | Tiling window manager with animations |
| **Status Bar** | Waybar | Customizable bar with system monitoring |
| **Terminal** | Kitty | GPU-accelerated terminal with transparency |
| **Editor** | Neovim | Full IDE setup with Lazy.nvim plugin manager |
| **Launcher** | Wofi | Application launcher and menu system |
| **Notifications** | SwayNC | Notification daemon with action center |
| **Lock Screen** | Hyprlock | Secure screen locking with blur effects |
| **Idle Management** | Hypridle | Automatic screen dimming and locking |
| **Wallpapers** | Hyprpaper | Dynamic wallpaper management |
| **Audio** | PipeWire | Modern audio server configuration |
| **On-Screen Display** | SwayOSD | Volume/brightness overlay indicators |
| **Keyboard Remap** | Kanata | Advanced keyboard remapping for Wayland |
| **Shell Prompt** | Starship | Cross-shell customizable prompt |

## Quick Start

### Prerequisites
- **Arch Linux** (or Arch-based distribution)
- **yay** AUR helper
- **GNU Stow** for dotfile management

### Installation

1. **Clone this repository:**
```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

2. **Install Neovim environment:**
```bash
./install-nvim.sh
```

3. **Deploy configurations:**
```bash
# Deploy all configurations
stow */

# Or deploy specific components
stow hyprland waybar kitty nvim
```

4. **Verify setup:**
```bash
# Check Neovim health
nvim +checkhealth

# Test Hyprland (logout and select Hyprland session)
```

## Repository Structure

```
~/.dotfiles/
├── backgrounds/     # Wallpaper collection
├── hyprland/        # Window manager config
├── hyprlock/        # Lock screen settings
├── hyprmocha/       # Catppuccin Mocha theme for Hyprland
├── hyprpaper/       # Wallpaper management
├── kanata/          # Keyboard remapping configuration
├── kitty/           # Terminal configuration
├── nvim/            # Neovim development environment
├── pipewire/        # Audio system config
├── polybar/         # Alternative status bar (legacy)
├── rofi/            # Alternative launcher (legacy)
├── scripts/         # System utility scripts
├── starship/        # Shell prompt configuration
├── swayosd/         # On-screen display for volume/brightness
├── systemd/         # User services (battery notifications)
├── waybar/          # Status bar with themes
├── wlogout/         # Logout menu
├── wofi/            # Application launcher
└── install-nvim.sh  # Neovim setup script
```

## Development Environment

### Neovim Configuration

Complete IDE experience powered by modern Neovim plugins:

**Core Features:**
- **Plugin Manager**: Lazy.nvim with lazy loading
- **LSP Integration**: Mason for server management + nvim-lspconfig
- **Completion**: nvim-cmp with snippet support
- **Fuzzy Finding**: Telescope for files and live grep
- **File Explorer**: Neo-tree with Git integration
- **Debugging**: DAP support for multiple languages
- **Git Workflow**: LazyGit + Gitsigns + GitGraph visualization
- **Custom Cheatsheet**: Searchable keybinding reference

**Additional Plugins:**
- **AI Assistant**: Avante for AI-powered coding assistance
- **Terminal**: Toggleterm for integrated terminal
- **UI Enhancements**: Fine-cmdline, Bufferline, Lualine
- **Diagnostics**: Tiny-inline-diagnostic for inline error display
- **Image Preview**: Image.nvim for in-editor image viewing
- **Docker**: Lazydocker integration
- **Markdown**: Live preview support

**Key Bindings:**
- `<Space>` - Leader key
- `<C-p>` - Find files (Telescope)
- `<leader>fg` - Live grep search
- `<C-n>` - Toggle file explorer
- `<leader>ch` - Open cheatsheet
- `<Tab>` / `<S-Tab>` - Navigate buffers

### Language Support
Pre-configured LSP servers for:
- **Web**: TypeScript, JavaScript, HTML, CSS
- **Systems**: Lua, Bash, Python
- **Markup**: Markdown, JSON, YAML


## Theming

### Available Themes
**Catppuccin Variants:**
- Mocha (dark)
- Macchiato (dark)
- Frappe (dark) 
- Latte (light)

**Gruvbox Variants:**
- Dark
- Light

### Theme Management
```bash
# Switch themes using waybar scripts
~/.config/waybar/scripts/theme-switcher.sh

# Themes are automatically applied to:
# - Waybar, Kitty, Hyprland, Wofi, Rofi
```

## Customization

### Waybar Modules
Located in `waybar/.config/waybar/`:
- **System Monitoring**: CPU temp, memory, battery
- **Network**: WiFi status and controls  
- **Audio**: Volume control with PipeWire
- **Power**: Battery with charging status
- **Workspaces**: Hyprland workspace integration

### Custom Scripts
Available in `scripts/.config/scripts/`:
- `battery.sh` - Battery status reporting
- `open-folder-bg.sh` - Open folder in background
- `power.sh` - Power management menu
- `rofi-fb-official.sh` - Rofi file browser
- `screen_record.sh` - Screen recording utility
- `screenshot.sh` - Screenshot capture utility
- `wallpaper-switcher.sh` - Dynamic wallpaper switching
- `whatsong.sh` - Current playing song display
- `whoami.sh` - User information display
- `wlogout.sh` - Logout menu launcher
- `workspace_action.sh` - Workspace automation

### Waybar Scripts
Available in `waybar/.config/waybar/scripts/`:
- `battery-level.sh` - Battery percentage display
- `battery-state.sh` - Battery charging state
- `bluetooth-menu.sh` - Bluetooth device management
- `brightness-control.sh` - Screen brightness control
- `cpu-temp.sh` - CPU temperature monitoring
- `current-theme.sh` - Active theme detection
- `mic-status.sh` - Microphone mute status
- `power-menu.sh` - Power options menu
- `system-update.sh` - Package update checker
- `theme-switcher.sh` - Theme switching utility
- `volume-control.sh` - Audio volume control
- `wifi-menu.sh` - WiFi network management
- `wifi-status.sh` - WiFi connection status

### Hyprland Configuration
Located in `hyprland/.config/hypr/`:
- `hyprland.conf` - Main configuration file
- `keybindings.conf` - Keyboard shortcuts (separate file)
- `hypridle.conf` - Idle timeout and actions
- `monitors.conf` - Display/monitor settings

**Features:**
- **Animations**: Smooth window transitions
- **Gestures**: Touchpad gesture support
- **Keybindings**: Optimized for productivity
- **Multi-monitor**: Dynamic display configuration
- **Theme Integration**: Sources Catppuccin Mocha colors from hyprmocha/

### GRUB Configuration
Edit `/etc/default/grub` for kernel boot parameters:

```bash
# Show systemd logs during boot (remove 'quiet')
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"

# Apply changes
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## System Requirements

### Essential Packages
**Core System:**
```
hyprland waybar kitty wofi swaync
hyprlock hyprpaper hypridle hyprshot
neovim git curl wget ripgrep fd
swayosd kanata 
```

**Development Tools:**
```
nodejs npm python python-pip
lazygit debugpy netcoredbg
```

**Audio/Media:**
```
pipewire pipewire-pulse pipewire-alsa
wl-clipboard cliphist
```

### Optional Dependencies
- **Fonts**: CaskaydiaCove Nerd Font, Figtree
- **Cursors**: Catppuccin cursor themes  
- **Icons**: Papirus or similar icon pack

## Troubleshooting

**Common Issues:**

1. **Stow conflicts**: Remove existing dotfiles before stowing
2. **Missing dependencies**: Run `./install-nvim.sh` first
3. **LSP not working**: Check `:Mason` in Neovim
4. **Audio issues**: Verify PipeWire is running
5. **Theme not applying**: Check waybar script permissions

**Debug Commands:**
```bash
# Check Hyprland logs
journalctl -f -u hyprland

# Verify stow links  
stow -n -v */ 

# Test Neovim health
nvim +checkhealth
```

## Screenshots

---

**Installation Guide**: For complete system setup, see [arch-linux-setup](https://github.com/max8989/arch-linux-setup)

**License**: Personal configuration - adapt as needed for your setup
