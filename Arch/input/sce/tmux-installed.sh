#!/usr/bin/env bash
# platform = archlinux




if (pacman -Qqi tmux > /dev/null 2>&1); then
	exit $XCCDF_RESULT_PASS
else
	echo tmux not installed
	exit $XCCDF_RESULT_FAIL
fi

