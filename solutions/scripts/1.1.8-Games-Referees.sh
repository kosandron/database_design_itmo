#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Games_Referees;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

SQL="
    do \$\$
    DECLARE
    testCount integer := 1000000;
    DECLARE referee1 INT;
    DECLARE referee2 INT;
    begin
        WHILE TestCount > 0 loop
            EXECUTE 'SELECT FLOOR(RANDOM() * (1000)) + 1' INTO referee1;
            EXECUTE 'SELECT FLOOR(RANDOM() * (1000)) + 1' INTO referee2;
            IF referee1 = referee2 THEN
                EXECUTE 'SELECT FLOOR(RANDOM() * (1000)) + 1' INTO referee2;
            END IF;
            IF referee1 = referee2 THEN
                EXECUTE 'SELECT FLOOR(RANDOM() * (1000)) + 1' INTO referee2;
            END IF;

            INSERT INTO Games_Referees (gameId, refereePassport)
            VALUES (TestCount, referee1);
            INSERT INTO Games_Referees (gameId, refereePassport)
            VALUES (TestCount, referee2);
            TestCount := TestCount - 1; 
        end loop;
    end;
    \$\$;"

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
