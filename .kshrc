PS1='$USER:$PWD# '
export PS1

function mcd { mkdir $1 && cd $1; }
