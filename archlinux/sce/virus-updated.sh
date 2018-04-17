#!/usr/bin/env bash

MAX_AGE=30

clamV=$(clamscan -V)
[ $? -eq 0 ] || exit $XCCDF_RESULT_FAIL

d2=$(date -d "${clamV##*/}" +%s)

d1=$(date +%s)

age=$(( (d1 - d2) / (60*60*24) ))

# echo $age

if [ $age -ge $MAX_AGE ]; then
	>&2 echo "Virus Defs out of date. Current Age: $age"
	exit $XCCDF_RESULT_FAIL
else
	exit $XCCDF_RESULT_PASS
fi
