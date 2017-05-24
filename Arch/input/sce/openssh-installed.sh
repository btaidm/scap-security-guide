#!/usr/bin/env bash
# platform = archlinux




if (pacman -Qqi openssh > /dev/null 2>&1); then
	exit $XCCDF_RESULT_PASS
else
	echo openssh not installed
	exit $XCCDF_RESULT_FAIL
fi

