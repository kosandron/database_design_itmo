#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

# SQL="SELECT COUNT(*) FROM Penalties;"
# count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
# count=$(echo $count | awk '{print $4}')
# if [[ "$count" -gt "1" ]]; then
#     exit 1
# fi

SQL="
    do \$\$
    DECLARE
    testCount integer := 5 * $6;
    DECLARE playerPassport1 INT;
    DECLARE gameId1 INT;
    DECLARE gametime1 TIME;
    DECLARE penaltytime1 TIME;
    begin
        WHILE TestCount > 0 loop
            EXECUTE 'SELECT FLOOR(RANDOM() * ($6)) + 1' INTO playerPassport1;
            EXECUTE 'select time ''00:00:00'' + random() * (time ''10:00:00'' - time ''00:00:00'')' INTO gametime1;
            EXECUTE 'select time ''00:00:00'' + random() * (time ''00:20:00'' - time ''00:00:00'')' INTO penaltytime1;
            
            INSERT INTO Penalties (gameTime, penaltyTime, gameId, playerPassport)
            VALUES (gametime1, penaltytime1, TestCount % $6 + 1, playerPassport1);
            TestCount := TestCount - 1; 
        end loop;
    end;
    \$\$;"

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
