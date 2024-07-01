#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

SQL="SELECT COUNT(*) FROM Goals;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

SQL="
    do \$\$
    DECLARE
    testCount integer := 3 * $6;
    DECLARE assistentPassport1 INT;
    DECLARE scorerPassport1 INT;
    DECLARE gameId1 INT;
    DECLARE time TIME;
    begin
        WHILE TestCount > 0 loop
            EXECUTE 'SELECT FLOOR(RANDOM() * ($6)) + 1' INTO scorerPassport1;
            EXECUTE 'SELECT FLOOR(RANDOM() * ($6)) + 1' INTO assistentPassport1;
            EXECUTE 'select time ''00:00:00'' + random() * (time ''10:00:00'' - time ''00:00:00'')' INTO time;
            
            INSERT INTO Goals (time, gameId, scorerPassport, assistentPassport)
            VALUES (time, TestCount % $6 + 1, scorerPassport1, assistentPassport1);
            TestCount := TestCount - 1; 
        end loop;
    end;
    \$\$;"

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
