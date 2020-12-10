From ubuntu:18.04
Run apt update && apt upgrade -y
Run apt -y install software-properties-common && add-apt-repository ppa:ondrej/php && apt update
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata

Run apt install sudo nginx lsb-release apt-transport-https ca-certificates wget git bash-completion curl -y


Run apt install php-pgsql php-fpm php-common php-mysql php-xml php-xmlrpc php-curl php-gd php-imagick php-cli php-dev php-imap php-mbstring php7.4-opcache php-soap php-zip php-intl -y
Run curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
Run curl -sL https://deb.nodesource.com/setup_10.x | bash -
Run apt install nodejs -y
Run curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
Run echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
Run apt-get update
Run apt-get install yarn

#Run cd /var/www/ && git clone https://clinichrcrm:30186b617444c6f31b5dc759b88ecc7dc9b96991@github.com/clinichrcrm/aksiscrm.git && cd aksiscrm/ && composer update -n && composer install -n
#Run chmod -R 777 /var/www/aksiscrm/
#Copy ./aksis.conf /etc/nginx/sites-enabled/aksis.conf
#Run ln -s /etc/nginx/sites-enabled/aksis.conf /etc/nginx/sites-available/aksis.conf
#Copy ./.env /var/www/aksiscrm/
#Run cd /var/www/aksiscrm/ && php artisan route:cache && php artisan key:generate
#Run cd /var/www/aksiscrm/ && yarn install
#php artisan key:generate

#Run rm -rf /etc/nginx/sites-enabled/default 
#Run rm -rf /etc/nginx/sites-available/default 
Run /etc/init.d/nginx restart
Run /etc/init.d/php7.4-fpm start
Copy ./server_startup.sh /root/
Run chmod +x /root/server_startup.sh
Volume /etc/nginx/sites-enabled/
Volume /var/www/aksiscrm/

Expose 443
Expose 80
Entrypoint ["bash", "/root/server_startup.sh"]
