FROM rockylinux:9

# Packages for project build
RUN dnf update -y && \
    dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y && \
    dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y && \
    dnf module reset php -y && \
    dnf module install php:remi-8.3 -y && \
    dnf install php83 -y && \
    dnf install php83-php-cli php83-php-common php83-php-json php83-php-mbstring php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-xml php83-php-pecl-zip php83-php-pecl-ssh2 -y && \
    dnf install -y wget git zip unzip curl npm --allowerasing && \
    dnf module install nodejs:20 -y && \
    npm install -g npm@latest

# Packages for RPM Build + encrypt (zip/unzip/curl)
RUN dnf install rpm-build tar gzip rsync zip unzip curl -y && \
    dnf clean all
