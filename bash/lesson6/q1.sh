#!/bin/bash

reg_ex='^-?[0-9]+\.?[0-9]*$'
if [[ $1 =~ $reg_ex ]]; then
  echo "OK"
else
  echo "Not OK"
  exit 1
fi