# Hyprland Desktop Setup

![My Wayland Desktop Setup](/images/configs.png)

This repository contains my personal Hyprland desktop environment configuration and setup details.

## Overview

This is my minimalist and functional Hyprland-based desktop environment running on Arch Linux. The setup prioritizes efficiency and a clean aesthetic while maintaining full functionality for daily development work.

## Installation

The complete list of packages and installation script can be found in my Arch Linux setup repository:
[arch-linux-setup](https://github.com/max8989/arch-linux-setup)

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

## Getting Started

1. First, install Arch Linux following the official guide
2. Clone the arch-linux-setup repository
3. Run the installation script to set up all required packages
4. Clone this repository to your home directory
5. Run `stow */` in the repository directory to create symbolic links
6. Configure your environment using the provided configuration files

## Configuration Files

The configuration files (dotfiles) for the following components are included:

- `~/.config/hypr/` - Hyprland configuration
- `~/.config/waybar/` - Waybar status bar
- `~/.config/wofi/` - Application launcher
- `~/.config/swaync/` - Notification daemon
