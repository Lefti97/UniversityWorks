#!/bin/bash

if ! [[ -d $1 && -d $2 ]]; then
    echo "Parameters 1, 2 and 3 must be directories. If directory 3 doesnt exist creates new one."
    exit 0
fi

mkdir $3

echo "How many and which files of $1 are not present in $2. and their total size."
diff -q $1 $2 | egrep $1 -c
diff -q $1 $2 | egrep $1

echo
echo "How many and which files of $2 are not present in $1. and their total size."
diff -q $2 $1 | egrep $2 -c
diff -q $2 $1 | egrep $2

echo
echo "How many and which files are common in $1 and $2. and their total size"
diff -s $1 $2 | egrep -c "are identical$"
diff -s $1 $2 | egrep "are identical$"
identFiles1=$(diff -s $1 $2 | egrep " are identical$" | egrep -o "$1/[[:graph:]]* ")
identFiles2=$(diff -s $1 $2 | egrep " are identical$" | egrep -o "$2/[[:graph:]]* ")

echo
echo "All common files from $1 and $2 are moved to $3. Hard links of the common files are created in $1 and $2."
mv $identFiles1 $3
rm $identFiles2
ln $3/* $1
ln $3/* $2

