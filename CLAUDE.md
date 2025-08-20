# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Hyprland desktop environment configuration repository (dotfiles) for Arch Linux, featuring a complete Wayland-based setup with Neovim as the primary development environment.

## Setup Commands

### Neovim Installation
```bash
# Install all required packages for Neovim development environment
./install-nvim.sh

# Apply Neovim configuration using GNU Stow
stow nvim
```

### System Setup
```bash
# Apply all dotfiles using GNU Stow
stow */

# Check installation and dependencies
nvim +checkhealth
```

## Architecture & Structure

### Configuration Organization
- **stow-based**: All configurations use GNU Stow directory structure
- **Component isolation**: Each major component (hyprland, nvim, waybar, etc.) has its own directory
- **Symbolic linking**: Configurations are symlinked to proper locations via `stow`

### Neovim Configuration Architecture
- **Plugin manager**: Lazy.nvim with automatic plugin installation
- **Modular structure**: Plugins organized in `nvim/.config/nvim/lua/plugins/`
- **Core configuration**: `nvim/.config/nvim/lua/vim-options.lua`
- **Bootstrap**: `nvim/.config/nvim/init.lua` handles Lazy.nvim setup and loading

### Key Neovim Plugins & Features
- **LSP Configuration**: Mason for server management, nvim-lspconfig
- **Completion**: nvim-cmp with LSP integration
- **Fuzzy Finding**: Telescope for file/text search
- **File Explorer**: Neo-tree (toggle with `<C-n>`)
- **Git Integration**: LazyGit
- **Custom Cheatsheet**: Searchable keybinding reference (`<leader>ch`)
- **DAP Support**: Debug Adapter Protocol configuration

### Hyprland Environment Components
- **Window Manager**: Hyprland with Wayland protocol
- **Status Bar**: Waybar with custom modules and scripts
- **Terminal**: Kitty terminal emulator
- **Application Launcher**: Wofi
- **Theme System**: Catppuccin with multiple variants

### Waybar Custom Scripts
Located in `waybar/.config/waybar/scripts/`:
- System monitoring (CPU temp, battery, WiFi)
- Theme switching capabilities
- Power management
- Volume and brightness control

## Key Bindings & Usage

### Neovim Development Workflow
- **Leader key**: Space (`<leader>`)
- **File navigation**: `<C-p>` (Telescope find files)
- **Text search**: `<leader>fg` (live grep)
- **File explorer**: `<C-n>` (Neo-tree toggle)
- **Cheatsheet**: `<leader>ch` (custom cheatsheet)
- **Buffer navigation**: `<Tab>` (next), `<S-Tab>` (previous), `<leader>bd` (delete)

### Configuration Standards
- **Indentation**: 2 spaces (Neovim configs)
- **Line numbers**: Enabled by default
- **Case sensitivity**: Smart case search enabled
- **Auto-expansion**: Disabled for file trees to prevent cluttered views

## Development Workflow

1. **Making Configuration Changes**: Edit files in their respective component directories
2. **Applying Changes**: Use `stow <component>` to update symlinks
3. **Neovim Plugin Management**: Lazy.nvim automatically handles installations and updates
4. **LSP Servers**: Mason automatically installs and manages language servers
5. **Theme Changes**: Use waybar theme switcher scripts

## Installation Dependencies

### Core System Packages (via pacman)
- neovim, git, curl, wget, unzip, tar, gzip
- ripgrep, fd, nodejs, npm, python, python-pip, lazygit

### AUR Packages (via yay)
- netcoredbg (C# debugger)

### Python Packages
- debugpy (Python debugger)

## System Integration

The configuration assumes:
- **Arch Linux** as the base system
- **Wayland** display protocol
- **GNU Stow** for configuration management
- **yay** AUR helper for package installation