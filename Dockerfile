FROM quay.io/littlemanco/apache-php:7.0-rc2

# Add basic files
ADD app /var/www/html
WORKDIR /var/www/html

RUN export WORK_DIR=$(pwd) && \
    export BIN_PATH_COMPOSER="/bin/composer" && \
    export SHA1_SUM_COMPOSER="14e4aa42727b621c86ae108bf46c7737a6527a18  composer.phar" && \
    export VERSION_COMPOSER="1.3.1" && \
    # Install Composer
        ## Download composer
        cd /tmp/ && \
        curl -Os "https://getcomposer.org/download/${VERSION_COMPOSER}/composer.phar" && \
        ## Check validity of composer
        echo "${SHA1_SUM_COMPOSER}" | sha1sum --check --quiet && \
        ## Make composer executable
        chmod +x composer.phar && \
        mv composer.phar "${BIN_PATH_COMPOSER}" && \
        cd "${WORK_DIR}" \
    # Build & install application
        "${BIN_PATH_COMPOSER}" install --no-dev  && \
        chown -R www-data:www-data /var/www/html && \
    # Remove composer
        rm "${BIN_PATH_COMPOSER}"
