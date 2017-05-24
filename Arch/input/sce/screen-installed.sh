#!/usr/bin/env bash
# platform = archlinux




if (pacman -Qqi screen > /dev/null 2>&1); then
	exit $XCCDF_RESULT_PASS
else
	echo screen not installed
	exit $XCCDF_RESULT_FAIL
fi

