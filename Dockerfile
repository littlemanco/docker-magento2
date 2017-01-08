FROM quay.io/littlemanco/apache-php:7.0-rc2

# Add basic files
ADD app /var/www/html
WORKDIR /var/www/html

RUN export WORK_DIR=$(pwd) && \
    export SHA1_SUM_COMPOSER="14e4aa42727b621c86ae108bf46c7737a6527a18  composer.phar" && \
    # Install Composer
        ## Download composer
        cd /tmp/ && \
        curl -Os sha1sum composer.phar && \
        ## Check validity of composer
        echo "${SHA1_SUM_COMPOSER}" | sha1sum --check --quiet && \
        ## Make composer executable
        chmod +x composer.phar && \
        mv composer.phar /bin/composer && \
    # Build & install application
        /bin/composer install --no-dev  && \
        chown -R www-data:www-data /var/www/html && \
    # Remove composer
        rm /tmp/composer
