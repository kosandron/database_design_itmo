#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    CREATE TABLE IF NOT EXISTS penalties_new (
        gameTime time,
        gameId int,
        playerPassport bigint,
        penaltyTime time,
        PRIMARY KEY (gameTime, gameId, playerPassport)
    ) PARTITION BY RANGE (playerPassport);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    CREATE TABLE IF NOT EXISTS playerPassport_1 PARTITION OF penalties_new FOR VALUES FROM (1) TO (100001);
    CREATE TABLE IF NOT EXISTS playerPassport_2 PARTITION OF penalties_new FOR VALUES FROM (100001) TO (200001);
    CREATE TABLE IF NOT EXISTS playerPassport_3 PARTITION OF penalties_new FOR VALUES FROM (200001) TO (300001);
    CREATE TABLE IF NOT EXISTS playerPassport_4 PARTITION OF penalties_new FOR VALUES FROM (300001) TO (400001);
    CREATE TABLE IF NOT EXISTS playerPassport_5 PARTITION OF penalties_new FOR VALUES FROM (400001) TO (500001);
    CREATE TABLE IF NOT EXISTS playerPassport_6 PARTITION OF penalties_new FOR VALUES FROM (500001) TO (600001);
    CREATE TABLE IF NOT EXISTS playerPassport_7 PARTITION OF penalties_new FOR VALUES FROM (600001) TO (700001);
    CREATE TABLE IF NOT EXISTS playerPassport_8 PARTITION OF penalties_new FOR VALUES FROM (700001) TO (800001);
    CREATE TABLE IF NOT EXISTS playerPassport_9 PARTITION OF penalties_new FOR VALUES FROM (800001) TO (900001);
    CREATE TABLE IF NOT EXISTS playerPassport_10 PARTITION OF penalties_new FOR VALUES FROM (900001) TO (1000001);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
