#!/bin/bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

TOOLS=(
    wget
    curl
    zip
    p7zip
    make
    inetutils-tools
    htop
    irssi
    slack
    vlc
    mediainfo
    ffmpeg
    virtualbox
    boostnote
)

EDITOR=(
    vim
    neovim
)

LANGS=(
    gcc
    clang
    gdb
    openjdk-8*
    python
    python3.5
    python-dev
    python-pip
)

CTF=(
    gcc-multilib
    libpcap-dev
    libssl-dev
    libffi-dev
    build-essential
    nasm
    bless
    radare2
    #wireshark
)

# Install packages and set configurations
{

    apt-get -y update
    apt-get -y upgrade

    echo "======   Installing tools...     ======"
    apt-get -y install ${TOOLS[@]}

    echo "======   Installing editor...    ======"
    apt-get -y install ${EDITOR[@]}

    echo "======   Installing languages... ======"
    apt-get -y install ${LANGS[@]}

    echo "======   Installing ctf tools... ======"
    apt-get -y install ${CTF[@]}
    pip install --upgrade pip
    pip install --upgrade pwntools

} 2> errors.txt

apt-get update --fix-missing;
apt-get autoremove;
apt-get clean;

# Change user
USER=vlasebian

sudo -u "$USER" -i /bin/bash - <<-'EOF'

    PACK=$HOME/packages

    # Modify main directories
    mv $HOME/Downloads $HOME/downloads;
    mv $HOME/Documents $HOME/documents;
    mv $HOME/Pictures  $HOME/pictures;
    mv $HOME/Public    $HOME/share;

    mkdir $HOME/security;
    mkdir $HOME/dev-area;
    mkdir $HOME/university;

    rm -rf $HOME/Desktop;
    rm -rf $HOME/Templates;
    rm -rf $HOME/Music;
    rm -rf $HOME/Videos;

    # Check if directory exists, if not create it
    if [ ! -d "$PACK" ]; then
        mkdir $PACK
    fi;

    # Create directory for init.vim
    mkdir $HOME/.config/nvim;

    # Link init.vim
    ln -sf "$HOME/.dotfiles/vim/init.vim" "$HOME/.config/nvim";
    
    # Install vundle and plugins
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.config/nvim/bundle/Vundle.vim &&
    nvim +PluginInstall +qall;

    # Install gdb peda
    git clone https://github.com/longld/peda.git $PACK/peda
    echo "source $PACK/peda/peda.py" >> $HOME/.dotfiles/system/.gdbinit

    # Link directories configuration
    ln -sf "$HOME/.dotfiles/system/user-dirs.dirs" "$HOME/.config";

    # Link .gitconfig
    ln -sf "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig";

    # Link .gdbinit, .bash_profile, .bashrc, .bash_aliases
    for f in system/*
    do
        ln -sf "$f" "$HOME/.${f##*/}"
    done

    # Link template files
    ln -sf "$HOME/.dotfiles/templates" "$HOME/.templates";

EOF
