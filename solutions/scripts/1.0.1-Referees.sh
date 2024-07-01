#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
echo "$db"
echo "$user"
echo "$port"
echo "$password"
SQL="CREATE TABLE IF NOT EXISTS Referees (
    passport bigint PRIMARY KEY,
    firstname varchar(255),
    lastname varchar(255),
    number int,
    age int
);"
#psql -h localhost -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
