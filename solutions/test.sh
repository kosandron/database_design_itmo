#!/bin/bash
start=$(date +%s)
smallsize=""
bigsize=""
port=""
users=""
db=""
pass=""
user=""
version="9999999"
files=()

FILE="old-docker-compose.yml"
while read line; do
	newline=$(echo "$line" | tr "=" " ")
	read fw sw tw <<< $newline
	tw=$(echo "$tw" | grep -o '[[:print:]]' | tr -d '\n')
	case $sw in
		"POSTGRES_DB")
			db="$tw"
			;;
		"POSTGRES_PORT")
			port="$tw"
			;;
		"POSTGRES_PASSWORD")
			pass="$tw"
			;;
		"POSTGRES_USER")
			user="$tw"
			;;
		"BIGTABLESIZE")
			bigsize="$tw"
			;;
		"SMALLTABLESIZE")
			smallsize="$tw"
			;;
		"POSTGRES_USERS")
			while read -r temp; do
				users="$users"' '"$temp"
			done <<< $(echo "$tw" | tr "," "\n")
			;;
		"VERSION")
			version="$tw"
			;;
	esac
done < $FILE
echo $port
echo $db
echo $pass
echo $user
echo $version
echo $smallsize
echo $bigsize
echo "###########"

path="scripts/"
temp=$(ls -1 scripts/)
#echo $temp
while read -r line; do
    #echo "$line"
    #a=$(echo "$line" | sed 's/\./''/' | sed 's/\./''/' | tr "-" " " | awk '{print $1}')
    #echo $a
	tline=$(echo "$line" | sed 's/\./''/' | sed 's/\./''/' | tr "-" " " | awk -v ver="$version" '{ if($1 <= ver) print $2}')
	if [ ! -z "$tline" ]; then
	    temp2=$(echo $line | grep -Eo '.*.bash')
		if [ ! -z "$temp2" ]; then
			files+=("$line"" 0")
            #echo "$line"
		fi
	fi
done <<< "$temp"

x=1
y=0
z=1
#echo "44444444444"
#echo $(ls -1 /docker-entrypoint-initdb.d/ | grep "$x.$y.$z-")

echo "!!!!!!!!!!!!"
while [[ "$x.$y.$z" != "$version" ]]; do
   a=$(ls -1 scripts/ | grep "$x.$y.$z-")
   #echo $a
   
  if [[ $a == "" ]]; then
        ((y++))
        z=0
       a=$(ls -1 scripts/ | grep "$x.$y.$z-")
    fi
    if [[ $a == "" ]]; then
        y=0
        z=0
        ((x++))
        a=$(ls -1 scripts/ | grep "$x.$y.$z-")
    fi
    if [[ $a != "" ]]; then
		#echo $a
        bash "scripts/$a" "$db" "$pass" "$port" "$user" "$smallsize" "$bigsize" "$users"
        echo ""
    fi
    echo $a
    ((z++))
done
 a=$(ls -1 scripts/ | grep "$x.$y.$z-")
 echo $a
 bash "scripts/$a" "$db" "$pass" "$port" "$user" "$smallsize" "$bigsize" "$users"

