#!/bin/sh

git checkout -f develop && git clean -f -d && git pull origin develop
php8.1 /usr/local/bin/composer install --no-interaction
php8.1 artisan migrate --force --no-interaction
php8.1 artisan route:clear
php8.1 artisan view:clear
php8.1 artisan view:cache
