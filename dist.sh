#!/bin/bash

# sensor GPIOS (trigger echo)
SENS_FRONT=(12 16)
SENS_BACK=(8 7)
SENS_SIDEFRONT=(9 11)
SENS_SIDEBACK=(14 15)

if [ $# -eq 0 ]; then
	echo "usage $0 [FRONT|BACK|SIDEFRONT|SIDEBACK]"
	exit 1
fi

for sens in "$@"; do
	case "$sens" in
		FRONT)
			dist=$(./getdist2 ${SENS_FRONT[@]})
			;;
		BACK)
			dist=$(./getdist2 ${SENS_BACK[@]})
			;;
		SIDEFRONT)
			dist=$(./getdist2 ${SENS_SIDEFRONT[@]})
			;;
		SIDEBACK)	
			dist=$(./getdist2 ${SENS_SIDEBACK[@]})
			;;
		*)
			echo "usage $0 [FRONT|BACK|SIDEFRONT|SIDEBACK]"
			exit 1
	esac
	echo -n "$dist "
done
echo
