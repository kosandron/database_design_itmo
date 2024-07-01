#!/bin/bash


db="$1"
user="$2"
port="$3"
password="$4"
SQL="SELECT COUNT(*) FROM Countries;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi


echo "5"
for i in {1..100}; do
    #echo "num"
    id=$i
    name=$(echo $RANDOM | md5sum | head -c 10)
    SQL="INSERT INTO countries (id, name)
    VALUES ($id, '$name');"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
done