#!/bin/bash

if [[ ($# -eq 0) || ("$1" == "stop") || ("$1" == "s") ]]; then
	/home/pi/drive/stop.sh
fi

if [[ ("$1" == "forward") || ("$1" == "forw") || ("$1" == "f") ]]; then
	/home/pi/drive/forward.sh
fi

if [[ ("$1" == "backward") || ("$1" == "back") || ("$1" == "b") ]]; then
	/home/pi/drive/backward.sh
fi


