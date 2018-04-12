#!/usr/bin/env bash
# platform = archlinux

pacman -Q ./templates/packages > /dev/null

if [ 0 -eq 0 ]; then
	exit $XCCDF_RESULT_PASS
else
	echo ./templates/packages not installed
	exit $XCCDF_RESULT_FAIL
fi

