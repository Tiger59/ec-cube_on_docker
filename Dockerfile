FROM centos:7
RUN yum update -y
RUN yum install -y git zip unzip epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install -y -enablerepo=remi,remi-php72 php php-intl php-pdo php-xml php-mbstring php-zip
WORKDIR /var/www/html
RUN php -r "copy('https://getcomposer.org/installer','composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN composer create-project ec-cube/ec-cube ec-cube "4.0.x-dev" --keep-vcs
WORKDIR /var/www/html/ec-cube
EXPOSE 8080
ENTRYPOINT bin/console server:run 0.0.0.0:8080

