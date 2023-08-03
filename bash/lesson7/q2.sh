#!/bin/bash

i=0
until [ $i -lt 10 ]; do
    i=$((i + 2))
    echo $i
done