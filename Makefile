up:
	cd docker;docker-compose up -d
.PHONY: up

install:
	cd docker;docker-compose run edtool_web74 composer install
.PHONY: install

migrate:
	  cd doker;docker-compose run edtool_web74 bin/cake migrations migrate
.PHONY: migrate

test:
	  cd docker;docker-compose run edtool_web74 ./vendor/bin/phpunit
.PHONY: test

clean:
	  cd docker;docker-compose down
.PHONY: clean

web74:
	docker exec -it edtool_web74 sh
.PHONY: web74

nginx:
	docker exec -it edtool_nginx sh
.PHONY: nginx



# 表記自動修正
phpcbf:
	docker exec -it edtool_web74 ./vendor/bin/phpcbf -p --colors --standard=vendor/cakephp/cakephp-codesniffer/CakePHP ./src
.PHONY: phpcbf

# 表記チェック
phpcb:
	docker exec -it edtool_web74 ./vendor/bin/phpcs -p --colors --standard=./vendor/cakephp/cakephp-codesniffer/CakePHP ./src
.PHONY: phpcb

