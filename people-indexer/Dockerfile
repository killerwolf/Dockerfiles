FROM php:7.0-cli

RUN apt-get -qqy update && \
    apt-get -qqy install zlib1g-dev && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install json && \
    docker-php-ext-install ctype && \
    docker-php-ext-install tokenizer && \
    docker-php-ext-install iconv && \
    docker-php-ext-install posix && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L https://phar.phpunit.de/phpunit-5.7.phar -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

RUN curl -L https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php && \
    rm composer-setup.php && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir -p /var/log/app && \
    touch /var/log/app/php.log

ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["echo", "All good"]
