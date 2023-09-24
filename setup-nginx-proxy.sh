#!/bin/bash
clear

# *****************************************************************************
#  Script: setup-nginx-proxy / setup-nginx-proxy.sh
#  Author: Robert Partridge
#  URL: https://gitea.techaddressed.com/robert/setup-nginx-proxy
# *****************************************************************************

# check for root permissions
if [ "$EUID" -ne 0 ]
  then echo "PLEASE RUN THIS SCRIPT WITH ROOT PRIVILEGES"
  exit
fi

# update system
apt update && apt upgrade -y && apt autoremove -y && apt clean

# install packages
apt install ntp nano nginx certbot ufw -y

# copy config files
cp config/example* /etc/nginx/sites-available/
cp config/mime.types /etc/nginx/
cp config/nginx.conf /etc/nginx/
cp config/*realip.conf /etc/nginx

# disable default config
rm /etc/nginx/sites-enabled/default

# restart services
systemctl restart nginx

# configure ufw firewall but do not enable
ufw allow 80/tcp
ufw allow 443/tcp

# complete
echo
echo
echo "SETUP COMPLETE"
echo "UFW SET TO ALLOW PORTS 80/TCP AND 443/TCP"
echo "IF NEEDED - MAKE ADDITIONAL FIREWALL MODIFICATIONS BEFORE ENABLING UFW"
