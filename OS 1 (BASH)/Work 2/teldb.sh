#!/bin/bash

f=catalog

# If catalog file doesnt exist create one.
if ! test -f "$f"; then
    touch $f
fi

if [[ $1 == -a ]]; then      #-a parameter
    echo "New entry in $f (Press enter after typing and dont use space or tab)."
    echo "Give first name"
    read First
    echo "Give last name"
    read Last
    echo "Give city name"
    read City
    echo "Give phone number"
    read Number
    echo "$First $Last $City $Number" >> $f

elif [[ $1 == -l ]]; then    #-l parameter
    echo "Contents of $f."
    egrep [[:alnum:]] $f | nl

elif [[ $1 == -s ]]; then    #-s parameter
    if [[ $2 =~ ^[[:digit:]]+$ ]]; then
        echo "Contents of $f sorted by column $2."
        egrep . $f | sort -k$2,$2
    else
        echo "When using -s, you need an integer for the second parameter."
    fi

elif [[ $1 == -c ]]; then    #-c parameter
    if [[ $2 =~ ^[[:alnum:]]+$ ]]; then
        cnt=$(egrep -c $2 $f)
        if [ $cnt != 0 ]; then
            echo "Catalog lines that contain the keyword \"$2\", given as the second parameter."
            egrep $2 $f | nl
        else
            echo "None of the catalog lines contain the keyword \"$2\""
        fi
    else
        echo "When using -c you need an alphanumeric for the second parameter."
    fi

elif [[ $1 == -d ]]; then    #-d parameter
    if [[ $2 =~ ^[[:alnum:]]+$ ]] && [[ $3 == -b || $3 == -r ]]; then
        cnt=$(egrep -c $2 $f)
        if [ $cnt != 0 ]; then
            if [[ $3 == -b ]]; then
                echo "Deleted catalog lines that contained the keyword \"$2\" and left it blank."
                sed -i "/$2/c\ " $f
            elif [[ $3 == -r ]]; then
                echo "Completely deleted catalog lines that contained the keyword \"$2\"."
                sed -i "/$2/d" $f
            fi
        else
            echo "None of the catalog lines contain the keyword \"$2\""
        fi
    else
        echo "When using -d you need an alnum for 2nd parameter and -b or -r for the 3rd parameter."
    fi

elif [[ $1 == -n ]]; then    #-n parameter
    echo "Number of empty lines in catalog."
    egrep -c '^[[:space:]]' $f
    echo "Do you want to delete them? Type Y if yes, N if not."
    read inp
    while [[ $inp != [YyNn] ]]; do
        read inp
    done
    if [[ $inp == [Yy] ]]; then
        sed -i "/^[[:space:]]/d" $f
        echo "Empty files in catalog deleted."
    fi

else                         #else parameter
    echo "ERROR unidentified parameter used."
    echo "  -a For new entry in catalog."
    echo "  -l For catalog contents."
    echo "  -s int For catalog contents sorted by column. Which column is decided by the int given."
    echo "  -c keyword For catalog lines containing the keyword given."
    echo "  -d keyword -b||-r Deletes catalog lines containing keyword. If using -b makes deleted lines blanks, else if -r completely deletes lines."
    echo "  -n For number of catalog lines that are empty. Then asks user if he wants to delete them."
fi











