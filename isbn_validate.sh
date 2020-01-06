#!/bin/sh

ISBN="$(cat $@ | tr -d '-')"

if [ $(echo "$ISBN" | wc -c) -eq 11 ]; then
	echo "ISBN-10"

	equation="$(echo "$ISBN" | awk 'BEGIN {FS=""; print "("} ; {for (i = NF; i > 0; i = i - 1) print "(" $i " * " i ")"}' | tr '\n' '+' | sed 's/^(+/(/' | sed 's,+$,) % 11,')"

	res="$(echo "$equation" | bc)"

	if [ 0 -eq $res ]; then
		echo "0 == $res"
		echo "Valid ISBN"
	else
		echo "0 != $res"
		echo "Invalid ISBN"
	fi
elif [ $(echo "$ISBN" | wc -c) -eq 14 ]; then
	echo "ISBN-13"
	echo "$ISBN"

	equation="$(echo "$ISBN" | awk 'BEGIN {FS=""; print "("} ; {for (i = NF ; i > 0; i = i - 1) print i%2==1?"(1*" $i ")":"(3*" $i ")"}' | tr '\n' '+' | sed 's/^(+/(/' | sed 's,+$,) % 10,')"

	echo $equation
	res="$(echo "$equation" | bc)"
	if [ 0 -eq $res ]; then
		echo "0 == $res"
		echo "Valid ISBN"
	else
		echo "0 != $res"
		echo "Invalid ISBN"
	fi
else
	echo "Invalid length"
	echo "Invalid ISBN"
fi
