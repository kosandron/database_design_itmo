#!/bin/bash
db="$1"
user="postgres"
port="$3"
SQL="
    EXPLAIN ANALYSE SELECT countries.name, sm.pc as "Count"
    FROM Countries as countries
    JOIN (SELECT countryId, COUNT(passport) as "pc"
    FROM Players
    GROUP BY countryId) as sm ON sm.countryId = countries.id
    ;
    "
psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet