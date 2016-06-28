#!/bin/bash

iquery --afl --query \
       'create array rec<val:int64> [line=0:*,10,0, letter=0:*,10,0, num=0:*,10,0];
        create array rec_letter<val:string> [letter=0:*,10,0]'

dir=$(dirname $(readlink -f $0))
query_file=`mktemp`

for file in $dir/rec-*.txt
do
    num=${file//[^0-9]/}
    letter=${file//[^A-Z]/}

    env T_FILE="$file" T_NUM="$num" T_LETTER="$letter" envsubst \
        < $dir/rec.afl.tmpl >> $query_file
done

iquery --afl --query-file $query_file
rm "$query_file"
