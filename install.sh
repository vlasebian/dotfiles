#!/usr/bin/env bash

##  Fresh system install setup
##  Created: June 2018
##  MIT License
##
##  vlasebian

BASE_DIR="$(dirname "$(stat -f "$0")")"

# Import environment variables.
source "$BASE_DIR"/env.sh

check_ssh_keys() {
    # Check for ssh keys.
    if [ ! -f "$SSH_KEY_FILE" ]; then
        echo "The $SSH_KEY_FILE key file was not found. You can change the   "
        echo "default ssh private key file by changing SSH_KEY_FILE in env.sh."
        echo "Exiting..."
        exit 1
    fi
}

main() {

    check_ssh_keys
    # check_for_sudo "$@"

    echo "Launching installation...";
    # Sleep for 5 seconds, in case you forgot something.
    sleep 5;

    start=$(date +%s)

    sudo -u "$USER" "$BASE_DIR"/src/install.sh 2>&1 | tee "$LOG_FILE"

    end=$(date +%s)
    runtime=$((end-start))

	echo "Installation complete. Time elapsed: $runtime."

}

