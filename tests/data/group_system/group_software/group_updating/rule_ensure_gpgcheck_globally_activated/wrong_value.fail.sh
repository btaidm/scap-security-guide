#!/bin/bash
#
# profiles = xccdf_org.ssgproject.content_profile_ospp-rhel7

if grep -q "^gpgcheck" /etc/yum.conf; then
	sed -i "s/^gpgcheck.*/gpgcheck=0/" /etc/yum.conf
else
	echo "gpgcheck=0" >> /etc/yum.conf
fi
