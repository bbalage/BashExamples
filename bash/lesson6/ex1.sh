#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Two inputs are needed, $# is given." 1>&2
    exit 1
fi

reg_ex='^[0-9]+$'
if [[ ! $1 =~ $reg_ex || ! $2 =~ $reg_ex ]]; then
    echo "Both inputs must be positive integer numbers!" 1>&2
    exit 1
fi

echo "Area is: $(($1 * $2))"