#!/bin/bash
s=$(bash docker-entrypoint-initdb.d/ex5.sh  dbhw2 postgres 5432)
p=$(echo "$s" | grep -i "Planning")
d=$(echo "$s" | grep -i "Execution")
echo "$p"
echo "$d"
#newline=$(echo "$line" | tr "=" " ")
read fw sw tw 4w <<< $p
echo "$fw"
echo "$sw"
echo "$tw"
