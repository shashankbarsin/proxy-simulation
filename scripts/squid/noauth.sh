#!/bin/bash

sudo apt-get update && sudo apt-get install -y libssl-dev pkg-config build-essential autoconf

wget http://www.squid-cache.org/Versions/v4/squid-4.12.tar.gz 
tar xvzf squid-4.12.tar.gz
cd squid-4.12
./configure --with-openssl  --enable-ssl-crtd
sudo make && sudo make install && rm /usr/local/squid/etc/squid.conf && cp ../squid-noauth.conf /usr/local/squid/etc/squid.conf

sudo chmod 777 /usr/local/squid/var/logs
sudo /usr/local/squid/sbin/squid start