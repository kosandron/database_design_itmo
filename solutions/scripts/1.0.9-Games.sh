#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="CREATE TABLE IF NOT EXISTS Games (
    id SERIAL unique,
    homeClubId int references Clubs(id),
    guestClubId int references Clubs(id),
    homeTeamScore int,
    guestTeamScore int,
    dataTime timestamp,
    stadiumId int references Stadiums(id),
    PRIMARY KEY (id, dataTime, stadiumId)
);"
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
