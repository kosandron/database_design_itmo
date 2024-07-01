#!/bin/bash
SQL="
    CREATE TABLE IF NOT EXISTS penalties_new (
        gameTime time,
        gameId int,
        playerPassport bigint,
        penaltyTime time
    ) PARTITION BY RANGE (playerPassport);
    "
psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet
SQL="
    CREATE TABLE IF NOT EXISTS playerPassport_1 PARTITION OF penalties_new FOR VALUES BETWEEN 1 AND 100000;
    CREATE TABLE IF NOT EXISTS playerPassport_2 PARTITION OF penalties_new FOR VALUES BETWEEN 100001 AND 200000;
    CREATE TABLE IF NOT EXISTS playerPassport_3 PARTITION OF penalties_new FOR VALUES BETWEEN 200001 AND 300000;
    CREATE TABLE IF NOT EXISTS playerPassport_4 PARTITION OF penalties_new FOR VALUES BETWEEN 300001 AND 400000;
    CREATE TABLE IF NOT EXISTS playerPassport_5 PARTITION OF penalties_new FOR VALUES BETWEEN 400001 AND 500000;
    CREATE TABLE IF NOT EXISTS playerPassport_6 PARTITION OF penalties_new FOR VALUES BETWEEN 500001 AND 600000;
    CREATE TABLE IF NOT EXISTS playerPassport_7 PARTITION OF penalties_new FOR VALUES BETWEEN 600001 AND 700000;
    CREATE TABLE IF NOT EXISTS playerPassport_8 PARTITION OF penalties_new FOR VALUES BETWEEN 700001 AND 800000;
    CREATE TABLE IF NOT EXISTS playerPassport_9 PARTITION OF penalties_new FOR VALUES BETWEEN 800001 AND 900000;
    CREATE TABLE IF NOT EXISTS playerPassport_10 PARTITION OF penalties_new FOR VALUES BETWEEN 900001 AND 1000000;
    "
psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet
