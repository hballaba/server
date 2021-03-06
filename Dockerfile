FROM debian:buster

RUN apt-get update && apt-get -y install vim && apt-get -y install wget && apt-get -y install unzip



COPY ./srcs/my_nginx_conf /etc/nginx/sites-available/
COPY ./srcs/docker.sh ./
COPY ./srcs/wp-config.php /var/www/ft_server/
COPY ./srcs/config.inc.php /tmp/config.inc.php
COPY ./srcs/test.txt /tmp/test.txt
COPY ./srcs/plugin_interface.lib.php /tmp/plugin_interface.lib.php
COPY ./srcs/favicon.ico  ./var/www/ft_server

CMD bash docker.sh