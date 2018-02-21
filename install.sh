#!/bin/bash

# Install and configure default locale
apt-get update -q
apt-get install -y locales
dpkg-reconfigure locales
locale-gen C.UTF-8
/usr/sbin/update-locale LANG=C.UTF-8
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

apt-get install -y \
    curl \
    wget \
    unzip \
    htop \
    procps \
    vim \
    screen \
    supervisor \
    at \
    whois \
    less \
    python-pip \
    uuid-runtime \
    gawk \
    mediainfo \
    jq

chmod 777 /var/run/screen
mkdir -p /var/log/supervisor
apt-get autoclean -y
apt-get autoremove -y
pip install supervisor --upgrade

# to install mediainfo we need https
apt-get install apt-transport-https -y

# Install up-to-date mediainfo
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-5_all.deb
dpkg -i repo-mediaarea_1.0-5_all.deb
apt-get update -q
apt-get upgrade -y

# Install security updates and patches
apt-get update -q
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoclean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
