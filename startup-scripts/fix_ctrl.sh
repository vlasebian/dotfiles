#!/bin/bash

xmodmap -e "keycode 151 = Control_L"
xset -r 151
xmodmap -e "add control = Control_L"

exit 0
