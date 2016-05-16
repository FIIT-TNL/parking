#!/bin/bash

# Constants
WC=12

Ds=$(./dist.sh SIDEBACK)
echo "Ds=$Ds"

./steer.sh straight
./go.sh forw

state=N

while [ "$state" == "N" ]; do
	Ds1=$(./dist.sh SIDEBACK)
	if [ $Ds1 -ge $(expr $WC + $Ds) ]; then
		state=Z
	fi
	
	x=$(expr $WC + $Ds)
	echo "Ds=$Ds Ds1=$Ds1  WC+Ds=$x"	
	sleep 0.3
done

./go.sh stop
