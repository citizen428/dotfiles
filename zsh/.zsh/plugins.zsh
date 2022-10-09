znap_dir=~/.zsh-snap
znap_init="${znap_dir}/znap.zsh"

[[ -f $znap_init ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $znap_dir

source $znap_init
unset znap_dir znap_init

znap source agkozak/zsh-z
znap source wfxr/forgit
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

