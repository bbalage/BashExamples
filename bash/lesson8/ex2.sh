#!/bin/bash

generate() {
    local N=${1:-5}
    local x=${2:-1}
    local y=${3:-90}
    range_size=$((y - x + 1))
    declare -a arr
    for ((i=0; i < N; ++i)); do
        rnd=$((RANDOM % range_size + x))
        arr[$i]=$rnd
    done
    echo ${arr[*]}
}

generate 10 800 900
generate 15 -10 10