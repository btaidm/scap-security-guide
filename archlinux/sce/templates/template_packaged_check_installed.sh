#!/usr/bin/env bash


PACKAGE=$1

cat > $PACKAGE-installed.sh <<EOF
#!/usr/bin/env bash
# platform = archlinux

if (pacman -Qqi $PACKAGE > /dev/null 2>&1); then
	exit \$XCCDF_RESULT_PASS
else
	echo $PACKAGE not installed
	exit \$XCCDF_RESULT_FAIL
fi

EOF

chmod +x $PACKAGE-installed.sh