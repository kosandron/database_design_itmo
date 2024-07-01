#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Games_Referees (
    gameId int references Games(id),
    refereePassport bigint references Referees(passport),
    PRIMARY KEY (gameId, refereePassport)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
