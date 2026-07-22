function clone --description 'Clones a repository and cds into it' --argument url
    git clone $url
    cd (string split . (basename $url))[1]
end
