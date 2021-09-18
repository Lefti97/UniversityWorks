#!/bin/bash
SECONDS=0
value=0
while [ 1 ]
	do
	value=$(( $value + 1))
	duration=$SECONDS
	min=$(($duration / 60))
	sec=$(($duration % 60))
	echo "MIN:SEC = $min:$sec"
	echo "$value runs"
	./stack
	echo ""
done