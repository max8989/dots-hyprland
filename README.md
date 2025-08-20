# Hyprland Desktop Configuration

![Hyprland Desktop Setup](/images/desktop-config.gif)

## Neovim Configurations
![Neovim Configuration](/images/neovim-configs.png)

## 💻 Hardware Specs
Running on a **ThinkPad X1 Carbon 7th Gen** with Intel i7-8565U (8 cores @ 4.6GHz), 16GB RAM, and Intel UHD Graphics 620 at 2560x1440 resolution.

A complete Wayland desktop environment configuration featuring Hyprland window manager, optimized for development workflows on Arch Linux.

## ✨ Features

- **Modern Wayland Desktop**: Full Hyprland setup with smooth animations and gestures
- **Development-Ready**: Comprehensive Neovim configuration with LSP, debugging, and Git integration  
- **Theme System**: Multiple Catppuccin and Gruvbox theme variants with dynamic switching
- **Professional Workflow**: Integrated terminal, launcher, notifications, and system monitoring
- **GNU Stow Management**: Clean, organized dotfile deployment system

## 🖥️ Components

| Component | Tool | Description |
|-----------|------|-------------|
| **Window Manager** | Hyprland | Tiling window manager with animations |
| **Status Bar** | Waybar | Customizable bar with system monitoring |
| **Terminal** | Kitty | GPU-accelerated terminal with transparency |
| **Editor** | Neovim | Full IDE setup with Lazy.nvim plugin manager |
| **Launcher** | Wofi | Application launcher and menu system |
| **Notifications** | SwayNC | Notification daemon with action center |
| **Lock Screen** | Hyprlock | Secure screen locking with blur effects |
| **Wallpapers** | Hyprpaper | Dynamic wallpaper management |
| **Audio** | PipeWire | Modern audio server configuration |

## 🚀 Quick Start

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

## 📁 Repository Structure

```
~/.dotfiles/
├── backgrounds/     # Wallpaper collection
├── hyprland/       # Window manager config
├── hyprlock/       # Lock screen settings  
├── hyprpaper/      # Wallpaper management
├── kitty/          # Terminal configuration
├── nvim/           # Neovim development environment
├── pipewire/       # Audio system config
├── rofi/           # Alternative launcher (legacy)
├── scripts/        # System utility scripts
├── starship/       # Shell prompt configuration
├── waybar/         # Status bar with themes
├── wlogout/        # Logout menu
├── wofi/           # Application launcher
└── install-nvim.sh # Neovim setup script
```

## 🛠️ Development Environment

### Neovim Configuration

Complete IDE experience powered by modern Neovim plugins:

**Core Features:**
- **Plugin Manager**: Lazy.nvim with lazy loading
- **LSP Integration**: Mason for server management + nvim-lspconfig  
- **Completion**: nvim-cmp with snippet support
- **Fuzzy Finding**: Telescope for files and live grep
- **File Explorer**: Neo-tree with Git integration
- **Debugging**: DAP support for multiple languages
- **Git Workflow**: LazyGit integration
- **Custom Cheatsheet**: Searchable keybinding reference

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


## 🎨 Theming

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

## 🔧 Customization

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
- `power.sh` - Power management menu
- `screen_record.sh` - Screen recording utility
- `workspace_action.sh` - Workspace automation

### Hyprland Configuration
- **Animations**: Smooth window transitions
- **Gestures**: Touchpad gesture support
- **Keybindings**: Optimized for productivity
- **Multi-monitor**: Dynamic display configuration

## 📋 System Requirements

### Essential Packages
**Core System:**
```
hyprland waybar kitty wofi swaync
hyprlock hyprpaper hypridle hyprshot
neovim git curl wget ripgrep fd
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

## 🔍 Troubleshooting

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

## 📸 Screenshots

---

**Installation Guide**: For complete system setup, see [arch-linux-setup](https://github.com/max8989/arch-linux-setup)

**License**: Personal configuration - adapt as needed for your setup
