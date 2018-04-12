#!/bin/bash

# line='./shared/checks/oval/accounts_passwords_pam_faillock_interval.xml: <external_variable comment="number of failed login attempts allowed" datatype="int" id="var_accounts_passwords_pam_faillock_fail_interval" version="2" />'
grep -r external_variable ./shared/checks/oval | while read line; do
	OIFS=$IFS
	IFS=':'
	fileline=(${line})
	IFS=$OIFS
	file=`basename ${fileline[0]}`

	varxml=$(grep -A1 -h "external_variable" "${fileline[0]}" | tr '\n' ' ')

	# echo $varxml
	# varxml=${fileline[1]}

	[[ "$varxml" =~ id=\"([^\"]+?) ]] && var=${BASH_REMATCH[1]}

	# echo ${file%.*}
	# echo $var

	rulefile=`find ./archlinux -name '*'"${file%.*}"'.rule'`


	if ! [ -z "$rulefile" ]; then

	if ! grep -Fxq "values:" "$rulefile"
	then
		cat >> $rulefile <<-DOC


	values:
DOC
	fi

	if ! grep -q "\- $var" "$rulefile"
	then
		echo $rulefile
		cat >> $rulefile <<-DOC
	    - $var
DOC
	fi

	fi
done
