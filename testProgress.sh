function progress () {
    if [ "$1" == "-i" ]; then
        if echo "$2" | grep -q -i "{.*}"; then
            START=$(echo "$2" | awk -F'[.][.]' '{print $1}' | tr -d '{')
            END=$(echo "$2" | awk -F'[.][.]' '{print $2}' | tr -d '}')
            echo "$END" > /dev/shm/progEnd
            for i in $(seq $END); do echo $i; done
        fi
     elif [ "$1" == "-p" ]; then
        END=$(cat /dev/shm/progEnd)
        CURR="$2"
        out "$(./concat 'X' "$CURR")$(./concat '.' $((END - CURR)))"
     fi
}

function out () {
    echo "$1" 1>&2
}

for i in $(progress -i "{1..10}"); do
    echo "$i"
    sleep 1
    progress -p "$i"
done
