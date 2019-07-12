#!/bin/bash

TOOLS=(
    atom-clock

    # indent plugin
    atom-beautify

    # nice file icons
    file-icons

    # stackoverflow in atom
    ask-stack

    # show colors on hex code
    pigments

    # highlight todo comments
    todo

    # autocomplete html elements
    emmet

    # live server, refreshes on file save
    atom-live-server

    # live collaboration
    teletype

    # atom ide plugin
    atom-ide-ui

    # language client for linting
    language-client

    # vim stuff
    vim-mode-plus
    ex-mode
)

LANGS=(
    ide-typescript
    ide-haskell
    ide-haskell-repl
    ide-python
    ide-cpp
    ide-css
    ide-json
    ide-html
    ide-dlang
    ide-java
)

THEMES=(
    atom-material-syntax
    atom-material-ui
)

main() {
    apm install ${TOOLS[@]}
    apm install ${LANGS[@]}
    apm install ${THEMES[@]}
}

main
