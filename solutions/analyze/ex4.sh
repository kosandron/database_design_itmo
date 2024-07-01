#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    EXPLAIN ANALYSE SELECT countries.name, sm.pc as "Count"
    FROM Countries as countries
    JOIN (SELECT countryId, COUNT(passport) as "pc"
    FROM Players
    GROUP BY countryId) as sm ON sm.countryId = countries.id
    ;
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet