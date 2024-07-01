#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    ALTER TABLE penalties RENAME TO old_penalties;
    ALTER TABLE penalties_new RENAME TO penalties;
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    ALTER TABLE playerpassport_1 ADD CONSTRAINT fk_playerPassport1 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_2 ADD CONSTRAINT fk_playerPassport2 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_3 ADD CONSTRAINT fk_playerPassport3 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_4 ADD CONSTRAINT fk_playerPassport4 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_5 ADD CONSTRAINT fk_playerPassport5 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_6 ADD CONSTRAINT fk_playerPassport6 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_7 ADD CONSTRAINT fk_playerPassport7 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_8 ADD CONSTRAINT fk_playerPassport8 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_9 ADD CONSTRAINT fk_playerPassport9 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    ALTER TABLE playerpassport_10 ADD CONSTRAINT fk_playerPassport10 FOREIGN KEY (playerpassport) REFERENCES Players (passport);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    ALTER TABLE playerpassport_1 ADD CONSTRAINT fk_gameId1 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_2 ADD CONSTRAINT fk_gameId2 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_3 ADD CONSTRAINT fk_gameId3 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_4 ADD CONSTRAINT fk_gameId4 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_5 ADD CONSTRAINT fk_gameId5 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_6 ADD CONSTRAINT fk_gameId6 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_7 ADD CONSTRAINT fk_gameId7 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_8 ADD CONSTRAINT fk_gameId8 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_9 ADD CONSTRAINT fk_gameId9 FOREIGN KEY (gameId) REFERENCES Games (id);
    ALTER TABLE playerpassport_10 ADD CONSTRAINT fk_gameId10 FOREIGN KEY (gameId) REFERENCES Games (id);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet

# SQL="
#     ALTER TABLE playerpassport_1 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_2 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_3 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_4 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_5 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_6 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_7 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_8 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_9 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     ALTER TABLE playerpassport_10 ADD PRIMARY KEY (gameTime, gameId, playerPassport);
#     "
# PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet

