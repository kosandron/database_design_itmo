#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Stadiums;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi
for ((i = 1; i <= $5; i++)); do
    id=$i
    name=$(echo $RANDOM | md5sum | head -c 10)
    adress=$(echo $RANDOM | md5sum | head -c 10)
    SQL="INSERT INTO Stadiums (id, name, adress)
VALUES ($id, '$name', '$adress');"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
    #echo "$i"
done