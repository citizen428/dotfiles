#!/usr/bin/env ksh
# bash only added associative arrays in version 4 (2009)
# while ksh had them since 1993. macOS still ships with
# bash 3 by default, so ksh it is.

if [[ ! $(command -v stow &> /dev/null) ]]; then
	echo "stow not available, aborting."
	exit 1
fi

function stow_config {
	echo "Linking $2 in $1"
	stow -t $1 $2
}

typeset -A configs=(
	[bin]=/usr/local/bin
	[fish]=~/.config
	[git]=~
	[haskell]=~
	[helix]=~/.config
	[i3]=~/.config
	[kitty]=~/.config
	[neomutt]=~
	[python]=~
	[postgres]=~
	[rofi]=~/.config
	[ruby]=~
	[tmux]=~/.config
	[vim]=~
	[wezterm]=~/.config
  [zed]=~/.config
	[zsh]=~
)

if [[ $# -gt 0 ]]; then
	# We got a list of configs on the command line
	for config in $@; do
	  directory=${configs[$config]}
	  if [[ -n "${directory}" ]] ; then
	    stow_config $directory $config
	  else
	    echo "Unknown config ${config}, check spelling"
	  fi
	done
else
	# Interactively confirm each known config
	for config in "${!configs[@]}"; do
	  directory=${configs[$config]}
	  read -n1 confirm?"Install ${config}? [y/n] " 
	  echo
	  if [[ "$confirm" = "y" || "$confirm" = "Y" ]]; then
	    stow_config $directory $config
	  else
	    echo "Skipping ${config}"
	  fi
	done
fi
