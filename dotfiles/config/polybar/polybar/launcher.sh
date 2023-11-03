#!/bin/bash bash

# Add this script to your wm startup file.
DIR="$HOME/.config/polybar"
# Terminate already running bar instances
killall -9 -q polybar
killall -9 -q polybar-msg
killall -9 -q zscroll
killall -9 -q pactl
pkill -9 -f polybar/scripts
#polybar-msg cmd quit
# Wait until the processes have been shut down
while [ $(pgrep -f -a polybar | grep -v launch | grep -v code -c ) != "0" ]; do
    echo "Wait..."
    sleep 1; 
    done

echo "[temper]" | tee ~/.config/polybar/temper.ini
for i in /sys/class/hwmon/hwmon*/temp*_input; do 
    s=$(echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)")
    if [[ "$s" == *"edge"* ]]  ; then
        echo "amdgpu = " $s | cut -d ' ' -f 1,2,6 | tee -a ~/.config/polybar/temper.ini
    elif [[ "$s" == *"thermal"* ]]  ; then
        echo "acpitz = " $s | cut -d ' ' -f 1,2,6 | tee -a ~/.config/polybar/temper.ini
    else
        echo "k10temp = " $s | cut -d ' ' -f 1,2,6 | tee -a ~/.config/polybar/temper.ini
    fi;
    done


# Launch the bar
if [[ "$(xrandr --listactivemonitors | grep -e Monitors | cut -d ' ' -f 2)" == "1" ]] ; then
    polybar -r -q monitor1 -c "$DIR"/config.ini &
else     
    polybar -r -q monitor1 -c "$DIR"/config.ini & 
    polybar -r -q monitor2 -c "$DIR"/config.ini & 
fi


# IPC settings and test
ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-main
echo message >/tmp/ipc-main
