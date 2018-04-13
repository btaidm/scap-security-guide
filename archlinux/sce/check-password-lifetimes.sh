#!/usr/bin/env bash
# platform = archlinux

if (
	while read username ; do
		echo "$username"
		
		mindays=`chage --list "$username" | grep '^Minimum number' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$mindays" -ge "1" ] || exit 1
		
		maxdays=`chage --list "$username" | grep '^Maximum number' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$maxdays" -le "60" ] || exit 1
		
		inactive=`chage --list "$username" | grep '^Password inactive' | awk -F':' '{print $2}' | tr -d '[[:space:]]'`
		[ "$inactive" -le "35" ] || exit 1
	done < <(grep --invert-match '/\(nologin\|false\|git-shell\)$' /etc/passwd | awk -F':' '{print $1}' | grep --invert-match '^root$')
) ; then
	exit $XCCDF_RESULT_PASS
else
	echo Problems with user password lifetime
	exit $XCCDF_RESULT_FAIL
fi

