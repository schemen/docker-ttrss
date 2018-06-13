FROM nginx:latest

LABEL description="A complete, self-hosted Tiny Tiny RSS (TTRSS) environment." \
      maintainer="Schemen <me@schemen.me>"

# Remove default configuration & COPY the ttrss config
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf