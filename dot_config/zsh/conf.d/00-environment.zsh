# path
typeset -aU path  # only allow a path to appear once
path=($HOME/.cargo/bin $path)
path=($HOME/.local/bin $path)
path=($HOME/.bin $path)

# editor
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='less -R --use-color -Dd+r -Du+b'

# language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# go
export GOPATH=$HOME/src/go

# nnn
export NNN_PLUG="v:openmpv"

# ssh
export SSH_AUTH_SOCK=/run/user/$(id -u)/ssh-agent.socket

# dbus
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
