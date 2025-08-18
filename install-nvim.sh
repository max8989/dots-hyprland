#!/bin/bash

# Neovim Installation Script for Arch Linux
# This script installs all required packages for the Neovim configuration

set -e

# Handle Ctrl+C gracefully
trap 'echo -e "\n❌ Installation cancelled by user"; exit 130' INT

# Package arrays
PACMAN_CORE_PACKAGES=(
    "neovim"
    "git" 
    "curl"
    "wget"
    "unzip"
    "tar"
    "gzip"
)

PACMAN_PLUGIN_PACKAGES=(
    "ripgrep"
    "fd" 
    "nodejs"
    "npm"
    "python"
    "python-pip"
    "lazygit"
)

# Note: Clipboard tools (wl-clipboard/xclip) are likely already installed with your Wayland setup

YAY_PACKAGES=(
    "netcoredbg"
)

PYTHON_PACKAGES=(
    "debugpy"
)

# Function to check and install yay
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "⚠️  yay (AUR helper) not found!"
        echo "📦 Installing yay first..."
        
        # Install base-devel and git if not present
        sudo pacman -S --needed --noconfirm base-devel git
        
        # Clone and build yay
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
        
        echo "✅ yay installed successfully!"
    fi
}

# Function to update system
update_system() {
    echo "📦 Updating system packages..."
    sudo pacman -Syu --noconfirm
}

# Function to install pacman packages
install_pacman_packages() {
    local package_array=("$@")
    local package_name="$1"
    shift
    
    echo "📝 Installing $package_name..."
    sudo pacman -S --needed --noconfirm "${package_array[@]}"
}

# Function to install AUR packages
install_aur_packages() {
    echo "🔧 Installing AUR packages..."
    yay -S --needed --noconfirm "${YAY_PACKAGES[@]}"
}

# Function to install Python packages
install_python_packages() {
    echo "🐍 Installing Python packages..."
    pip install --user --break-system-packages "${PYTHON_PACKAGES[@]}"
}

# Note: Neovim directories are created automatically by stow and Neovim itself

# Function to display completion message
show_completion_message() {
    echo "✅ Installation complete!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Run 'stow nvim' to link the Neovim configuration"
    echo "2. Launch Neovim with 'nvim' - Lazy.nvim will auto-install plugins on first run"
    echo "3. Mason will automatically install LSP servers (lua_ls, ts_ls, eslint, etc.)"
    echo "4. Run ':checkhealth' in Neovim to verify everything is working"
    echo ""
    echo "🎯 Key bindings to remember:"
    echo "- <C-p>: Find files"
    echo "- <leader>fg: Live grep" 
    echo "- <leader>cs: Custom cheat sheet"
    echo "- <leader>: Space key"
    echo ""
    echo "Happy coding! 🎉"
}

# Main execution
main() {
    echo "🚀 Installing Neovim and required packages..."
    
    install_yay
    update_system
    
    install_pacman_packages "core dependencies" "${PACMAN_CORE_PACKAGES[@]}"
    install_pacman_packages "plugin dependencies" "${PACMAN_PLUGIN_PACKAGES[@]}"
    
    install_aur_packages
    install_python_packages
    
    show_completion_message
}

# Run main function
main
