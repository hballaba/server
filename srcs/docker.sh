# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    docker.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hballaba <hballaba@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/02 13:15:15 by hballaba          #+#    #+#              #
#    Updated: 2020/08/02 13:16:02 by hballaba         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Wordpress
wget https://ru.wordpress.org/latest-ru_RU.zip
unzip latest-ru_RU.zip
 
cp -a wordpress/. /var/www/ft_server/
cp wordpress/wp-config-sample.php wordpress/wp-config.php
rm -rf latest-ru_RU.zips



# SSL
mkdir /etc/nginx/ssl

openssl req -newkey rsa:2048 -x509 -days 365 -nodes \
-out /etc/nginx/ssl/mycert.pem -keyout /etc/nginx/ssl/mykey.key \
-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School21/OU=hballaba/CN=localhost"

#phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-english.zip
unzip phpMyAdmin-4.9.5-english.zip
mv phpMyAdmin-4.9.5-english/ /usr/share/phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/ft_server/phpmyadmin
cp ./tmp/config.inc.php /usr/share/phpmyadmin
cp ./tmp/plugin_interface.lib.php /usr/share/phpmyadmin/libraries
rm -rf phpMyAdmin-4.9.5-english.zip

# mysql
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'hballaba'@'localhost' IDENTIFIED BY 'Password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON * . * TO 'hballaba'@'localhost';" |mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#nginx
ln -s /etc/nginx/sites-available/my_nginx_conf /etc/nginx/sites-enabled/my_nginx_conf
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
service nginx start

# test
mkdir /var/www/ft_server/test
touch /var/www/ft_server/test/1 /var/www/ft_server/test/2 /var/www/ft_server/test/3
cp ./tmp/test.txt /var/www/ft_server/test


chown -R www-data /var/www/*
chmod -R 755 /var/www/*

service php7.3-fpm start

bash
