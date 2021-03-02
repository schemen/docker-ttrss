FROM alpine:3.13

LABEL description="A complete, self-hosted Tiny Tiny RSS (TTRSS) environment." \
      maintainer="Schemen <me@schemen.me>"


RUN apk add --no-cache dcron php8 php8-fpm \
	php8-pdo php8-gd php8-pgsql php8-pdo_pgsql php8-mbstring \
	php8-intl php8-xml php8-curl php8-session \
	php8-dom php8-fileinfo php8-json php8-iconv \
	php8-pcntl php8-posix php8-zip php8-openssl \
	git postgresql-client sudo bash vim php8-pecl-xdebug dumb-init

EXPOSE 9000

# Clean up.
RUN set -xe && apk del --progress --purge && rm -rf /var/cache/apk/*

WORKDIR /data

COPY docker-entrypoint.sh /

RUN chown 1001:1001 -R /data && \
    chown 1001:1001 -R /docker-entrypoint.sh && \
    chown 1001:1001 -R /var/log/php8 && \
    ln -s /usr/bin/php8 /usr/bin/php 

RUN sed -i.bak 's/^listen = 127.0.0.1:9000/listen = 9000/' /etc/php8/php-fpm.d/www.conf
RUN sed -i.bak 's/\(memory_limit =\) 128M/\1 256M/' /etc/php8/php.ini
RUN sed -i.bak 's/;clear_env = .*/clear_env = no/i' /etc/php8/php-fpm.d/www.conf


USER 1001:1001

ENV TTRSS_MYSQL_CHARSET="UTF8"
ENV TTRSS_PHP_EXECUTABLE="/usr/bin/php8"
ENV TTRSS_PLUGINS="auth_internal, note, nginx_xaccel"

VOLUME /data

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["web"]
