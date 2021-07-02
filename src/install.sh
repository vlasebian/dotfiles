#!/usr/bin/env bash

BASE_DIR="$(dirname "$(stat -f "$0")")"

# Import environment variables.
source "$BASE_DIR"/env.sh

run_linux_setup() {
    echo "Setting up system for Linux platform"

    # 1. Installing
    # 2. Configuring
    # 3. Downloading

    source "$BASE_DIR"/src/debian/setup.sh
    run_debian_setup
}

run_darwin_install() {
    echo "Setting up system for Darwin platform"

    source "$BASE_DIR"/src/darwin/setup.sh
    run_darwin_setup
}

install() {
    case $(uname | tr '[:upper:]' '[:lower:]') in
        linux*)
            # Linux
            run_linux_install
            ;;
        darwin*)
            # MacOS
            echo "MacOS platform not supported."
            # run_darwin_install
            ;;
        msys*)
            # Windows
            echo "Windows platform not supported."
            ;;
        *)
            # Other
            echo "Unkown platform. Not supported."
            ;;
    esac

    # Run common configurations.
    source "$BASE_DIR"/src/common/common.sh
    configure_common
}

install "$@"
