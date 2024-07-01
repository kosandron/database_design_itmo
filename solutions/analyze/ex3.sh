#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    EXPLAIN ANALYSE SELECT pg.playerPassport, pc.firstname, pg.time / (hg.games + gg.games) as "Time"
    FROM (SELECT playerPassport, SUM(penaltyTime) as "time" FROM penalties group by playerPassport) as pg
    JOIN (SELECT firstname, passport, clubId FROM Players) as pc ON pg.playerPassport = pc.passport
    JOIN (SELECT homeClubId, COUNT(*) as "games" FROM games GROUP BY homeClubId) as hg on hg.homeClubId = pc.clubId
    JOIN (SELECT guestClubId, COUNT(*) as "games" FROM games GROUP BY guestClubId) as gg on gg.guestClubId = pc.clubId;
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet