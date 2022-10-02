#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Error: Wrong number of arguments provided: $#. Needed: 2." 1>&2
    exit 1
fi

if [ $2 -eq 0 ]; then
    echo "Error: division by zero." 1>&2
    exit 1
fi

echo "$(($1 + $2))"
echo "$(($1 - $2))"
echo "$(($1 * $2))"
echo "$(($1 / $2))"
echo "$(($1 % $2))"