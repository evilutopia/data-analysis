#!/bin/sh

echo "Time,Channel,OrigBytes,CompressedBytes,SentBytes" > $2
grep "GatewayCounter.*LogCurrentStatus" $1|sed -e "s/\([a-zA-Z]\) \+\([a-zA-Z]\)/\1_\2/g" -e "s/\([0-9]\) \+\([^0-9]\)/\1,\2/g" -e "s/: \+\([0-9]\)/,\1/g"| sed "s/@/,/g"| cut -d"," -f1,12,13,16,17,19,20,24,25| grep -v fragment| sed "/Gateway_total_sent/s/\(.*\),\(Gateway_total_sent.*\)/\1,Channel_No,0,O_bytes,0,C_bytes,0,\2/" | grep Channel|sed "s/]//"| cut -d',' -f1,3,5,7,9 >> $2 
