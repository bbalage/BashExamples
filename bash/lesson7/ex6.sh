#!/bin/bash

if [[ -z $1 ]]; then # Itt azt nézzük, hogy üres-e a változó
    echo "No input given." 1>&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo "Not an actual directory." 1>&2
    exit 1
fi

i=0
for name in $(ls $1); do
    echo "$i: $name"
    i=$((i+1))
done