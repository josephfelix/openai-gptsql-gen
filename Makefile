DOCKERCOMPOSE ?= $(shell which docker-compose)
DATABASE = $(shell which psql)

run:
	$(DOCKERCOMPOSE) up

database:
	$(DOCKERCOMPOSE) exec database mysql -uroot -pdbreport dbreport_test
