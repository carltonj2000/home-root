build:
	docker-compose -f docker-compose-home.yml build

up:
	docker-compose -f docker-compose-home.yml up

bup: build up
