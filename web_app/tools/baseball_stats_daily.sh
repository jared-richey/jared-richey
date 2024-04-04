#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(readlink -f "$0")

my_dir=$(dirname "$SCRIPT_PATH")

url="https://www.espn.com/mlb/lines"
input_file="$my_dir/baseball_stats.html"

echo "Checking status code" 
response_code=$(curl -s -o /dev/null -w "%{http_code}" -H "Content-type: text/html" $url)

if [[ "$response_code" == 200 ]]; then
    echo "Running curl command to retrieve soccer stats" 
    curl -s -H "Content-type: text/html" $url > $input_file
    if [[ -s "$input_file" ]]; then
        echo "Parsing soccer stats"
        python3 $my_dir/baseball_parser.py > $my_dir/baseball_stats.txt
    else
        echo "Input file doesn't exist"
    fi
else
   echo "Request failed with non-200"
fi