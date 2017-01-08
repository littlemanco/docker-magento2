FROM quay.io/littlemanco/apache-php:7.0-rc2

# Add application
ADD app /var/www/html
WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    rm /var/www/html/index.html
