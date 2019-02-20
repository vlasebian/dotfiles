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

# Check if script is run with sudo, if not, exit with code 1
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

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
    vlc
    mediainfo
    ffmpeg
    tree
    # bash-completion
    # firmware-atheros
    lshw
    gconf2
	libcurl4
    curl
    indicator-keylock
	terminator
)

LANGS=(
    gcc
    g++
    libcurl4-openssl-dev
    clang
    gdb
    openjdk-9*
    openjdk-8*
    python
    python3.5
    python-dev
    python-pip
    # gdc
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
    # radare2
    wireshark
)

function add_repositories {
    apt-get -y update
    apt-get -y upgrade

	# apt-add-repository -y non-free
	# apt-add-repository -y contrib
	add-apt-repository -y ppa:tsbarnes/indicator-keylock

    apt-get -y update
    apt-get -y upgrade
}

function install_packages {
    apt-get -y update
    apt-get -y upgrade

    echo "======   Installing tools...     ======"
    apt-get -y install ${TOOLS[@]}

    echo "======   Installing vim...    ======"
    apt-get -y install vim-gnome

    echo "======   Installing languages... ======"
    apt-get -y install ${LANGS[@]}

    if [[ "$ctf_tools" -eq 1 ]]; then
        echo "======   Installing ctf tools... ======"
        apt-get -y install ${CTF[@]}
        pip install --upgrade pip
        pip install --upgrade pwntools
    fi

	echo "======   Installing atom...   ======"
	apt-get install gconf2 gconf-service libcurl4
	wget https://atom.io/download/deb -O atom.deb
	#dpkg -i -y atom.deb
	rm -rf atom.deb

    apt-get update --fix-missing;
    apt-get autoremove;
    apt-get clean;
}

add_repositories;
install_packages;

# Alt - Tab only on current workspace
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Make user specific settings
sudo -u "$USER" -i /bin/bash - <<-'EOF'
{
    # Link files and configure vim
    bash $HOME/.dotfiles/aux-scripts/link_dotfiles.sh $ctf_tools;

    echo "     #### Installation complete ! #### "
} 2> errors.txt
EOF
