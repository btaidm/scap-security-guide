#!/usr/bin/env bash

CSV_FILE=$1
TEMPLATE_FILE=$2

packages=( $(cut -d ',' -f1 ${CSV_FILE}.csv ) )

for i in "${packages[@]}"
do
	$TEMPLATE_FILE $i
done