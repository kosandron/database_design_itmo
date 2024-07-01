#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
     EXPLAIN ANALYSE SELECT cl.name as "ClubName", co.name as "Country", tr.firstname as "Trainer", hw.wh + gw.wg  as "wins", (hg.goc + gg.goc)* 1.0 / (hg.gac + gg.gac) as "AvgGoalPerGame" from clubs cl 
    JOIN cities ci on cl.cityId = ci.id 
    JOIN countries co ON ci.countryid = co.id
    JOIN trainers tr on cl.id = tr.clubId
    JOIN (SELECT homeClubId, COUNT(*) as "wh" FROM games WHERE homeTeamScore > guestTeamScore group by homeClubId) as hw ON hw.homeClubId = cl.id
    JOIN (SELECT guestClubId, COUNT(*) as "wg" FROM games WHERE homeTeamScore < guestTeamScore group by guestClubId) as gw ON gw.guestClubId = cl.id
    JOIN (SELECT homeClubId, SUM(homeTeamScore) as "goc", COUNT(*) as "gac" FROM games GROUP BY homeClubId) as hg on hg.homeClubId = cl.id
    JOIN (SELECT guestClubId, SUM(guestTeamScore) as "goc", COUNT(*) as "gac" FROM games GROUP BY guestClubId) as gg on gg.guestClubId = cl.id;
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet