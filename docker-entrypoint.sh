#!/bin/sh

mysql -h$GMYSQL_HOST -u$GMYSQL_USER -p$GMYSQL_PASSWORD $GMYSQL_DBNAME < /usr/local/share/pdns/schema.mysql.sql
mysql -h$GMYSQL_HOST -u$GMYSQL_USER -p$GMYSQL_PASSWORD $GMYSQL_DBNAME < /usr/local/share/pdns/enable-foreign-keys.mysql.sql
echo 'init sql query'
/config.py > /usr/local/etc/pdns.conf
pdns_server
