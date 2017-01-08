# Task runner

.PHONY: clean help build application image

.DEFAULT_GOAL := help

SHELL := /bin/bash

# http://stackoverflow.com/questions/1404796/how-to-get-the-latest-tag-name-in-current-branch-in-git
APP_VERSION := $(shell git describe --abbrev=0)

GIT_HASH     := $(shell git rev-parse --short HEAD)

ANSI_TITLE        := '\e[1;32m'
ANSI_CMD          := '\e[0;32m'
ANSI_TITLE        := '\e[0;33m'
ANSI_SUBTITLE     := '\e[0;37m'
ANSI_WARNING      := '\e[1;31m'
ANSI_OFF          := '\e[0m'

TIMESTAMP := $(shell date "+%s")

help: ## Show this menu
	@echo -e $(ANSI_TITLE)Magento2$(ANSI_OFF)$(ANSI_SUBTITLE)" - Magento2 dockerfile"$(ANSI_OFF)
	@echo -e $(ANSI_TITLE)Commands:$(ANSI_OFF)
	@grep -E '^[a-zA-Z_-%]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[32m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Build the application
	mv app/composer.json . && \
	mv app/composer.lock . && \
	rm -rf app/* && \
	mv composer.json app/ && \
	mv composer.lock app/

application: ## Build the application
	cd app && composer install \
	    --no-dev \
	    --ignore-platform-reqs

image: clean application ## Build the image
	docker build .
