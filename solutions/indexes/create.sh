#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
SQL="
    CREATE INDEX IF NOT EXISTS idx_homeclubid ON Games USING btree (homeClubId);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    CREATE INDEX IF NOT EXISTS idx_guestclubid ON Games USING btree (guestClubId);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
# SQL="
#     CREATE INDEX IF NOT EXISTS idx_playerpassport ON penalties USING btree (playerPassport);
#     "
# psql -h localhost -U postgres -d dbhw2 -p 5432 -v ON_ERROR_STOP=1 -c "$SQL"  --quiet
SQL="
    CREATE INDEX IF NOT EXISTS idx_trainerclubid ON trainers USING btree (clubId);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    CREATE INDEX IF NOT EXISTS idx_cityid ON Clubs USING btree (cityId);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    CREATE INDEX IF NOT EXISTS idx_scorerpassport ON goals USING btree (scorerPassport);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet
SQL="
    CREATE INDEX IF NOT EXISTS idx_playercountry ON players USING btree (countryId);
    "
PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet