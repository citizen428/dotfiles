#!/usr/bin/env ksh
# bash only added associative arrays in version 4 (2009)
# while ksh had them since 1993. macOS still ships with
# bash 3 by default, so ksh it is.

if [[ ! $(command -v stow &> /dev/null) ]]; then
  echo "stow not available, aborting."
  exit 1
fi

typeset -A configs=(
	[asdf]=~ 
	[bin]=/usr/local/bin
	[git]=~
	[haskell]=~
	[homebrew]=~
	[i3]=~/.config
	[kitty]=~/.config
	[neomutt]=~
	[postgres]=~
	[ruby]=~
	[tmux]=~
	[vim]=~
	[zsh]=~
)

for config in "${!configs[@]}"; do
  directory=${configs[$config]}
  read -n1 confirm?"Install ${config}? [y/n] " 
  echo
  if [[ "$confirm" = "y" || "$confirm" = "Y" ]]; then
    echo "Linking ${config} in ${directory}"
    stow -t $directory $config
  else
    echo "Skipping ${config}"
  fi
done
