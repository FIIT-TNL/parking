#!/bin/bash

# Constants
Wc=12
Pf=49 	#48.1664
R=72.5
Pb=5

Ds=$(./dist.sh SIDEBACK)
echo "Ds=$Ds"

./steer.sh straight
./go.sh forw


# state: N -> Z -> S -> B -> C -> G(gool, grula)
state=N

# Look for S
while [ "$state" != "S" ]; do
	while [ "$state" != "Z" ]; do
		Ds1=$(./dist.sh SIDEBACK)
		if [ $Ds1 -ge $(expr $Wc + $Ds) ]; then
			state=Z
		fi
		
		# GRULA DEBUG
		x=$(expr $Wc + $Ds)
		echo "GRULA: Ds=$Ds Ds1=$Ds1  Wc+Ds=$x"	
		sleep 0.3
	done
	
	./go.sh stop
	echo "Gool, bod Z"
	sleep 0.5
	
	# Calculate M
	D=$(echo "$Ds + $Wc / 2" | bc -l)
	bocik=$(echo "(2 * $R - $Wc / 2 - $D) / (2 * $R)" | bc -l)
	arcsin_bocik=$(echo "a($bocik / sqrt(1 - $bocik * $bocik))" | bc -l)
	N=$(echo "2 * $R * c($arcsin_bocik)" | bc -l)
	M=$(echo "$N + $Pb" | bc -l)
	echo "D=$D"
	echo "bocik=$bocik"
	echo "M=$M N=$N"
	
	#State S
	./go.sh forw
	SFz=$(./dist.sh FRONT)
	while [ "$state" != "S" ]; do
		SF=$(./dist.sh FRONT)
		dist=$(expr $SFz - $SF)	
	
		# if dist < Pf, check parking space on side
		if [ $dist -lt $Pf ]; then
			Ds1=$(./dist.sh SIDEBACK)
			echo "Znam sebe predstavic: Ds1=$Ds1"
			if [ $Ds1 -lt $(expr $Wc + $Ds) ]; then
				state=N
				break
			fi
		fi

		# Check if distance M is passed
		#if [ $dist -ge $M ]; then
		if (( $(echo "$dist >= $M" | bc -l) )); then
			state=S
		fi

		# GRULA DEBUG
		echo "GRULA: dist=$dist"
		sleep 0.3
	done
	echo "stavy: $state"
	if [ "$state" == "N" ]; then
		continue
	fi	

	./go.sh stop
	echo "Mal si branic, bod S"
	break	

	
	
done	

./go.sh stop
