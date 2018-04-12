#!/usr/bin/env bash
# platform = archlinux


if ( yes n | pacman -Syu --needed ); then
	exit $XCCDF_RESULT_PASS
else
	echo Installed packages are not up to date
	exit $XCCDF_RESULT_FAIL
fi

