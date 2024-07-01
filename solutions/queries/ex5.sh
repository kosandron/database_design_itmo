#!/bin/bash
db="$1"
user="postgres"
port="$3"
SQL="
    EXPLAIN ANALYSE SELECT tr.firstname, tr.lastname, cl.name
    FROM Trainers as tr
    JOIN Clubs as cl ON tr.clubId = cl.id
    ;
    "
psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet
