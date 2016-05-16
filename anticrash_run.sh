#!/bin/bash

while true; do
	./nevyruc.sh debug
	if [ $? -ne 0 ]; then
		exit 1
	fi
	sleep 0.3
done
