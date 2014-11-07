PHP?=$(shell which php)
ZCAT?=$(shell which zcat)
GZIP?=$(shell which gzip)
MYSQL?=$(shell which mysql)
MYSQLDUMP?=$(shell which mysqldump)
CP?=$(shell which cp)
DB_USER?=root
DB_PASS?=vagrant
DB_SCHEMA?=groupwork
HOST?=localhost
PORT?=8888

setup:
	$(PHP) -r "eval('?>'.file_get_contents('https://getcomposer.org/installer'));"

db-setup:
	$(ZCAT) ddl/user.dump.gz | $(MYSQL) -u$(DB_USER) -p$(DB_PASS) $(DB_SCHEMA)
	$(ZCAT) ddl/message.dump.gz | $(MYSQL) -u$(DB_USER) -p$(DB_PASS) $(DB_SCHEMA)

memcache-setup:
	$(PHP) app/setup_memcache.php

install: setup
	$(PHP) composer.phar install
	$(CP) app/config.php.template app/config.php
	$(ZCAT) ddl/user.dump.gz | $(MYSQL) -u$(DB_USER) -p$(DB_PASS) $(DB_SCHEMA)
	$(ZCAT) ddl/message.dump.gz | $(MYSQL) -u$(DB_USER) -p$(DB_PASS) $(DB_SCHEMA)
	$(PHP) app/setup_memcache.php

server:
	$(PHP) -S $(HOST):$(PORT) -t ./public_html

db-backup:
	$(MYSQLDUMP) -u$(DB_USER) $(DB_SCHEMA) user -p$(DB_PASS) | $(GZIP) > ddl/user.dump.gz
	$(MYSQLDUMP) -u$(DB_USER) $(DB_SCHEMA) message -p$(DB_PASS) | $(GZIP) > ddl/message.dump.gz

