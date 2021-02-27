FROM php:7.4-fpm-alpine

COPY php.ini /usr/local/etc/php/
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add \
    curl-dev \
    libmcrypt-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
#    zlib1g-dev \
    libxml2-dev \
    zlib-dev \
    libzip-dev \
    pcre-dev \
    oniguruma-dev \
    g++ \
    icu-dev \
    gcc \
    make \
#    libfreetype6-dev \
    imagemagick-dev \
    libssh2 \
    libssh2-dev \
    libxslt-dev \
    imap-dev \
    autoconf \
    openssl \
    nodejs-npm \
    bash \
    git \
    vim \
  && docker-php-ext-install \
    curl \
    dom \
    mbstring \
    pdo \
    pdo_mysql \
    simplexml \
    zip \
    opcache \
  && docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
  && docker-php-ext-configure zip \
  && docker-php-ext-configure imap \
     --with-imap --with-imap-ssl \
  && apk add ca-certificates wget \
  && update-ca-certificates \
  && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)\
  && docker-php-ext-install -j${NPROC} \
     mysqli \
     iconv \
     pdo \
     pdo_mysql \
     intl \ 
     curl \
     dom \
     mbstring \
     simplexml \
     zip \
     gd \
     imap \
    opcache \
#     /usr/src/php/ext/memcached \
   && pecl install xdebug-2.9.2 \
   && docker-php-ext-enable xdebug \
   && php -r "readfile('http://getcomposer.org/installer');" > composer-setup.php \
   && php composer-setup.php --filename=composer \
   && php -r "unlink('composer-setup.php');" \
   && mv composer /usr/local/bin/composer \
   && rm -rf /var/cache/apk/*


#     libintl \
#     unzip \

# COPY www.conf /usr/local/etc/php-fpm.d/zzz-www.conf


#  && apt-get install -y libmemcached-dev zlib1g-dev \
#  && pecl install memcached-3.0.3 \
#  && docker-php-ext-enable memcached opcache
