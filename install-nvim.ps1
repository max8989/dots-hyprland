# Neovim Installation Script for Windows PowerShell
# This script installs all required packages for the Neovim configuration

# Set error action preference to stop on errors
$ErrorActionPreference = "Stop"

# Handle Ctrl+C gracefully
trap {
    Write-Host "`n❌ Installation cancelled by user" -ForegroundColor Red
    exit 130
}

# Core packages to install via winget
$WINGET_CORE_PACKAGES = @(
    "Neovim.Neovim",
    "Git.Git",
    "cURL.cURL",
    "GNU.Wget",
    "7zip.7zip"
)

# Plugin-related packages
$WINGET_PLUGIN_PACKAGES = @(
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd",
    "OpenJS.NodeJS",
    "Python.Python.3.12",
    "JesseDuffield.lazygit"
)

# Python packages
$PYTHON_PACKAGES = @(
    "debugpy"
)

# Function to check if winget is available
function Test-WingetAvailable {
    try {
        winget --version | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# Function to install winget packages
function Install-WingetPackages {
    param(
        [string]$PackageName,
        [array]$Packages
    )
    
    Write-Host "📝 Installing $PackageName..." -ForegroundColor Cyan
    foreach ($package in $Packages) {
        Write-Host "Installing $package..." -ForegroundColor Yellow
        winget install --id $package --silent --accept-source-agreements --accept-package-agreements
    }
}

# Function to install Python packages
function Install-PythonPackages {
    Write-Host "🐍 Installing Python packages..." -ForegroundColor Cyan
    foreach ($package in $PYTHON_PACKAGES) {
        pip install --user $package
    }
}

# Function to install .NET Core Debugger (netcoredbg equivalent)
function Install-NetCoreDebugger {
    Write-Host "🔧 Installing .NET Core Debugger..." -ForegroundColor Cyan
    # Install via winget if available, otherwise provide manual instructions
    try {
        winget install --id Microsoft.DotNet.SDK.8 --silent --accept-source-agreements --accept-package-agreements
    }
    catch {
        Write-Host "⚠️  Could not install .NET SDK automatically. Please install manually from:" -ForegroundColor Yellow
        Write-Host "https://dotnet.microsoft.com/download" -ForegroundColor Yellow
    }
}

# Function to display completion message
function Show-CompletionMessage {
    Write-Host "✅ Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Next steps:" -ForegroundColor Cyan
    Write-Host "1. Copy the Neovim configuration to your config directory:"
    Write-Host "   - Windows: ~\AppData\Local\nvim\"
    Write-Host "   - Or use symbolic links if preferred"
    Write-Host "2. Launch Neovim with 'nvim' - Lazy.nvim will auto-install plugins on first run"
    Write-Host "3. Mason will automatically install LSP servers (lua_ls, ts_ls, eslint, etc.)"
    Write-Host "4. Run ':checkhealth' in Neovim to verify everything is working"
    Write-Host ""
    Write-Host "🎯 Key bindings to remember:" -ForegroundColor Cyan
    Write-Host "- <C-p>: Find files"
    Write-Host "- <leader>fg: Live grep"
    Write-Host "- <leader>cs: Custom cheat sheet"
    Write-Host "- <leader>: Space key"
    Write-Host ""
    Write-Host "Happy coding! 🎉" -ForegroundColor Green
}

# Main execution
function Main {
    Write-Host "🚀 Installing Neovim and required packages..." -ForegroundColor Green
    
    # Check if winget is available
    if (-not (Test-WingetAvailable)) {
        Write-Host "❌ winget is not available. Please install App Installer from Microsoft Store or update Windows." -ForegroundColor Red
        exit 1
    }
    
    # Update winget sources
    Write-Host "📦 Updating winget sources..." -ForegroundColor Cyan
    winget source update
    
    # Install packages
    Install-WingetPackages "core dependencies" $WINGET_CORE_PACKAGES
    Install-WingetPackages "plugin dependencies" $WINGET_PLUGIN_PACKAGES
    
    Install-NetCoreDebugger
    Install-PythonPackages
    
    Show-CompletionMessage
}

# Run main function
Main