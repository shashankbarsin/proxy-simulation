#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -y libssl-dev pkg-config build-essential autoconf apache2-utils

wget http://www.squid-cache.org/Versions/v4/squid-4.12.tar.gz 
tar xvzf squid-4.12.tar.gz
cd squid-4.12
./configure --with-openssl  --enable-ssl-crtd
sudo make && sudo make install
sudo rm /usr/local/squid/etc/squid.conf && sudo cp ../squid-cert.conf /usr/local/squid/etc/squid.conf

groupadd -g 123 squid
useradd -g squid squid
cd /usr/local/squid
sudo mkdir ssl_cert
sudo chown squid:squid /usr/local/squid
sudo chmod 700 ssl_cert
cd ssl_cert
openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout myCert.pem  -out myCert.pem -subj "/C=IN/ST=KARNATAKA/L=BANGALORE/O=MICROSOFT/OU=ARC/CN=$1/emailAddress=test@email.com"
sudo mkdir /var/lib/squid/
sudo chown squid:squid /var/lib/squid
/usr/local/squid/libexec/security_file_certgen -c -s /var/lib/squid/ssl_db -M 4MB

cp myCert.pem /home/azureuser/myCert.crt
sudo chown azureuser:azureuser /home/azureuser/myCert.crt

sudo chmod 777 /usr/local/squid/var/logs
sudo /usr/local/squid/sbin/squid start