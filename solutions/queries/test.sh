#!/bin/bash
SQL="CREATE TABLE IF NOT EXISTS Referees (
    passport bigint PRIMARY KEY,
    firstname varchar(255),
    lastname varchar(255),
    number int,
    age int
);"
#PGPASSWORD="$POSTGRES_PASSWORD" psql -U "$user" -d "$db" -p "$port" -h "$host" -f "$sql_file"
PGPASSWORD="1234" psql -U "kosandron" -d "postgres" -p 5000 -v ON_ERROR_STOP=1 -c "$SQL" --quiet