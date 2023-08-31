#!/bin/bash

sum() {
    local x=0
    for i in $*; do
        x=$((x + i))
    done
    echo $((x))
}

sum 10 20 30
sum