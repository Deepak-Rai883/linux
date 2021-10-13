#!/usr/bin/bash
#this script to be run with command "screen -m ./sleep.sh"
i=30
for j in {1..31};do
	if (($i >= 10)); 
	then
		echo "Screen will terminate in T-$i seconds..."
		i=$((i-5))
		j=$((j+5))
		sleep 5;
	else
		echo "Screen will terminate in $i"
         	i=$((i-1))
		j=$((j+1)) 
         	sleep 1;
	fi
	if (($i==0));then
		break;
	fi
done
