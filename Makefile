DOCKERCOMPOSE ?= $(shell which docker-compose)
DATABASE = $(shell which psql)

dev:
	$(DOCKERCOMPOSE) up --build database

embedding:
	$(DOCKERCOMPOSE) up --build database embedding

database:
	$(DOCKERCOMPOSE) exec database mysql -uroot -pdbreport dbreport_test
