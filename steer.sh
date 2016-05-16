#!/bin/bash

if [[ ($# -eq 0) || ("$1" == "straight") || ("$1" == "s") ]]; then
	#/home/pi/drive/straight.sh
	/home/pi/drive/straight_fw.sh
fi

if [[ ("$1" == "left") || ("$1" == "l") ]]; then
	/home/pi/drive/left.sh
fi

if [[ ("$1" == "right") || ("$1" == "r") ]]; then
	/home/pi/drive/right.sh
fi

