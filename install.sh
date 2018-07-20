#!/bin/bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian

# User name
USER=vlasebian

# Install options
ctf_tools=1
nvim_instead_of_vim=1

# Check if script is run with sudo
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

function install_packages {

    apt-get -y update
    apt-get -y upgrade

    echo "======   Installing tools...     ======"
    apt-get -y install ${TOOLS[@]}

    echo "======   Installing editor...    ======"
    apt-get -y install ${EDITOR[@]}

    echo "======   Installing languages... ======"
    apt-get -y install ${LANGS[@]}

    if [[ "$ctf_tools" -eq 1 ]]; then
        echo "======   Installing ctf tools... ======"
        apt-get -y install ${CTF[@]}
        pip install --upgrade pip
        pip install --upgrade pwntools
    fi

    apt-get update --fix-missing;
    apt-get autoremove;
    apt-get clean;

}

# Stuff that will be installed
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
    bash-completion
    firmware-atheros
    lshw
    gconf2
    curl
)

EDITOR=(
    vim
    neovim
)

LANGS=(
    gcc
    g++
    libcurl4-openssl-dev
    clang
    gdb
    openjdk-8*
    python
    python3.5
    python-dev
    python-pip
    gdc
)

CTF=(
    ltrace
    strace
    netcat
    gcc-multilib
    libpcap-dev
    libssl-dev
    libffi-dev
    build-essential
    nasm
    bless
    radare2
    # wireshark
)

apt-add-repository non-free
apt-add-repository contrib

# Install packages
install_packages;

# Alt - Tab only on current workspace
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

sudo -u "$USER" -i /bin/bash - <<-'EOF'
{
    # Link files and configure vim
    bash $HOME/.dotfiles/aux-scripts/link_dotfiles.sh $ctf_tools $nvim_instead_of_vim;

    # Install gnome-terminal themes
    bash $HOME/.dotfiles/themes/one-dark.sh
    bash $HOME/.dotfiles/themes/one-light.sh

    # Stuff for bluetooth speakers
    # apt-get install bluez bluez-tools bluez-firmware pulseaudio-module-bluetooth

    echo "     #### Installation complete ! #### "

} 2> errors.txt
EOF
