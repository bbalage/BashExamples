#!/bin/bash

x=12
y=16
echo "$x : $y"
echo "$((x + y))"
expr $x - $y
z=$(echo "5.27 + 4.2" | bc)
echo "$z"
echo "$z + $x" | bc