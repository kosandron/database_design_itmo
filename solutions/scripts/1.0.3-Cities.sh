#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Cities (
    id INT UNIQUE,
    name varchar(255) UNIQUE,
    countryId int REFERENCES Countries(id),
    PRIMARY KEY (name, countryId)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet