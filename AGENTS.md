# AGENTS.md

Guidelines for AI coding agents working in this Hyprland dotfiles repository.

## Repository Overview

This is a GNU Stow-managed dotfiles repository for Arch Linux with Hyprland (Wayland). Primary languages are Bash scripts and Lua (for Neovim configuration).

## Build/Lint/Test Commands

```bash
# No formal build system - this is a dotfiles repo

# Apply all configurations
stow */

# Apply specific component
stow nvim
stow waybar

# Preview stow changes (dry run)
stow -n -v */

# Check Neovim health
nvim +checkhealth

# Verify shell script syntax
bash -n script.sh

# Format Lua files (if stylua installed)
stylua nvim/.config/nvim/lua/

# Lint shell scripts (if shellcheck installed)
shellcheck waybar/.config/waybar/scripts/*.sh
```

## Directory Structure

Each stow package follows XDG Base Directory specification:
```
package-name/
└── .config/
    └── package-name/
        └── (config files)
```

## Code Style Guidelines

### Shell Scripts (Bash)

**Shebang:**
```bash
#!/usr/bin/env bash
```

**Indentation:** 4 spaces (no tabs)

**Error Handling:**
```bash
set -euo pipefail  # For robust scripts

# Check command availability
if ! command -v tool &>/dev/null; then
    echo "Error: tool not found" >&2
    exit 1
fi

# Use fallbacks
value="${VAR:-default}"
```

**Naming Conventions:**
- Constants: `SCREAMING_SNAKE_CASE`
- Variables: `snake_case`
- Functions: `snake_case`
- Files: `kebab-case.sh`

```bash
# Constants
CACHE_DIR="$HOME/.cache/myapp"
WARNING_LEVEL=20

# Variables
wifi_status=""
battery_level=0

# Functions
get_battery_info() {
    local level
    level=$(cat /sys/class/power_supply/BAT0/capacity)
    echo "$level"
}
```

**Waybar Script Output Format:**
```bash
# Always output valid JSON for waybar modules
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
```

**Common Patterns:**
```bash
# Cache directory creation
CACHE_DIR="$HOME/.cache/app-name"
mkdir -p "$CACHE_DIR"

# Config file sourcing
CONFIG_FILE="$HOME/.config/app/config.sh"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Icon selection by threshold
if [[ "$value" -ge 80 ]]; then
    icon="󰁹"
elif [[ "$value" -ge 60 ]]; then
    icon="󰂀"
else
    icon="󰁻"
fi
```

### Lua (Neovim Configuration)

**Indentation:** 2 spaces (no tabs)

**Naming Conventions:**
- Files: `kebab-case.lua`
- Variables: `snake_case`
- Functions: `snake_case`

**Plugin File Structure:**
```lua
return {
  "author/plugin-name",
  dependencies = {
    "dependency/plugin",
  },
  lazy = false,  -- or event = "VeryLazy", "BufRead", etc.
  opts = {
    -- plugin options
  },
  config = function()
    require("plugin").setup({
      -- configuration
    })

    -- Keymaps with descriptions
    vim.keymap.set("n", "<leader>xx", function()
      -- action
    end, { desc = "Description of action" })
  end,
}
```

**LSP Configuration (Nvim 0.11+):**
```lua
vim.lsp.config("server_name", {
  capabilities = capabilities,
  settings = {
    -- server settings
  },
})
vim.lsp.enable("server_name")
```

**Keymap Pattern:**
```lua
-- Always include desc for discoverability
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep search" })
```

### CSS (Waybar/Wofi)

**Indentation:** 4 spaces

```css
#module-name {
    background-color: @base;
    color: @text;
    padding: 0 10px;
    border-radius: 8px;
}

#module-name.warning {
    background-color: @yellow;
}
```

### Hyprland Configuration

**Format:** Custom key=value DSL
```conf
# Comments with hash
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
}

# Keybindings: bind = MODS, KEY, dispatcher, params
bind = $mainMod, Return, exec, kitty
```

## File Organization

| Directory | Purpose | Language |
|-----------|---------|----------|
| `nvim/.config/nvim/lua/plugins/` | Lazy.nvim plugin specs | Lua |
| `nvim/.config/nvim/lua/configs/` | Plugin configurations | Lua |
| `waybar/.config/waybar/scripts/` | Waybar module scripts | Bash |
| `scripts/.config/scripts/` | System utility scripts | Bash |
| `hyprland/.config/hypr/` | Window manager config | Hyprland DSL |

## Important Files

- `nvim/.config/nvim/init.lua` - Neovim bootstrap (Lazy.nvim)
- `nvim/.config/nvim/lua/vim-options.lua` - Core Neovim settings
- `hyprland/.config/hypr/hyprland.conf` - Main WM config
- `hyprland/.config/hypr/keybindings.conf` - Keyboard shortcuts
- `waybar/.config/waybar/config.jsonc` - Status bar config

## Configuration Formats

| Format | Use Case |
|--------|----------|
| JSONC | Waybar config (comments allowed) |
| JSON | Waybar modules, package locks |
| Lua | Neovim configuration |
| TOML | Starship prompt |
| CSS | Waybar/Wofi styling |

## Common Mistakes to Avoid

1. **Don't use tabs** - All files use spaces (4 for bash/CSS, 2 for Lua)
2. **Don't forget `desc`** - Always add descriptions to Neovim keymaps
3. **Don't hardcode paths** - Use `$HOME` or `~/.config/` patterns
4. **Don't skip error handling** - Check command existence in scripts
5. **Don't break JSON output** - Waybar scripts must output valid JSON
6. **Don't create new stow packages** without the `.config/` structure

## Neovim Plugin Guidelines

- Use Lazy.nvim plugin spec format
- Prefer `opts` over `config` when possible
- Set `lazy = true` or use events for non-essential plugins
- Group related keymaps in the plugin's config function
- Use `<leader>` (Space) for custom keybindings

## Testing Changes

```bash
# Neovim: Check for Lua errors
nvim --headless -c "lua print('ok')" -c "qa"

# Shell: Syntax check
bash -n script.sh

# Stow: Dry run before applying
stow -n -v component-name

# Hyprland: Reload config (from running session)
hyprctl reload
```

## Dependencies

Core packages managed via `install-nvim.sh`:
- neovim, git, ripgrep, fd, lazygit
- nodejs, npm, python, python-pip
-
