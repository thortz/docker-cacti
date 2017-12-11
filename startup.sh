#!/bin/bash
#
set -e

if [ "$1" = 'startup' ]; then
	service apache2 restart
	tail -f /var/log/apache2/*
fi
