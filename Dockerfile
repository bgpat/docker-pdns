FROM alpine:3.23

RUN apk add --update --no-cache git g++ autoconf automake libtool boost-dev make bison flex file ragel mariadb-dev mariadb-client openssl && \
	wget https://github.com/PowerDNS/pdns/archive/auth-4.0.3.tar.gz && \
	tar xzvf auth-4.0.3.tar.gz && rm -rf auth-4.0.3.tar.gz && \
	cd pdns-auth-4.0.3 && ./bootstrap && ./configure --with-modules=gmysql --without-lua && \
	make && make install && \
	mkdir -p /usr/local/share/pdns && cp modules/gmysqlbackend/*.sql /usr/local/share/pdns/ && \
	cd / && rm -rf pdns-auth-4.0.3 /usr/include /usr/lib/gcc /usr/libexec/gcc /usr/libexec/git-core /usr/lib/*mysqld*
ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD config.py /config.py

ENV API_LOGFILE= DISABLE_SYSLOG=yes GUARDIAN=yes LAUNCH=gmysql WEBSERVER_ADDRESS=0.0.0.0

CMD ["/docker-entrypoint.sh"]
