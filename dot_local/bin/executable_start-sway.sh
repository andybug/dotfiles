#!/bin/sh

# https://github.com/swaywm/wlroots/blob/master/docs/env_vars.md

#export WLR_DRM_NO_MODIFIERS=1
#export WLR_NO_HARDWARE_CURSORS=1

#export WLR_DRM_NO_ATOMIC=1
#export WLR_RENDERER=gles2

export WLR_RENDERER=vulkan

#exec dbus-run-session sway -d -Dnoscanout 2>&1 | tee ~/.config/sway/logs/sway.log
#exec sway -d -Dnoscanout 2>&1 | tee ~/.config/sway/logs/sway.log
#exec sway -Dnoscanout
exec dbus-run-session sway
