#!/bin/bash
db="$1"
user="$2"
port="$3"
SQL="
    CREATE ROLE analtytic LOGIN;
    GRANT SELECT ON Games TO analytic;
    "

psql -h localhost -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL"  --quiet