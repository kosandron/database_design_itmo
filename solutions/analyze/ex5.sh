#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    EXPLAIN ANALYSE SELECT tr.firstname, tr.lastname, cl.name
    FROM Trainers as tr
    JOIN Clubs as cl ON tr.clubId = cl.id
    ;
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
