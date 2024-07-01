#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    CREATE ROLE writer LOGIN;
    GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO writer;
    "

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet