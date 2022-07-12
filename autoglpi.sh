#!/bin/bash

#Mise a jour des paquets
apt-get update && apt-get upgrade -y

#Installation d'Apache2
apt-get install apache2 php libapache2-mod-php -y

#Installation de PHP
apt-get install php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap -y
 
#Installation de Mariadb
apt-get install mariadb-server -y

#Installation des modules complementaire
apt-get install apcupsd php-apcu -y

#Installation de perl
apt install perl -y

#Redemarage des services
systemctl restart apache2 
systemctl restart mariadb

#Creation de la base de donnee
mysql -e 'create database db_glpi'
mysql -e 'grant all privileges on db_glpi.* to admindb_glpi@localhost identified by "mdp"'

#Modification du fichier de configuration d'apache
rm /etc/apache2/sites-available/000-default.conf
mv conf.txt /etc/apache2/sites-available/000-default.conf

#Redemarage d'apache2
systemctl restart apache2 

#Installation de glpi
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/9.5.2/glpi-9.5.2.tgz
tar -xvzf glpi-9.5.2.tgz
rm /var/www/html/index.html
cp -r glpi/* /var/www/html/

#Droit pour glpi
chown -R www-data /var/www/html
chmod -R 775 /var/www/html

#Lien glpi
echo "
http://localhost

SQL server : localhost
SQL user : admindb_glpi
SQL password : mdp
"
