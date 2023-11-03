#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

MENU="$(rofi -no-lazy-grab -sep "|" -dmenu -no-fixed-num-lines -yoffset -100 -i -p '' \
<<< "󰗘 Cascade|󰃇 Tile|󰕶 Side by Side|󰒋 Stack|󰁌 Maximize|󰁄Minimize All|󰡏 Maximize Vertical|󰡎 Maximize Horizontal|󰪴 Toggle Tiling|")"
            case "$MENU" in
				*Cascade) xdotool key ctrl+alt+1 ;;
				*Tile) xdotool key ctrl+alt+2 ;;
				*Side*) xdotool key ctrl+alt+3 ;;
				*Stack) xdotool key ctrl+alt+4 ;;
				*Maximize)  xdotool getactivewindow windowsize 100% 100% ;;
                *All) xdotool key ctrl+alt+d ;;
                *Vertical) xdotool getactivewindow windowsize <(xdotool getactivewindow getwindowgeometry | grep -E [0-9]+x[0-9]+ -o | cut -d 'x' -f1) 100% ;;
                *Horizontal) xdotool getactivewindow windowsize 100% <(xdotool getactivewindow getwindowgeometry | grep -E [0-9]+x[0-9]+ -o | cut -d 'x' -f2) ;;
                *Tiling) xdotool key super+t ;;
            esac
