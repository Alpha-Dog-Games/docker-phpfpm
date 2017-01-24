FROM ubuntu:xenial
MAINTAINER George Hornmoen <george@alphadoggames.com>

ENV OS_LOCALE="en_US.UTF-8"
RUN locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
	LANGUAGE=en_US:en \
	LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive

ENV PHP_RUN_DIR=/run/php \
	PHP_LOG_DIR=/var/log/php \
	PHP_CONF_DIR=/etc/php/5.6 \
	PHP_DATA_DIR=/var/lib/php \
	PHP_MOD_DIR=/etc/php/5.6/mods-available

RUN	\
	buildDeps='software-properties-common python-software-properties' \
	&& apt-get update \
	# Install common libraries
	&& apt-get install --no-install-recommends -y $buildDeps \
	&& add-apt-repository -y ppa:ondrej/php \
	&& apt-get update \
	# Install PHP libraries
	&& apt-get install -y curl memcached php-xdebug php5.6-fpm php5.6-cli php5.6-memcached php5.6-readline php5.6-mbstring php5.6-zip php5.6-intl php5.6-xml php5.6-json php5.6-curl php5.6-mcrypt php5.6-gd php5.6-pgsql php5.6-mysql php-pear \
	&& phpenmod mcrypt \
	# Install composer
	&& curl -sS https://getcomposer.org/installer | php -- --version=1.2.1 --install-dir=/usr/local/bin --filename=composer \
	&& mkdir -p ${PHP_LOG_DIR} ${PHP_RUN_DIR} \
	# Cleaning
	&& apt-get purge -y --auto-remove $buildDeps \
	&& apt-get autoremove -y && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./configs/php-fpm.conf ${PHP_CONF_DIR}/fpm/php-fpm.conf
COPY ./configs/www.conf ${PHP_CONF_DIR}/fpm/pool.d/www.conf
COPY ./configs/php.ini ${PHP_CONF_DIR}/fpm/conf.d/custom.ini

COPY ./configs/xdebug.ini ${PHP_MOD_DIR}/xdebug.ini

RUN sed -i "s~PHP_RUN_DIR~${PHP_RUN_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
	&& sed -i "s~PHP_LOG_DIR~${PHP_LOG_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
	&& chown www-data:www-data ${PHP_DATA_DIR} -Rf

RUN chown www-data:www-data ${PHP_CONF_DIR} -Rf
	
WORKDIR /var/www/monstrocity/

EXPOSE 9000

# PHP_DATA_DIR store sessions
VOLUME ["${PHP_RUN_DIR}", "${PHP_DATA_DIR}"]
CMD ["/usr/sbin/php-fpm5.6"]