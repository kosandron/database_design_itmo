#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Cities;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi
for i in {1..100}; do
    #echo "num"
    id=$i
    name=$(echo $RANDOM | md5sum | head -c 10)
    countryId=$((1 + $RANDOM % 100))
    SQL="INSERT INTO cities (id, name, countryId)
VALUES ($id, '$name', $countryId);"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
    #echo "$i"
done