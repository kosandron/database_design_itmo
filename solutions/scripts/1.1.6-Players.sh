#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"

echo "$db"
echo "$user"
echo "$port"
echo "$password"
echo "$5"
echo "$6"

SQL="SELECT COUNT(*) FROM Players;"
count=$(PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet)
count=$(echo $count | awk '{print $4}')
if [[ "$count" -gt "1" ]]; then
    exit 1
fi

    SQL="
    do \$\$
    DECLARE
    testCount integer := $6;
    DECLARE PlayerPosit PlayerPosition;
    DECLARE Club INT;
    DECLARE Country INT;
    DECLARE Number INT;
    DECLARE Age INT;
    DECLARE name VARCHAR(255);
    DECLARE surname VARCHAR(255);
    begin
        WHILE TestCount > 0 loop
            EXECUTE 'SELECT FLOOR(RANDOM() * ($5)) + 1' INTO Club;
            EXECUTE 'SELECT FLOOR(RANDOM() * (100)) + 1' INTO Country;
            EXECUTE 'SELECT FLOOR(RANDOM() * (100)) + 1' INTO Number;
            EXECUTE 'SELECT FLOOR(RANDOM() * (60)) + 1' INTO Age;
            EXECUTE 'SELECT LEFT(MD5(RANDOM()::text), 8)' INTO name;
            EXECUTE 'SELECT LEFT(MD5(RANDOM()::text), 8)' INTO surname;
            IF TestCount < 5000 THEN
                PlayerPosit := 'Goalkeaper';
            ELSIF TestCount > 500000 THEN
                PlayerPosit := 'Attacker';
            ELSE
                PlayerPosit := 'Defender';
            END IF;

            INSERT INTO players (passport, firstname, lastname, clubId, number, countryId, age, playerposition)
            VALUES (TestCount, name, surname, Club, Number, Country, Age, PlayerPosit);
            TestCount := TestCount - 1; 
        end loop;
    end;
    \$\$;"
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
#done