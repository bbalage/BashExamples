#!/bin/bash

i=0
j=20
while [ $i -lt $j ]; do
  echo $((i + j))
  i=$((i + 1))
  j=$((j - 2))
done