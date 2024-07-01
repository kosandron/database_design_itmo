#!/bin/bash
db="$1"
user="$2"
port="$3"
echo "5"
for i in {1..1000}; do
    clubId=$i
    age=${RANDOM:0:2}
    firstname=$(echo $RANDOM | md5sum | head -c 10)
    lastname=$(echo $RANDOM | md5sum | head -c 10)
    passport=$((i + 1000))
    countryId=${RANDOM:0:2}
    SQL="INSERT INTO trainers (passport, firstname, lastname, clubId, countryId, age)
     VALUES ($passport, '$firstname', '$lastname', $clubId, $countryId, $age);"
    psql -h localhost -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL"  --quiet
done