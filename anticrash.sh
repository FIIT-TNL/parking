#!/bin/bash

# Needed to kill this script
trap "exit 1" TERM
export TOP_PID=$$

side_limit=10
fwbw_limit=15
led=25
led_sleep=5

# Trigger-Echo pairs in this order: front, back, side_front, side_back
GPIOS=(12 16 8 7 9 11 14 15)


debug=$1

# check(dist, limit)
function check(){
	dist=$(./dist.sh $1)
	
	# Too close, stop, light up led for a while and kill this script
	if (( $(echo "$dist < $2" | bc -l) )); then
		./go.sh stop
		echo
		echo "SKORO SA VYRUCILO !!!!"
		echo
		echo 1 > /sys/class/gpio/gpio$led/value	
		sleep $led_sleep
		echo 0 > /sys/class/gpio/gpio$led/value	
		echo "PRAVIDLA cezo mna nepredju"
		# kill this 
		kill -s TERM $TOP_PID
	fi
}

 
echo 0 > /sys/class/gpio/gpio$led/value	

dists=($(./getdist2 ${GPIOS[@]}))

if [ "$debug" == "debug" ]; then
	echo ${dists[@]}
fi

echo ${dists[0]};
echo ${#dists[@]};

check ${dists[0]} $fwbw_limit
check ${dists[1]} $fwbw_limit
check ${dists[2]} $side_limit
check ${dists[3]} $side_limit


