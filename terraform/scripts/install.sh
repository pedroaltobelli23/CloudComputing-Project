#!/bin/bash

echo "Installing things..."

sudo pip install djangorestframework

sudo pip install psycopg2-binary

git clone https://github.com/pedroaltobelli23/CloudComputing-Application

echo "Cloned repo"

# # Run MySQL command with provided parameters
sudo mysql -h "${var1}" -P "3306" -u "${var4}" --password="${var3}" -e "CREATE DATABASE ${var2};"

cd /CloudComputing-Application/app/app

python_file="settings.py"

sudo echo "ALLOWED_HOSTS = ['"${var5}"']" >> "$python_file"

sudo echo "DATABASES = {" >> "$python_file"
sudo echo "    'default': {" >> "$python_file"
sudo echo "        'ENGINE': 'django.db.backends.mysql'," >> "$python_file"
sudo echo "        'NAME': '"${var2}"'," >> "$python_file"
sudo echo "        'USER': '"${var4}"'," >> "$python_file"
sudo echo "        'PASSWORD': '"${var3}"'," >> "$python_file"
sudo echo "        'HOST': '"${var1}"'," >> "$python_file"
sudo echo "        'PORT': '3306'," >> "$python_file"
sudo echo "    }" >> "$python_file"
sudo echo "}" >> "$python_file"

cd ../

sudo python manage.py makemigrations

sudo python manage.py migrate

sudo python manage.py runserver 0.0.0.0:8000

