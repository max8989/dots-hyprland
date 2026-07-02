# ~/.zshrc — lean zsh setup (managed via dots-hyprland stow package)

# --- PATH / env (migrated from previous ~/.zshrc) ---
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.npm-global/bin:$PATH"

# --- History ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY INC_APPEND_HISTORY

# --- Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
setopt AUTO_CD                                             # `dir` == `cd dir`

# --- Autosuggestions (fish-style ghost text) ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# --- Tool integrations ---
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null

# --- Aliases ---
alias ls='eza --group-directories-first --icons'
alias ll='eza -lh --group-directories-first --icons'
alias la='eza -lah --group-directories-first --icons'
alias lt='eza --tree --icons'
alias cat='bat --paging=never'

# --- Syntax highlighting (MUST be sourced last) ---
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
