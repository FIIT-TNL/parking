#!/bin/bash

if [ $# -lt 3 ]; then
	a=4
	b=2
	c="1.5"
else
	a=$1
	b=$2
	c=$3
fi


if [ "${@: -1}" != "reverse" ]; then
	# Right backward
	./steer.sh right 
	./go.sh back
	sleep $a 
	
	# Left backward
	./steer.sh left
	sleep $b 
	
	# Straigh forward
	./steer.sh straight
	./go.sh forw 
	sleep $c

else 
	# Straigh backward
	./steer.sh straight
	./go.sh backward 
	sleep $c

	# Left backward
	./steer.sh l
	./go.sh forward
	sleep $b 
	
	# Right backward
	./steer.sh r 
	sleep $a 
	
fi

./go.sh stop
echo "Gool, mal se branic!"

