#!/usr/bin/env bash

##  Bulk installer.
##  June 2018
##  MIT License
##
##  vlasebian

USER=vlasebian
CYBERSEC_TOOLS=true

# Import variables.
source src/packages.sh;

add_repositories() {
    apt-get -y update;
    apt-get -y upgrade;
    
    # Used for installing keys.
    apt-get -y install curl;

    # Uncomment when installing on Debian.
    #apt-add-repository -y non-free;
    #apt-add-repository -y contrib;

    # Add Typora repository.
    wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
    add-apt-repository 'deb https://typora.io/linux ./'

    # Add Visual Studio Code repository.
    curl https://packages.microsoft.com/keys/microsoft.asc | \
        gpg --dearmor > packages.microsoft.gpg;
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/;
    sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg]
    https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list';
    rm packages.microsoft.gpg;

    # Add Docker repository.
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
    apt-key fingerprint 0EBFCD88;
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable";

    # Install docker-composer.
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname-s)-$(uname -m)" -o /usr/local/bin/docker-compose;
    sudo curl -L https://raw.githubusercontent.com/docker/compose/1.27.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose;

    apt-get -y update;
}

install_packages() {
	apt-get -y update;
	apt-get -y upgrade;

    for app in ${PACKAGES[@]}; do
        echo "##### " $app "#####";
        sleep 1;
        apt-get -y install $app;
    done

	apt-get update --fix-missing;
	apt-get autoremove;
	apt-get clean;
}

add_configurations() {
	# Set hostname for using wifi hotspot, uncomment only on Debian.
	# hostnamectl --pretty set-hostname stoapoikile;

	# Limit switching apps (Alt - Tab shorcut) to current workspace.
	gsettings set org.gnome.shell.window-switcher current-workspace-only true;
	gsettings set org.gnome.shell.app-switcher current-workspace-only true;
}

make_user_specific_conf() {
	sudo -u "$USER" -i /bin/bash - <<-'EOF'
	{
		# Set ssh key permissions.
		chmod 700 $HOME/.ssh;
		chmod 644 $HOME/.ssh/id_rsa.pub;
		chmod 600 $HOME/.ssh/id_rsa;

		# Install fzf.
		#git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf;
		#source $HOME/.fzf/install;
		
		# Link files and configure vim.
		bash $HOME/.dotfiles/src/link_conf.sh;

        # Clone repositories.
		bash $HOME/.dotfiles/src/clone_repos.sh $CYBERSEC_TOOLS;

	} 2> user_install_errors.txt
	EOF
}

main() {

	# Check if script is run with sudo, else exit with code 1.
	if [[ $UID != 0 ]]; then
	    echo "Please run this script with sudo:"
	    echo "sudo $0 $*"
	    exit 1
	fi

    # ssh keys check.
    echo "Did you copy your ssh keys? [Y/n]"
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Go copy your keys, mate, then run the script again."
        exit 1
    fi

    echo "Okay, then, here we go!";
    # Sleep for 5 seconds, in case you forgot something.
    sleep 5;

	add_repositories;
	install_packages;
	add_configurations;
	make_user_specific_conf;

	echo "     #### Installation complete ! #### "

} 2> system_install_errors.txt

main
