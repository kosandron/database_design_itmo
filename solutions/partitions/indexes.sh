db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    CREATE INDEX idx_gameTime_1 ON playerpassport_1 (gameTime);
    CREATE INDEX idx_gameTime_2 ON playerpassport_2 (gameTime);
    CREATE INDEX idx_gameTime_3 ON playerpassport_3 (gameTime);
    CREATE INDEX idx_gameTime_4 ON playerpassport_4 (gameTime);
    CREATE INDEX idx_gameTime_5 ON playerpassport_5 (gameTime);
    CREATE INDEX idx_gameTime_6 ON playerpassport_6 (gameTime);
    CREATE INDEX idx_gameTime_7 ON playerpassport_7 (gameTime);
    CREATE INDEX idx_gameTime_8 ON playerpassport_8 (gameTime);
    CREATE INDEX idx_gameTime_9 ON playerpassport_9 (gameTime);
    CREATE INDEX idx_gameTime_10 ON playerpassport_10 (gameTime);

    CREATE INDEX idx_gameId_1 ON playerpassport_1 (gameId);
    CREATE INDEX idx_gameId_2 ON playerpassport_2 (gameId);
    CREATE INDEX idx_gameId_3 ON playerpassport_3 (gameId);
    CREATE INDEX idx_gameId_4 ON playerpassport_4 (gameId);
    CREATE INDEX idx_gameId_5 ON playerpassport_5 (gameId);
    CREATE INDEX idx_gameId_6 ON playerpassport_6 (gameId);
    CREATE INDEX idx_gameId_7 ON playerpassport_7 (gameId);
    CREATE INDEX idx_gameId_8 ON playerpassport_8 (gameId);
    CREATE INDEX idx_gameId_9 ON playerpassport_9 (gameId);
    CREATE INDEX idx_gameId_10 ON playerpassport_10 (gameId);

    CREATE INDEX idx_playerPassport_1 ON playerpassport_1 (playerPassport);
    CREATE INDEX idx_playerPassport_2 ON playerpassport_2 (playerPassport);
    CREATE INDEX idx_playerPassport_3 ON playerpassport_3 (playerPassport);
    CREATE INDEX idx_playerPassport_4 ON playerpassport_4 (playerPassport);
    CREATE INDEX idx_playerPassport_5 ON playerpassport_5 (playerPassport);
    CREATE INDEX idx_playerPassport_6 ON playerpassport_6 (playerPassport);
    CREATE INDEX idx_playerPassport_7 ON playerpassport_7 (playerPassport);
    CREATE INDEX idx_playerPassport_8 ON playerpassport_8 (playerPassport);
    CREATE INDEX idx_playerPassport_9 ON playerpassport_9 (playerPassport);
    CREATE INDEX idx_playerPassport_10 ON playerpassport_10 (playerPassport);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet