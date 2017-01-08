FROM quay.io/littlemanco/apache-php:7.0-rc2

# Add basic files
ADD app /var/www/html
WORKDIR /var/www/html

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    php composer-setup.php \
        --install-dir=/usr/local/bin \
        --filename=composer \
    php -r "unlink('composer-setup.php');" && \
    # Build & install application
    /usr/local/bin/composer install --no-dev  && \
    chown -R www-data:www-data /var/www/html && \
    # Remove composer
    rm /usr/local/bin/composer
