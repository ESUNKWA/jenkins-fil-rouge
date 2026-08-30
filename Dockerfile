# --- Stage 1 : build ---
FROM php:8.4-cli AS build
WORKDIR /app
RUN apt-get update && apt-get install -y git unzip curl libsqlite3-dev libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo mbstring xml \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

COPY . .
RUN composer install --no-dev --optimize-autoloader --no-interaction \
    && npm ci && npm run build

# --- Stage 2 : image finale ---
FROM php:8.4-fpm AS runtime
WORKDIR /var/www/html
RUN docker-php-ext-install pdo pdo_mysql
COPY --from=build /app /var/www/html