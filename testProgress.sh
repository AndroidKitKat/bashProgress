function progress () {
    if (( $# == 1 )); then
        END=$(cat /dev/shm/progEnd)
        CURR="$1"
        out "$(./concat 'X' "$CURR")$(./concat '.' $((END - CURR)))"
    elif (( $# == 2 )); then
        if echo "$2" | grep -q -i "{.*}"; then
            START=$(echo "$2" | awk -F'[.][.]' '{print $1}' | tr -d '{')
            END=$(echo "$2" | awk -F'[.][.]' '{print $2}' | tr -d '}')
            echo "$END" > /dev/shm/progEnd
            for i in $(seq $END); do echo $i; done
        fi
    fi
}

function out () {
    echo "$1" 1>&2
}

i=0
for i in $(progress "$i" "{1..10}"); do
    echo "$i"
    sleep 1
    progress "$i"
done
