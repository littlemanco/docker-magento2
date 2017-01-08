FROM quay.io/littlemanco/apache-php:7.0-rc2

# Add basic files
ADD app /var/www/html
WORKDIR /var/www/html

