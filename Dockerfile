FROM rockylinux:9

# Packages for project build
RUN dnf update -y && \
    dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y && \
    dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y && \
    dnf module reset php -y && \
    dnf module install php:remi-8.3 -y && \
    dnf install php83 -y && \
    dnf install php83-php-cli php83-php-common php83-php-json php83-php-mbstring php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-xml php83-php-pecl-zip php83-php-pecl-ssh2 -y && \
    dnf install -y wget git zip unzip curl npm python3 --allowerasing && \
    dnf module install nodejs:20 -y && \
    npm install -g npm@latest && \
    npm config delete python && \
    mkdir -p /tmp/.npm && chmod 777 /tmp/.npm
ENV NPM_CONFIG_CACHE=/tmp/.npm

# Composer (global) - official process
RUN cd /tmp && \
    php83 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php83 -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }" && \
    php83 composer-setup.php && \
    mv composer.phar /usr/local/bin/composer && \
    php83 -r "unlink('composer-setup.php');" && \
    chmod +x /usr/local/bin/composer && \
    mkdir -p /tmp/.composer && chmod 777 /tmp/.composer
ENV COMPOSER_HOME=/tmp/.composer

# Packages for RPM Build + encrypt (zip/unzip/curl)
RUN dnf install rpm-build tar gzip rsync zip unzip curl -y && \
    dnf clean all

# bolt-pkg
RUN curl -ks -o /tmp/bolt-pkg.rpm https://mirror.adminbolt.com/pulp/content/adminbolt/rhel/9/x86_64/Packages/b/bolt-pkg-1.0.2-14.el9.x86_64.rpm && \
    dnf install -y --nogpgcheck /tmp/bolt-pkg.rpm && rm -f /tmp/bolt-pkg.rpm && bolt-pkg install
