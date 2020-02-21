#!/bin/bash

xmodmap -e "keycode 135 = Control_L"
xset -r 135
xmodmap -e "add control = Control_L"
xmodmap -e "remove control = Menu" # Prevent the old key from opening the menu

exit 0
