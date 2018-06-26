FROM php:7-fpm-alpine3.7

LABEL description="A complete, self-hosted Tiny Tiny RSS (TTRSS) environment." \
      maintainer="Schemen <me@schemen.me>"

RUN set -xe && \
    apk update && apk upgrade && \
    apk add --no-cache --virtual=run-deps \
    git bash curl dumb-init \
    libxml2-dev libpng-dev postgresql-dev icu-dev

EXPOSE 9000

RUN docker-php-ext-install intl dom gd iconv pcntl fileinfo json pgsql pdo pdo_mysql pdo_pgsql mysqli mbstring posix session

# Clean up.
RUN set -xe && apk del --progress --purge && rm -rf /var/cache/apk/*

WORKDIR /data

COPY docker-entrypoint.sh /

RUN chown 1001:1001 -R /data && \
    chown 1001:1001 -R /docker-entrypoint.sh && \
    ln -s /usr/local/bin/php /usr/bin/php

USER 1001:1001

VOLUME /data

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["web"]
