#!/bin/bash

iquery --afl --query \
    "load_library('accelerated_io_tools'); \
     create array rec<val:int64> [line, letter, num]; \
     create array rec_letter<val:string> [letter]"

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
