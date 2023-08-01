function is_div {
    local reg="^[0-9]+$"
    if [[ $# -ne 2 ]] || [[ ! $1 =~ $reg ]] || [[ ! $2 =~ $reg ]]; then
        return 1
    fi
    if [ $(($1 % $2)) -eq 0 ]; then
        echo 1
    else
        echo 0
    fi
}
echo $(is_div 10 10 || echo "error")
echo $(is_div 10 100 || echo "error")
echo $(is_div eee 10 || echo "error")