#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM referees;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
echo $count
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

for i in {1..1000}; do
    number=$((1 + $RANDOM % 100))
    age=$((1 + $RANDOM % 100))
    firstname=$(echo $RANDOM | md5sum | head -c 10)
    lastname=$(echo $RANDOM | md5sum | head -c 10)
    passport=$i
    SQL="INSERT INTO referees (passport, firstname, lastname, number, age) VALUES ($passport, '$firstname', '$lastname', $number, $age);"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
done