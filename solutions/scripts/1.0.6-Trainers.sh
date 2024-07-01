#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Trainers (
    passport bigint UNIQUE PRIMARY KEY,
    firstname varchar(255),
    lastname varchar(255),
    clubId int references Clubs(id),
    countryId int references Countries(id),
    age int
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
