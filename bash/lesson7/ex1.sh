#!/bin/bash

rnd=$RANDOM

echo "The number is: $rnd"
echo "Lesser square numbers are: "

for (( i=1; i*i < $rnd; i++ )); do
  echo -n "$((i*i)) "
done