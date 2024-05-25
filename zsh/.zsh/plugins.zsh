[[ -f ~/.znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.znap/zsh-snap

source ~/.znap/zsh-snap/znap.zsh

znap source wfxr/forgit
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
