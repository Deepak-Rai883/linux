#!/usr/bin/bash

echo Contant of Original File:
cat sig.conf
echo
echo Kindly enter the value of \"view\":
read v
echo
#to ignore case sensetivity
shopt -s nocasematch
#filter for view values
if [[ $v == "AUCTION" || $v == "BID" ]]
then
echo Kindly enter the value of \"component-name\":
read c
echo
#filter for component name
if [[ $c == "INGESTOR" || $c == "JOINER" || $c == "WRANGLER" || $c == "VALIDATOR" ]]
then	
	#assigning view values
	if [[ $v == "AUCTION" ]]
	then
		a="vdopiasample"
	else
		a="vdopiasample-bid"
	fi
	#reading each line of the file and breaking the the values for view, scale, component-name and count
	n=1
	while read line;
	do
        	echo $line > a.txt
        	view="$(awk -F ";" '{print$1}' a.txt)"
        	scale="$(awk -F ";" '{print$2}' a.txt)"
        	component_name="$(awk -F ";" '{print$3}' a.txt)"
        	count="$(awk -F "=" '{print$NF}' a.txt)"
		#grabbing the line that needs to be changed according to user input
        	if [[ $a == $view && $c == $component_name ]]
		then
			echo Line number \"$n\" is to be changed which is: \"$line\"
			echo
			break
		fi
	n=`expr $n + 1`
	done < sig.conf
	if [[ $a == $view && $c == $component_name ]]
	then
		echo "Kindly enter the desired value for \"scale\": (valid inputs are low/mid/high)"
		declare -u s
		read s
		echo
		#filter for scale values
		if [[ $s == "LOW" || $s == "MID" || $s == "HIGH" ]]
		  	then
	 	   	echo "Kindly enter the desired value for \"count\": (valid inputs are integers 0 to 9)"
		  	read i
			#filter for count (only single digits are allowed)
		    	if [[ $i -ge 0 && $i -le 9 ]]
		      	then
				#using 'sed' command to change a specific line according to user input
		        	sed -i.bak '/'"${line}"'/s/.*/'"${a};${s};${component_name};ETL;vdopia-etl=${i}"'/' sig.conf
		        	echo
				#displaying the change that occured
		        	diff -w sig.conf.bak sig.conf
		        	rm sig.conf.bak
		        	rm a.txt
		      	else
		        	echo "Warning: Please enter valid value for \"count\"."
		    	fi
		fi
	else
		echo "There is no line in the file that matches with the given \"view\" and \"component-name\"." 
	fi
else
	echo "Warning: Please enter valid component-name."
fi
else
	echo "Warning: Please enter valid view."
fi
echo
echo Contant of Original FIle after changes:
cat sig.conf
