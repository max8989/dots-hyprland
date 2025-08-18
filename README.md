# Hyprland Desktop Setup

![My Wayland Desktop Setup](/images/configs.png)

## Screenshots
This repository contains my personal Hyprland desktop environment configuration and setup details.

## Overview

This is my minimalist and functional Hyprland-based desktop environment running on Arch Linux. The setup prioritizes efficiency and a clean aesthetic while maintaining full functionality for daily development work.

## Installation

**The complete list of packages and installation script can be found in my Arch Linux setup repository:**
**[arch-linux-setup](https://github.com/max8989/arch-linux-setup)**

## Components

- **Window Manager**: Hyprland
- **Display Protocol**: Wayland
- **Operating System**: Arch Linux
- **Status Bar**: Waybar
- **Terminal**: Kitty
- **Application Launcher**: Wofi
- **Notifications**: Swaync
- **Screenshots**: Hyprshot + wl-clipboard
- **Color Picker**: Hyprpicker
- **Text Editor**: Neovim with Lazy.nvim plugin manager

## Getting Started

1. **First, install Arch Linux** following the official guide
2. **Clone the arch-linux-setup repository**
3. **Run the installation script** to set up all required packages
4. **Clone this repository to your home directory (`~/`)**
5. **Run `stow */`** in the repository directory to create symbolic links
6. **Configure your environment** using the provided configuration files

## Configuration Files

**The configuration files (dotfiles) for the following components are included:**

- `~/.config/hypr/` - Hyprland configuration
- `~/.config/waybar/` - Waybar status bar
- `~/.config/wofi/` - Application launcher
- `~/.config/swaync/` - Notification daemon
- `~/.config/nvim/` - Neovim editor configuration

## Neovim Configuration

This setup includes a fully configured Neovim environment with the following features:

### Plugins Included
- **Lazy.nvim** - Modern plugin manager
- **Telescope** - Fuzzy finder with live grep and file search
- **LSP Configuration** - Language servers for TypeScript, JavaScript, Lua, CSS, HTML, and more
- **nvim-cmp** - Autocompletion with LSP integration
- **Treesitter** - Advanced syntax highlighting and parsing
- **Mason** - LSP server installer and manager
- **Lualine** - Status line
- **Neo-tree** - File explorer
- **LazyGit** - Git integration
- **ToggleTerm** - Terminal integration
- **DAP** - Debug Adapter Protocol support
- **Alpha** - Dashboard/start screen
- **Custom cheat sheet** - Searchable keybinding reference

### Required System Packages
Run the install script to automatically install all required packages:
```bash
./install-nvim.sh
```

### Key Features
- **Fuzzy file finding** with `<C-p>`
- **Live grep search** with `<leader>fg`
- **LSP-powered autocompletion** and code intelligence
- **Custom cheat sheet** accessible with `<leader>cs`
- **Integrated terminal** and git workflow
- **Debug support** for multiple languages
- **Modern UI** with proper theming

### Neovim
![Neovim Dashboard](/images/nvim-home.png)

![Neovim Installation Script](/images/nvim-editor.png)

![File Tree View](/images/nvim-telescope.png)


