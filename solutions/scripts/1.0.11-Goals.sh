#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Goals (
    time time,
    gameId int references Games(id),
    scorerPassport bigint references Players(passport),
    assistentPassport bigint references Players(passport),
    PRIMARY KEY (time, gameId)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
