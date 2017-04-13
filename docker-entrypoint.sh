#!/bin/sh

/config.py > /usr/local/etc/pdns.conf
pdns_server
