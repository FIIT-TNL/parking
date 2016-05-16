#!/bin/bash

############# CONSTANTS ###########
Wc=12
Pf=49 	#48.1664
Rr=72.5
Rl=52.5

Pb=5
PI=$(echo "4 * a(1)" | bc -l)
ve=11.4
ve=8.5
tf_coef=0.45
tf_coef=0.48
tg_coef=0.25
#Mbulharskakonstanta=0.7
Mbulharskakonstanta=1

# Functions 
############# FUNCTIONS ###########
function arcsin() {
	arcsin=$(echo "a($1 / sqrt(1 - $1 * $1))" | bc -l)
	echo $arcsin
}

############# MAIN ###########
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
	bocik=$(echo "(2 * $Rr - $Wc / 2 - $D) / (2 * $Rr)" | bc -l)
	#arcsin_bocik=$(echo "a($bocik / sqrt(1 - $bocik * $bocik))" | bc -l)
	arcsin_bocik=$(arcsin $bocik)
	N=$(echo "2 * $Rr * c($arcsin_bocik)" | bc -l)
	Morig=$(echo "$N + $Pb" | bc -l)
	M=$(echo "$Morig * $Mbulharskakonstanta" | bc -l)
	echo "D=$D"
	echo "bocik=$bocik"
	echo "M=$M Morig=$Morig"
	echo "N=$N Pf=$Pf"

	SFz=$(./dist.sh FRONT)
	echo "SFz=$SFz"
	read -p "Vyruc dajaku klavesu [ENTER] abo daco..."
	
	#State S
	./go.sh forw
	SFz=$(./dist.sh FRONT)
	while [ "$state" != "S" ]; do
		SF1=$(./dist.sh FRONT)
		SF2=$(./dist.sh FRONT)
		SF3=$(./dist.sh FRONT)
		SF=$(echo "($SF1 + $SF2 + $SF3) / 3" | bc -l)
		dist=$(echo "$SFz - $SF" | bc -l)	

		# GRULA DEBUG
		echo "GRULA: SF=$SF dist=$dist"
		echo "  SFs: $SF1 $SF2 $SF3"
	
		# if dist < Pf, check parking space on side
		#if [ $dist -lt $Pf ]; then
		if (( $(echo "$dist < $Pf" | bc -l) )); then
			Ds1=$(./dist.sh SIDEBACK)
			echo "  Znam sebe predstavic: Ds1=$Ds1"
			#if [ $Ds1 -lt $(expr $Wc + $Ds) ]; then
			if (( $(echo "$Ds1 < $Wc + $Ds" | bc -l) )); then
				state=N
				break
			fi
		fi

		# Check if distance M is passed
		#if [ $dist -ge $M ]; then
		if (( $(echo "$dist >= $M" | bc -l) )); then
			state=S
		fi

		sleep 0.1
	done
	echo "stavy: $state"
	if [ "$state" == "N" ]; then
		continue
	fi	
done	
./go.sh stop
echo "Mal si branic, bod S"
sleep 0.5
read -p "Vyruc dajaku klavesu [ENTER] abo daco..."

# Calculate E
temp2=$(echo "(2 * $Rr - ($Wc / 2) - $D) / (2 * $Rr)" | bc -l)
alpha=$(arcsin $temp2)
beta=$(echo "($PI / 2) - $alpha" | bc -l)
E=$(echo "2 * $PI * $Rr * ($beta / (2 * $PI))" | bc -l)
te=$(echo "$E / $ve" | bc -l)
echo "alpha=$alpha"
echo "beta=$beta"
echo "E=$E"
echo "te=$te ve=$ve"

./steer.sh right
./go.sh back
sleep $te

./go.sh stop
echo "Vyborne, bod B"
sleep 0.5


# Go to C
# Ta to tie casy te a tf su trojclenkovo umerne polomerom Rr a Rl
tf=$(echo "$te * $tf_coef" | bc -l)
./steer.sh left
./go.sh back
sleep $tf

./go.sh stop
echo "Ked poviem A tak poviem B ..B ...bod C"
sleep 0.5

# Go to G
tg=$(echo "$te * $tg_coef" | bc -l)
./steer.sh s
./go.sh forw 
sleep $tf

./go.sh stop
echo "GOOOOOL G"
sleep 0.5



# Just to be sure
./go.sh stop
