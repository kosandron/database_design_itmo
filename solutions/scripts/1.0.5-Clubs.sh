#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Clubs (
    id INT UNIQUE,
    name varchar(255),
    cityId int references Cities(id),
    stadiumId int references Stadiums(id),
    PRIMARY KEY (id, name)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet