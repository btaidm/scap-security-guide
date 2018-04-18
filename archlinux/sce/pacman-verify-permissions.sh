#!/usr/bin/env bash
# platform = archlinux


if ! ( pacman -Qkk 2>&1 | grep --invert '^[^/]\+/\(etc\|boot\|var/log/audit\|usr/lib/modules\)/' | grep '(\(Permissions mismatch\)\|\(UID mismatch\)\|\(GID mismatch\))$' ); then
	exit $XCCDF_RESULT_PASS
else
	echo Installed package files have had permissions, owner, or group modified
	exit $XCCDF_RESULT_FAIL
fi

