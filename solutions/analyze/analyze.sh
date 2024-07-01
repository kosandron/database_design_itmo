#!/bin/bash
declare -A arr
calls=$(cat old-docker-compose.yml | grep -i "EXPLAIN_CALLS" | tr "=" " " | awk '{print $NF}')
z=${calls//[ $'\r']}
file=""

print() {
    # echo "$file"
    echo -e "\tplan_time\texec_time" >> "$file"
    min="min"
    max="max"
    avg="avg"
    min="$min""|\t""$(echo "$2" | awk '{printf "%.2f", $1}')""|\t""$(echo "$5" | awk '{printf "%.2f", $1}')"
    max="$max""|\t""$(echo "$3" | awk '{printf "%.2f", $1}')""|\t""$(echo "$6" | awk '{printf "%.2f", $1}')"
    avg="$avg""|\t""$(echo "$1" | awk '{printf "%.2f", $1}')""|\t""$(echo "$4" | awk '{printf "%.2f", $1}')"
    echo -e $min >> "$file"
    echo -e $max >> "$file"
    echo -e $avg >> "$file"
    echo "___________________________________________" >> "$file"
}


i=1
while [[ $i -le 5 ]]; do
    max_plan=-1
    min_plan=10000000000000
    avg_plan=0
    max_exec=-1
    min_exec=10000000000000
    avg_exec=0
    j=1
    # echo "52"
    # echo "$z"
    # echo "$calls"
    while [[ $j -le "$z" ]]; do
        s=$(bash analyze/ex$i.sh postgres kosandron 5000 1234)
        #  echo "522"
        p=$(echo "$s" | grep -i "Planning")
        d=$(echo "$s" | grep -i "Execution")
        # echo "$p"
        # echo "$d"
        #newline=$(echo "$line" | tr "=" " ")
        read fw sw tw qw <<< $p
        # echo "$fw"
        # echo "$sw"
        #  echo "$tw"
        # echo "53"
        avg_plan=$(awk -v cur="$tw" -v avg="$avg_plan" 'BEGIN {print avg + cur; }')
        max_plan=$(awk -v cur="$tw" -v mx="$max_plan" 'BEGIN {if (cur > mx) print cur; else print mx; }')
        min_plan=$(awk -v cur="$tw" -v mx="$min_plan" 'BEGIN {if (cur < mx) print cur; else print mx; }')

        read fw sw tw qw <<< $d
        # echo "$fw"
        # echo "$sw"
        #  echo "$tw"
        
        avg_exec=$(awk -v cur="$tw" -v avg="$avg_exec" 'BEGIN {print avg + cur; }')
        max_exec=$(awk -v cur="$tw" -v mx="$max_exec" 'BEGIN {if (cur > mx) print cur; else print mx; }')
        min_exec=$(awk -v cur="$tw" -v mx="$min_exec" 'BEGIN {if (cur < mx) print cur; else print mx; }')

        ((j++))
    done
    # echo ""
    avg_exec=$(awk -v sum="$avg_exec" -v count="$z" 'BEGIN { print sum / count; }')
    avg_plan=$(awk -v sum="$avg_plan" -v count="$z" 'BEGIN { print sum / count; }')

    #  echo "$avg_plan"
    #  echo "$min_plan"
    #  echo "$max_plan"
    #  echo "$avg_exec"
    #  echo "$min_exec"
    #  echo "$max_exec"
    file="analyze/Result_""$i"".txt"
    print "$avg_plan" "$min_plan" "$max_plan" "$avg_exec" "$min_exec" "$max_exec"
    echo "Query "$i"/5"
    ((i++))
    
done

echo Done!