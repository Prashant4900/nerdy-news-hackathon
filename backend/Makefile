.PHONY: freeze
freeze:
	poetry export --without-hashes --format=requirements.txt > requirements.txt

.PHONY: static
static:
	python3 manage.py collectstatic --noinput

.PHONY: migrate
migrate:
	python3 manage.py migrate

.PHONY: makemigrations
makemigrations:
	python3 manage.py makemigrations

.PHONY: run
run:
	python3 manage.py runserver

.PHONY: superuser
superuser:
	python3 manage.py createsuperuser

.PHONY: test
test:
	python3 manage.py test

.PHONY: pip-update
pip-update:
	pip3 install --upgrade pip

.PHONY: readenv
readenv:
	export DJANGO_READ_DOT_ENV_FILE=True
