#!/usr/bin/env bash
# platform = archlinux

# ignore grub package since changes to its configuration files are required but cause the check to fail
if ! ( paccheck --sha256sum --list-broken | grep --invert '\(grub\|linux\)' ); then
	exit $XCCDF_RESULT_PASS
else
	echo Installed package files have been modified
	exit $XCCDF_RESULT_FAIL
fi

