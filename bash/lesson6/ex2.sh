#!/bin/bash

read -p "Please, type the name you are searching for! " name

row=$(cat name_id_pairs.txt | grep $name)

if [[ -z $row ]]; then
  echo "No name like that." 1>&2
  exit 1
fi

id=$(echo $row | cut -d ':' -f 2)
echo $id