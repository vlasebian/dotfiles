#!/usr/bin/env bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian

# import variables
source src/config.sh;


# do not add ppa repositories, they are not for debian
add_repositories() {

    apt-get -y update;
    apt-get -y upgrade;

    apt-add-repository -y non-free;
    apt-add-repository -y contrib;

    # add typora repository
    wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
    add-apt-repository 'deb https://typora.io/linux ./'

    apt-get -y update;

    # add vscode repository
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    rm packages-microsoft-gpg

    apt-get -y update;

}


install_packages() {

	apt-get -y update;
	apt-get -y upgrade;

    for app in ${PACKAGES[@]}; do
        echo "##### " $app "#####";
        sleep 1;
	    apt-get -y build-dep $app && apt-get -y install $app;
    done

	apt-get update --fix-missing;
	apt-get autoremove;
	apt-get clean;

}


add_configurations() {

	# set hostname or wifi hotspot won't work
	hostnamectl --pretty set-hostname onmiovn;

	# limit switching apps (Alt - Tab shorcut) to current workspace
	gsettings set org.gnome.shell.window-switcher current-workspace-only true;
	gsettings set org.gnome.shell.app-switcher current-workspace-only true;

}


make_user_specific_conf() {

	sudo -u "$USER" -i /bin/bash - <<-'EOF'
	{
		# Install fzf
		#git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf;
		#source $HOME/.fzf/install;
		
		# Install Vundle
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim;

		# Link files and configure vim
		bash $HOME/.dotfiles/src/link_dotfiles.sh $SEC_TOOLS;

		# change ssh key permissions
		chmod 700 $HOME/.ssh;
		chmod 644 $HOME/.ssh/id_rsa.pub;
		chmod 600 $HOME/.ssh/id_rsa;

		# make a directory for repos
		mkdir $HOME/.repos;

		# clone notes
		mkdir -p $HOME/.repos/notes;
		git clone  git@github.com:vlasebian/notes.git $HOME/.repos/notes;
			
		# clone snippets
		mkdir -p $HOME/.repos/snippets;
		git clone  git@github.com:vlasebian/snippets.git $HOME/.repos/snippets;

		# clone random-algorithms
		mkdir -p $HOME/.repos/algorithms;
		git clone  git@github.com:vlasebian/random-algorithms.git $HOME/.repos/algorithms;

		# clone hw
		mkdir -p $HOME/.repos/homework;
		git clone  git@github.com:vlasebian/homework.git $HOME/.repos/homework;

		# clone sec
		mkdir -p $HOME/.repos/ctf;
		git clone  git@github.com:vlasebian/ctf.git $HOME/.repos/ctf;

	} 2> user-wide_errors.txt
	EOF

}


main() {

	# check if script is run with sudo, if not, exit with code 1
	if [[ $UID != 0 ]]; then
	    echo "Please run this script with sudo:"
	    echo "sudo $0 $*"
	    exit 1
	fi

    # ssh keys check
    echo "Did you copy your ssh keys? [Y/n]"
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Go copy your keys, mate, then run the script again."
        exit 1
    fi

    echo "Okay, then, here we go!";
    sleep 5;

	add_repositories;
	install_packages;
	add_configurations;
	make_user_specific_conf;

	echo "     #### Installation complete ! #### "

} 2> system-wide_errors.txt

main
