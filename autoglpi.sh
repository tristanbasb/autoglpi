#!/bin/bash

#Mise a jour des paquets
apt-get update && apt-get upgrade -y

#Installation d'Apache2
apt-get install apache2 php libapache2-mod-php -y

#Installation de PHP
apt-get install php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap -y -y
 
#Installation de Mariadb
apt-get install mariadb-server -y

#Installation des modules complementaire
apt-get install apcupsd php-apcu -y

#Redemarage des services
systemctl restart apache2 
systemctl restart mariadb

#Creation de la base de donnee
mysql -e 'CREATE DATABASE glpidb'
mysql -e 'grant all privileges on glpidb.* to glpiuser@localhost identified by "mdp"'

#Modification du fichier de configuration d'apache
rm /etc/apache2/sites-available/000-default.conf
mv conf.txt /etc/apache2/sites-available/000-default.conf
rm /var/www/html/index.html

#Redemarage d'apache2
systemctl restart apache2 

#Installation de glpi
cd /usr/src
wget https://github.com/glpi-project/glpi/releases/download/9.3.3/glpi-9.3.3.tgz
tar -xvzf glpi-9.3.3.tgz -C /var/www/html

#Droit pour glpi
chown -R www-data /var/www/html/glpi/