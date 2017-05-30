#!/usr/bin/env bash
# platform = archlinux


if (paccheck --sha256sum --list-broken); then
	exit $XCCDF_RESULT_PASS
else
	echo Installed package files have been modified
	exit $XCCDF_RESULT_FAIL
fi

