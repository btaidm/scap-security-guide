#!/usr/bin/env bash
# platform = archlinux

function add_to_date()
{
    olddate=${1:?Need to supply date}
    days=${2:?Need to supply number of days}
    format=${3:-"+%s"}

    d1=$(date -d "$olddate" "+%s")
    d2=$(( d1 + (60*60*24) * days ))
    newdate=$(date -d "@$d2" "$format")
    echo "$newdate"
}

if (
	while read username ; do
		echo "$username"
		
		mindays=`chage --list "$username" | grep '^Minimum number' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$mindays" -ge "1" ] || exit 1
		
		maxdays=`chage --list "$username" | grep '^Maximum number' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$maxdays" -le "60" ] || exit 1
		
		inactive=`chage --list "$username" | grep '^Password inactive' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$inactive" == "never" ] && exit 1
		
		expiredate=$(date -d "$inactive" "+%s")
		laterdate=$(add_to_date `date` 90)
		[ "$expiredate" -ge "$laterdate" ] && exit 1
	done < <(grep --invert-match '/\(nologin\|false\|git-shell\)$' /etc/passwd | awk -F':' '{print $1}' | grep --invert-match '^root$')
) ; then
	exit $XCCDF_RESULT_PASS
else
	echo Problems with user password lifetime
	exit $XCCDF_RESULT_FAIL
fi

