#!/usr/bin/env bash

read -r domain

apt-get update
apt-get install

#install node
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh

bash nodesource_setup.sh
apt-get install nodejs

apt-get install build-essential

#install pm2
npm install -g pm2

#install cerbot
add-apt-repository ppa:certbot/certbot
apt-get update

apt-get install python-certbot-nginx

#allow http
ufw allow "Nginx Full"
ufw delete allow "Nginx HTTP"

status=ufw status
echo "$status"

#get ssl cert
certbot --nginx -d "$domain" -d "www.$domain"

#update hellman parameters
params=openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
echo "$params"

echo "place the param in the system block of:"
echo "/etc/nginx/sites-available/default"
