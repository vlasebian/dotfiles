#!/bin/bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian

# Install options
ctf_tools = false
nvim_instead_of_vim = false

# Check if script is run with sudo
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

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

    if ctf_tools
    then
        echo "======   Installing ctf tools... ======"
        apt-get -y install ${CTF[@]}
        pip install --upgrade pip
        pip install --upgrade pwntools
    fi

} 2> errors.txt

apt-get update --fix-missing;
apt-get autoremove;
apt-get clean;

# Change user
USER=vlasebian

# Link dotfiles and modify current user directories
sudo -u "$USER" -i /bin/bash - <<-'EOF'
    bash aux-scripts/link_dotfiles.sh ctf_tools nvim_instead_of_vim
EOF

# ONLY FOR DEBIAN! - set contrib, non-free
# TODO - overwrite the original file, also put others repo in (slack and 
# boostnote)

# Stuff for bluetooth speakers
apt-get install bluez bluez-tools bluez-firmware pulseaudio-module-bluetooth

# Alt - Tab only on current workspace
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

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
    wireshark
)
