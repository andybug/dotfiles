export ZSH_COMPDUMP=$HOME/.local/share/zsh/zcompdump

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select
