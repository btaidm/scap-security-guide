#!/usr/bin/env bash
# platform = archlinux

if (
	while read line ; do
		username=`echo "$line " | awk -F':' '{print $1}'`
		homedir=`echo "$line" | awk -F':' '{print $2}'`
		
		[ -z "$homedir" ] && exit 1  # each user has a homedir specified
		find "$homedir" -not -user "$username" || exit 1  # homedir is owned by user
		find "$homedir" -not -group "$username" || exit 1  # homedir is owned by user's primary group
		find "$homedir" \( -perm -0007 -o -perm -0020 \) || exit 1  # homedir is not writeable by group and not readable by others
		find "$homedir" -type f -name '.*' -maxdepth 1 \( -perm -0002 -o -perm -0020 \) || exit 1  # all .bashrc-like files are not writeable by others
		while read dotfile ; do
			! grep --with-filename '\(^\|\s+\)PATH.*\.' "$dotfile" || exit 1 # check that PATH doesnt get "current" directory added
			! grep --with-filename '\(^\|\s+\)UMASK=' "$dotfile" || exit 1 # check that UMASK is not modified in user files
		done < <(find "$homedir" -type f -name '.*' -maxdepth 1)
	done < <(grep --invert-match '/\(nologin\|false\|git-shell\)$' /etc/passwd | awk -F':' '{print $1 ":" $6}')
) ; then
	exit $XCCDF_RESULT_PASS
else
	echo Problems with user account session files
	exit $XCCDF_RESULT_FAIL
fi

