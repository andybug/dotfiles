alias ls='exa --group-directories-first'
alias ll='ls -l --time-style=long-iso --color-scale --git'
alias la='ll -a'
alias lw='ll -snew'
alias lt='ll --tree --color=always'

alias vim=nvim
alias nnn='nnn -eA'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias i3config='vim ~/.config/i3/config'

# aws
alias prod='aws-vault exec prod -- '
alias aprod='aws-vault exec prod -- zsh -c "export AWS_PROFILE=prod; exec zsh"'
alias pondus='aws-vault exec pondus -- '
