#!/bin/bash
db="$1"
user="$2"
port="$3"
password="$4"
users="$7"
IFS=' ' read -ra ADDR <<< "${users[@]}"

SQL="
    CREATE ROLE group_role NOLOGIN;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO group_role;
    "

PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet


for i in "${ADDR[@]}"; do
 if [[ "$i" != "" ]]; then

    SQL="
    CREATE USER $i with password '1234';
    grant group_role to $i;
    "
    PGPASSWORD="$password" psql -U "$user" -d "$db" -p "$port" -v ON_ERROR_STOP=1 -c "$SQL" --quiet

 fi
done