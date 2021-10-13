#!/usr/bin/bash

a=$(pwd)
sudo updatedb
location=$(locate research)
echo "file is located at: " $location
echo
sleep 3
x=$(locate research | awk -F "/" '{print $NF}'|wc|awk '{print $NF}')
y=$(expr $x + 1 )
path=$(locate research|rev|cut -c$y-|rev)
ext=$(locate research | awk -F "." '{print $NF}')
cd $path/
echo "Currently we are in" $path/
echo
echo We have extracted the file from the compressed file
if (("$ext" == tar));
then
	tar xvf research.tar;
else
	gzip -d research.gz;
fi
ls -lrth|grep research
sleep 5
echo
echo This is the content within the file:
echo 
cat research.txt
echo
sleep 8
wc=$(cat research.txt|wc -l)
echo "We have renamed the file with the number of lines within the file (eg: if file had 10 lines, its name would become 10)."
echo
echo "In our case number of lines are" $wc
echo
mv research.txt $wc
ls -lrth|egrep "$wc|research"
sleep 8
echo
echo content of the file remains same till now
echo
cat $wc
echo 
sleep 5
uniq -d $wc >  unique.txt
echo 'Now the consicutively repeated lines are stored in a file called "unique.txt"'
ls -l
sleep 8
echo
echo Content of file unique.txt is:
echo
cat unique.txt
ln unique.txt $a/final.txt
sleep 5
echo
echo "As you can see, unique.txt now has been hidden."
mv $path/unique.txt $path/.unique.txt
ls -l
cd $a/
sleep 5
echo
echo "Now we are in our current working directory, which is:" $a/
echo
echo "hardlink of 'unique.txt' with name 'final.txt' has been created in pwd"
echo
ls -lrth|grep final.txt
sleep 8
echo
echo Content within hardlink created by name final.txt is:
cat final.txt
echo
echo "Goodbye!!!!!!"
