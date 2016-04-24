FROM php:7.0.5-alpine

MAINTAINER Hamdi LAADHARI @killerwolf

ENV COMPOSER_VERSION 1.0.2
ENV PHING_VERSION 2.14.0
ENV PHPUNIT_VERSION 5.3.2

ENV PATH $PATH:/root/.composer/vendor/bin/

RUN mkdir /app
WORKDIR /app

# install composer (the recomended way)
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --version=${COMPOSER_VERSION} --filename=composer && \
	mv composer /usr/local/bin/composer && \
	chmod +x /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

# install phing/phing with pear
RUN pear channel-discover pear.phing.info && \
	pear install phing/phing-${PHING_VERSION}

# install phpunit with composer (only way to get the desired version)
RUN composer global require phpunit/phpunit