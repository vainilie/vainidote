#!/bin/bash

case $1 in
	"toggle-mode")
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T
		;;
	"show-mode")
                status=`xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode`
                if [ $status == 'true' ]; then
                        echo "%{F#D97E96}"
                else
   	                echo "%{F#496886}"
                fi
		;;
esac
