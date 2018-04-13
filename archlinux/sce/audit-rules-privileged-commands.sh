#!/usr/bin/env bash
# platform = archlinux

if (
	while read binfile ; do
		echo "$binfile"
		grep --with-filename "path=$binfile " /etc/audit/rules.d/*.rules /etc/audit/*.rules || exit 1
	done < <(sudo find / -xdev -type f -perm -4000 -o -type f -perm -2000)
) ; then
	exit $XCCDF_RESULT_PASS
else
	echo Problems with user account session files
	exit $XCCDF_RESULT_FAIL
fi

