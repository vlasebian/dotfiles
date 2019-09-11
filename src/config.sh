#!/usr/bin/env bash

USER=vlasebian
SEC_TOOLS=false


# essential packages used for installing other packages
ESS=(
    build-essential
    manpages-dev
    libtool
    autoconf
    automake
    autotools
    module-assistant
    apt-transport-http
)

# main programs that i use in my workflow
MAIN=(
	terminator
    typora
    slack-desktop
    vim
    vim-common
    vim-addon-manager
    code
)

# command line tools
CLI=(
    wget
    curl
    zip
    p7zip
    htop
    tree
	unrar
    lshw
    irssi
    bash-completion
    inetutils-tools
)

# drivers and hardware related
HW=(
    firmware-atheros
)

# compilers and libraries
CODING=(
    gcc-multilib
    clang
    gdb
    python3-dev
    python3-pip
    nasm
)

# tools for security and ctfs
if [ "$SEC_TOOLS" = true ]; then
    SEC=(
        ltrace
        strace
        netcat
        libpcap-dev
        libssl-dev
        libffi-dev
        wireshark
    )
else
    SEC=()
fi

# media related apps
MEDIA=(
    vlc
)

TOOLS=(
    ESS
    MAIN
    CLI
    HW
    CODING
    SEC
    MEDIA
)