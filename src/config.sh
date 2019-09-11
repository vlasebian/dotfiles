#!/usr/bin/env bash

USER=vlasebian
SEC_TOOLS=false


PACKAGES=(

    # essential packages used for installing other packages

    build-essential
    manpages-dev
    libtool
    autoconf
    automake
    autotools
    module-assistant
    apt-transport-http

	# main programs that i use in my workflow

    terminator
    typora
    slack-desktop
    vim
    vim-common
    vim-addon-manager
    code

    # command line tools

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

    # drivers and hardware related

    firmware-atheros

    # compilers and libraries

    gcc-multilib
    clang
    gdb
    python3-dev
    python3-pip
    nasm

    # tools for security and ctfs

    ltrace
    strace
    netcat
    #libpcap-dev
    #libssl-dev
    #libffi-dev
    #wireshark
 

    # media related apps

    vlc
)

