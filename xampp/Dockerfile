FROM php:8.2-apache

# Dependências
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    git \
    nano \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install \
        mysqli \
        pdo \
        pdo_mysql \
        gd \
        zip \
        intl \
        opcache \
        mbstring \
        exif \
        bcmath \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copia php.ini personalizado
COPY php.ini /usr/local/etc/php/php.ini