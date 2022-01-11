# include .env
SHELL := /bin/bash

help: ## shows this helpfile
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## set credential secret
	@echo Password: && read -s password && echo 'NODE_RED_CREDENTIAL_SECRET='$$password > ./.env && \
		echo "TZ=$(timedatectl show | awk -F '=' '/^Timezone/ {print $2}')" >> .env

hash-pw: ## create a new password, which can be used in the settings file
	@docker-compose exec node-red node node_modules/node-red-admin/node-red-admin hash-pw

start: ## start docker-compose
	docker-compose up -d

stop: ## stop docker-compose
	docker-compose down

.PHONY: help setup start stop
.DEFAULT_GOAL := help