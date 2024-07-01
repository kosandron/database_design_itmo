#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Games;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

SQL="
    do \$\$
    DECLARE
    testCount integer := $6;
    DECLARE homeTeamScore1 INT;
    DECLARE guestTeamScore1 INT;
    DECLARE homeClubId1 INT;
    DECLARE guestClubId1 INT;
    DECLARE stadiumId1 INT;
    DECLARE time TIMESTAMP;
    begin
        WHILE TestCount > 0 loop
            EXECUTE 'SELECT FLOOR(RANDOM() * (5)) + 1' INTO homeTeamScore1;
            EXECUTE 'SELECT FLOOR(RANDOM() * (5)) + 1' INTO guestTeamScore1;
            EXECUTE 'SELECT FLOOR(RANDOM() * ($5)) + 1' INTO homeClubId1;
            EXECUTE 'SELECT FLOOR(RANDOM() * ($5)) + 1' INTO guestClubId1;
            EXECUTE 'SELECT FLOOR(RANDOM() * ($5)) + 1' INTO stadiumId1;
            EXECUTE 'select timestamp ''1000-01-10 20:00:00'' + random() * (timestamp ''8014-01-20 20:00:00'' - timestamp ''1014-01-10 10:00:00'')' INTO time;
            
            INSERT INTO Games (homeTeamScore, guestTeamScore, homeClubId, guestClubId, stadiumId, dataTime)
            VALUES (homeTeamScore1, guestTeamScore1, homeClubId1, guestClubId1, stadiumId1, time);
            TestCount := TestCount - 1; 
        end loop;
    end;
    \$\$;"

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
