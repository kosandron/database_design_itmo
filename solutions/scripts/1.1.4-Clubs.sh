#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Clubs;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

for ((i = 1; i <= $5; i++)); do
    id=$i
    name=$(echo $RANDOM | md5sum | head -c 10)
    cityId=$((1 + $RANDOM % 100))
    stadiumId=$i
    SQL="INSERT INTO Clubs (id, name, cityId, stadiumId)
VALUES ($id, '$name', $cityId, $stadiumId);"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
done