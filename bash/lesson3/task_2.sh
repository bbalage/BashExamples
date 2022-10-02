#!/bin/bash

echo "This script will generate the configuration file for you. Please, type the necessary information!"
read -p "Username: " username
read -p "Version: " version
read -p "Site: " site

printf "username: $username\nversion: $version\nsite: $site" > config.yml