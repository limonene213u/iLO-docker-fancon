FROM php:8.1-apache

# Install necessary packages
RUN apt-get update && \
    apt-get install -y libssh2-1-dev libcurl4-openssl-dev && \
    pecl install ssh2-1.3.1 && \
    docker-php-ext-enable ssh2 && \
    docker-php-ext-install curl

# Copy the source code into the container
COPY . /var/www/html/

# Use environment variables for configuration
RUN echo "<?php \
    \$ILO_HOST = getenv('ILO_HOST'); \
    \$ILO_USERNAME = getenv('ILO_USERNAME'); \
    \$ILO_PASSWORD = getenv('ILO_PASSWORD'); \
?>" > /var/www/html/config.inc.php

RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
