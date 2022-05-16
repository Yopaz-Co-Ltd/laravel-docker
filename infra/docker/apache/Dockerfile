FROM php:8.0.2-apache

ENV C=JP \
    ST=TOKYO \
    L=KITA-KU \
    O=TEST \
    OU=TEST \
    CN=127.0.0.1

RUN apt-get update && apt-get install -y npm

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - | true
#RUN apt-get install -y nodejs --no-install-recommends && rm -r /var/lib/apt/lists/*

WORKDIR /etc/ssl/
RUN openssl genrsa 2048 > server.key;openssl req -new -key server.key -out server.csr -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}";openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt



WORKDIR /tmp

#install composer
RUN curl -sSk https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY ./infra/docker/apache/etc_apache2_sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite
RUN a2enmod ssl

RUN docker-php-ext-install pdo_mysql

WORKDIR /var/www


# #install php extension
# RUN echo "extension=zip.so" >> /etc/php/7.4/fpm/php.ini
# RUN chmod 666 /etc/php/7.4/fpm/php.ini

# # setting jp locals
# RUN echo "ja_JP UTF-8" > /etc/locale.gen
# RUN locale-gen

# #setting nginx
# COPY etc_nginx_conf.d_default.conf /etc/nginx/sites-enabled/default
# COPY etc_nginx_nginx.conf /etc/nginx/nginx.conf
# RUN mkdir -p /run/nginx

# #setting php-fpm
# COPY etc_php_7.4_fpm_php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY etc_php_7.4_fpm_pool.d_www.conf /etc/php/7.4/fpm/pool.d/www.conf
# RUN sed -i -e "s/^;curl.cainfo =$/curl.cainfo=\/etc\/ssl\/certs\/ca-certificates.crt/" /etc/php/7.4/fpm/php.ini
# RUN sed -i -e "s/\memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/fpm/php.ini
# RUN sed -i -e "s/\post_max_size = .*/post_max_size = 200M/" /etc/php/7.4/fpm/php.ini
# RUN sed -i -e "s/\upload_max_filesize = .*/upload_max_filesize = 200M/" /etc/php/7.4/fpm/php.ini

# #RUN echo "[XDebug]" >> /etc/php/7.4/fpm/php.ini
# #RUN echo "xdebug.remote_enable = 1" >> /etc/php/7.4/fpm/php.ini
# #RUN echo "xdebug.remote_autostart = 1" >> /etc/php/7.4/fpm/php.ini
# #RUN echo "xdebug.remote_host = host.docker.internal" >> /etc/php/7.4/fpm/php.ini

# RUN sed -i -e "s/\memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/cli/php.ini
# RUN sed -i -e "s/\post_max_size = .*/post_max_size = 200M/" /etc/php/7.4/cli/php.ini
# RUN sed -i -e "s/\upload_max_filesize = .*/upload_max_filesize = 200M/" /etc/php/7.4/cli/php.ini
# #RUN echo "[XDebug]" >> /etc/php/7.4/cli/php.ini
# #RUN echo "xdebug.remote_enable = 1" >> /etc/php/7.4/cli/php.ini
# #RUN echo "xdebug.remote_autostart = 1" >> /etc/php/7.4/cli/php.ini
# #RUN echo "xdebug.remote_host = host.docker.internal" >> /etc/php/7.4/cli/php.ini
# RUN mkdir -p /run/php

# #setting supervisor
# RUN mkdir -p /var/log/supervisor
# ADD etc_supervisor.d_supervisor.conf /etc/supervisor/conf.d/supervisor.conf


# ## setting init script
# COPY init.sh /usr/bin/init.sh
# RUN chmod 755 /usr/bin/init.sh

# ADD .env /tmp/.env

# #setting artisan/unittest facade
# COPY artisan /usr/bin/artisan
# COPY unittest /usr/bin/unittest
# COPY watch_build_css /usr/bin/watch_build_css
# RUN chmod 755 /usr/bin/artisan /usr/bin/unittest /usr/bin/watch_build_css

# #setting cron
# #RUN echo "* * * * * root /usr/bin/sudo -u www-data php /var/www/artisan schedule:run >> /var/www/storage/logs/batch_upload.log" > /etc/cron.d/ocr_batch
# WORKDIR /var/www

# CMD ["/usr/bin/init.sh"]
