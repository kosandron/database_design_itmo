#!/bin/bash
db="$1"
user="postgres"
port="$3"
SQL="
    EXPLAIN ANALYSE SELECT pc.firstname as "FirstName", pg.goals as "Goals", (hw.wh + gw.wg) / (hg.games + gg.games) as "PercentOfWins"
    FROM (SELECT scorerPassport, COUNT(*) as "goals" FROM goals group by scorerPassport) as pg
    JOIN (SELECT firstname, passport, clubId FROM Players) as pc ON pg.scorerPassport = pc.passport
    JOIN (SELECT homeClubId, COUNT(*) as "wh" FROM games WHERE homeTeamScore > guestTeamScore group by homeClubId) as hw ON hw.homeClubId = pc.clubId
    JOIN (SELECT guestClubId, COUNT(*) as "wg" FROM games WHERE homeTeamScore < guestTeamScore group by guestClubId) as gw ON gw.guestClubId = pc.clubId
    JOIN (SELECT homeClubId, COUNT(*) as "games" FROM games GROUP BY homeClubId) as hg on hg.homeClubId = pc.clubId
    JOIN (SELECT guestClubId, COUNT(*) as "games" FROM games GROUP BY guestClubId) as gg on gg.guestClubId = pc.clubId
    ORDER BY pg.goals;
    "
psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet