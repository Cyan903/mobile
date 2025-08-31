# Load shell profile
source "$HOME"/.config/shell/xdg
source "$HOME"/.config/shell/clean
source "$HOME"/.config/shell/alias

# Set history
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

HISTFILE=~/.cache/zhistfile
HISTSIZE=1000
SAVEHIST=1000

# Keybinds
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Tab completions
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist

compinit
_comp_options+=(globdots)

# Zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# direnv
eval "$(direnv hook zsh)"

# Starship
eval "$(starship init zsh)"

# Plugins
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-syntax-highlighting"
plug "MichaelAquilina/zsh-you-should-use"

# vim: ft=zsh
