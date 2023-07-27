#!/bin/bash

read -p "Please, type your birthdate in yyyy.mm.dd format! " bdate

reg_ex='^[0-9]{4}\.[0-9]{2}\.[0-9]{2}$'
if [[ ! $bdate =~ $reg_ex ]]; then
  echo "Date is not in proper format!" 1>&2
  exit 1
fi

byear=$(echo $bdate | cut -f 1 -d '.')
bmonth=$(echo $bdate | cut -f 2 -d '.')
bday=$(echo $bdate | cut -f 3 -d '.')

# A date parancs le tudja ellenőrizni egy szintaktikailag helyes
# dátum validitását. Például a hónap nem-e nagyobb 12-nél, stb.
date -d "$byear-$bmonth-$bday" > /dev/null || exit 1

bseconds=$(date -d "$byear-$bmonth-$bday" +%s)
cseconds=$(date +%s)

age_in_seconds=$((cseconds - bseconds))

if [[ $age_in_seconds -lt 0 ]]; then
  echo "You haven't been born yet!" 1>&2
  exit 1
fi

echo $(( age_in_seconds / 60 / 60 / 24 / 365 ))