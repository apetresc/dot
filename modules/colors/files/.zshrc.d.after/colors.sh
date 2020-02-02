#!/bin/zsh

if [[ "$COLOR_SCHEME" == "solarized" ]]; then
	if [[ "$COLOR_SCHEME_TYPE" == "light" ]]; then
		eval $(dircolors ~/.config/colors/dircolors.ansi-solarized-light)
		zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
	fi
fi

