#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Penalties (
    gameTime time,
    gameId int references Games(id),
    playerPassport bigint references Players(passport),
    penaltyTime time,
    PRIMARY KEY (gameTime, gameId, playerPassport)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
