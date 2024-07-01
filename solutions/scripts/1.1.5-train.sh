#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Trainers;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

for ((i = 1; i <= $5; i++)); do
    clubId=$i
    age=$((1 + $RANDOM % 100))
    firstname=$(echo $RANDOM | md5sum | head -c 10)
    lastname=$(echo $RANDOM | md5sum | head -c 10)
    passport=$((i + 1000))
    countryId=${RANDOM:0:2}
    SQL="INSERT INTO trainers (passport, firstname, lastname, clubId, countryId, age)
     VALUES ($passport, '$firstname', '$lastname', $clubId, $countryId, $age);"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
done