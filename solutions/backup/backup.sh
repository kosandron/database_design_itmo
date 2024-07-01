mxcount=$(cat old-docker-compose.yml | grep BACKUPS_COPIES | tr "=" " " | awk '{print $NF}')
freq=$(cat old-docker-compose.yml | grep BACKUPS_FREQUENCY | tr "=" " " | awk '{print $NF}')
pass=$(cat old-docker-compose.yml | grep POSTGRES_PASSWORD | tr "=" " " | awk '{print $NF}')
user=$(cat old-docker-compose.yml | grep POSTGRES_USER= | tr "=" " " | awk '{print $NF}')
db=$(cat old-docker-compose.yml | grep POSTGRES_DB | tr "=" " " | awk '{print $NF}')
port=$(cat old-docker-compose.yml | grep POSTGRES_PORT | tr "=" " " | awk '{print $NF}')
lasttime=$(date +%H)

echo $pass
echo $user
echo $db
echo $port
exit 0

curr=$(cat backup/curr.txt)
count=$current_file
deletenum=0
#PGPASSWORD="1234" pg_dump -U kosandron -d postgres -p 5000 -f backup/backup"$curr".sql

PGPASSWORD="$user" pg_dump -U $pass -d $db -p $port -f backup/backup"$curr".sql
deletenum=$(awk -v now="$curr" -v mx="$mxcount" 'BEGIN {print now - mx }')
if [ -f backup$deletenum.sql ]; then
    rm backup$deletenum.sql
fi
((curr++))
echo "$curr" > backup/curr.txt
exit 0
while true; do
    curtime=$(date +%H)
    dif=$(awk -v last="$lasttime" -v now="$curtime" 'BEGIN {print now - last}')
    if [[ "$dif" -ge "0" ]]; then
        if [[ "$dif" -ge "$freq" ]]; then
            PGPASSWORD="$user" pg_dump -U $pass -d $db -p $port -f backup/backup"$curr".sql
            deletenum=$(awk -v now="$curr" -v mx="$mxcount" 'BEGIN {print now - mx }')
            if [ -f backup$deletenum.sql ]; then
                rm backup$deletenum.sql
            fi
            ((curr++))
            echo "$curr" > backup/curr.txt
            lasttime=$curtime
        fi
    else
        let temp=$curtime+24
        dif=$(awk -v last="$lasttime" -v now="$temp" 'BEGIN {print now - last}')
        if [[ "$dif" -ge "-$freq" ]]; then
            PGPASSWORD="$user" pg_dump -U $pass -d $db -p $port -f backup/backup"$curr".sql
            deletenum=$(awk -v now="$curr" -v mx="$mxcount" 'BEGIN {print now - mx }')
            if [ -f backup$deletenum.sql ]; then
                rm backup$deletenum.sql
            fi
            ((curr++))
            echo "$curr" > backup/curr.txt
            lasttime=$curtime
        fi
    fi
    sleep 1
done