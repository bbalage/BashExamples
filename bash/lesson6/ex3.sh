#!/bin/bash

if [ -e gtfs.zip ]; then
    rm gtfs.zip
fi

if [ -d gtfs ]; then
    rm -r gtfs
fi

wget "https://gtfsapi.mvkzrt.hu/gtfs/gtfs.zip"
# wget https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/gtfs.zip
unzip gtfs.zip -d gtfs # próbáljuk ki -d kapcsoló nélkül is...
cat gtfs/routes.txt | grep "Centrum"