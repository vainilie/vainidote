#!/usr/bin/env bash
DIR="$HOME/.config/polybar"
u=$(xprop -name "Polybar-tray" _NET_WM_PID | awk -F "= " '{print $2}')
    if [ $u ] ; then 
        kill $u
    else
        polybar -r -q tray1 -c "$DIR"/config.ini &
        sleep 10s
        v=$(xprop -name "Polybar-tray" _NET_WM_PID | awk -F "= " '{print $2}') 
        kill $v
fi