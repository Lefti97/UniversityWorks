#!/bin/bash

if [[ ! $1 =~ ^[0-9]+$ || ! $2 =~ ^[+-]?[0-9]+$ ]]; then
    echo "You must give 2 integer parameters."
    exit 0
fi

tmp=0

sum1=0 
sum2=0
sum3=0
sum4=0
sum5=0

echo "Give name of directory or type / to exit."
read dir

while [ $dir != '/' ]; do

    echo
    tmp=$(find $dir -perm $1 -ls | wc -l)
    sum1=$(( sum1+tmp ))
    echo "Directory tree files with $1 permissions = $tmp"
    find $dir -perm $1 -ls

    echo
    tmp=$(find $dir -mtime -$2 -ls | wc -l)
    sum2=$(( sum2+tmp ))
    echo "Directory tree files that changed contect last $2 days = $tmp"
    find $dir -mtime -$2 -ls

    echo
    tmp=$(find $dir -atime -$2 -ls | wc -l)
    sum3=$(( sum3+tmp ))
    echo "Directory tree files that were accessed last $2 days = $tmp"
    find $dir -atime -$2 -ls
    
    echo
    tmp=$(find $dir -type p,s -ls | wc -l)
    sum4=$(( sum4+tmp ))
    echo "Directory tree files that are type pipe or socket = $tmp"
    find $dir -type p,s -ls

    echo
    tmp=$(find $dir -maxdepth 1 -empty -ls | wc -l)
    sum5=$(( sum5+tmp ))
    echo "Directory files that are empty = $tmp"
    find $dir -maxdepth 1 -empty -ls

    echo
    echo "Give name of directory or type / to exit."
    read dir

done

echo
echo "Sum of directory tree files with $1 permissions = $sum1"
echo "Sum of directory tree files that changed contect last $2 days = $sum2"
echo "Sum of directory tree files that were accessed last $2 days = $sum3"
echo "Sum of directory tree files that are type pipe or socket = $sum4"
echo "Sum of directory files that are empty = $sum5"

