FROM alpine:3.1

#Install php, imagick, nginx and supervisor
RUN apk --update add \
    libtool pcre-dev build-base imagemagick-dev autoconf php-dev php-pear \
	php-fpm php-curl php-json supervisor imagemagick py-pip \
	nginx && \
	sed -ie 's/-n//g' /usr/bin/pecl && \
    pecl install imagick  && \
	apk del --purge *-dev build-base autoconf libtool && \
	mkdir /tmp/nginx && \
	rm -rf /var/cache/apk/* && \
	pip install supervisor-stdout

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY supervisor.img.ini /etc/supervisor.d/
COPY phpfpm/img.ini /etc/php/conf.d/
COPY phpfpm/php-fpm.conf /etc/php/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 9000
EXPOSE 80

CMD ["/usr/bin/supervisord"]