#!/usr/bin/env bash

set -o errexit  # exit on error
# echo "Building Docker image..."
pip install --upgrade pip

pip3 install -r requirements.txt

python3 manage.py collectstatic --no-input
python3 manage.py migrate

python3 manage.py createsuperuser --noinput --username root --email root@gmail.com --password root