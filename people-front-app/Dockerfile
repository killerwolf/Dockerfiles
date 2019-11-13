FROM php:7.2-cli

RUN apt-get -qqy update && \
    apt-get -qqy install \
    	zlib1g-dev \
    	libicu-dev \
    	curl \
    	apt-transport-https \
    	ca-certificates \
        unzip \
        gnupg2 \
    	git && \
    curl --fail -ssL -o setup-nodejs https://deb.nodesource.com/setup_10.x && \
    bash setup-nodejs && \
    apt-get install -qqy nodejs && \
    pecl install xdebug-2.6.1 && docker-php-ext-enable xdebug && \
    docker-php-ext-install intl && \
    docker-php-ext-configure intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    docker-php-ext-install calendar && \
    npm -g i elasticdump && \
    which ssh-agent || ( apt-get install openssh-client -y ) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["echo", "All good"]