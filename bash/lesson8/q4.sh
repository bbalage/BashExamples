x=10
function f {
    local x=1
    x=$((x + 1))
    if [ $# -lt 2 ]; then
        return 1
    fi
    echo $((x + $1 + $2))
}
result1=$(f 12 10 || echo 0)
result2=$(f 10 || echo 0)
echo "$result1 : $result2 : $x"