#!/bin/bash
# Deploys test.xmpp.is on a new server

echo

echo "Installing packages I like or need :)"
apt install -y htop dstat nload iftop iotop nmap haveged rsync dirmngr apt-utils apt-transport-https dialog ca-certificates wget curl nano lsb-release mtr-tiny

echo

echo "Adding the official Prosody repository"
echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | tee -a /etc/apt/sources.list
wget https://prosody.im/files/prosody-debian-packages.key -O- | apt-key add -

echo

echo "Adding the official Tor repository"
echo deb https://deb.torproject.org/torproject.org $(lsb_release -sc) main | tee -a /etc/apt/sources.list
gpg --keyserver pgp.mit.edu --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

echo

echo "Adding Hiawatha repository"
echo deb https://mirror.tuxhelp.org/debian/ squeeze main | tee -a /etc/apt/sources.list
apt-key adv --recv-keys --keyserver keys.gnupg.net 79AF54A9

echo

echo "Adding GoAccess repository"
echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | tee -a /etc/apt/sources.list.d/goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | apt-key add -

echo

echo "Running apt update"
apt update

echo

echo "Installing Prosody"
apt install -y prosody lua-zlib lua-bitop lua-event lua-socket lua-sec

echo

echo "Installing Tor"
apt install -y tor deb.torproject.org-keyring

echo

echo "Installing Hiawatha"
apt install -y hiawatha

echo

echo "Installing GoAccess"
apt install -y goaccess

echo

echo "Installing Certbot"
apt install -y certbot

echo

echo "Installing dependencies for config & module pulling"
apt install -y git mercurial

echo

echo "Making directories"
mkdir -p /etc/prosody/certs
mkdir -p /etc/hiawatha/ssl
mkdir -p /var/www/test.xmpp.is

echo

echo "Pulling configs and modules"

echo

# Prosody configs & scripts
git clone https://github.com/crypto-world/test.xmpp.is /home/git/test.xmpp.is

# Official Prosody modules
hg clone https://hg.prosody.im/prosody-modules/ /var/lib/prosody/modules

# Email password reset module
git clone https://github.com/crypto-world/mod_email_pass_reset_english /home/git/mod_email_pass_reset_english

# Prosody web registration theme
git clone https://github.com/crypto-world/prosody-web-registration-theme /home/git/prosody-web-registration-theme

echo

echo "Applying open file limits"
echo "prosody hard nofile 999999" | tee -a /etc/security/limits.conf
echo "prosody soft nofile 999999" | tee -a /etc/security/limits.conf
echo "DefaultLimitNOFILE=999999" | tee -a /etc/systemd/system.conf
echo "fs.file-max = 999999" | tee -a /etc/sysctl.conf
echo "MAXFDS=999999" | tee -a /etc/default/prosody

echo

echo "Setting up TCP BBR"
echo "net.core.default_qdisc=fq" | tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | tee -a /etc/sysctl.conf

echo

echo "Executing final steps"
bash /home/git/test.xmpp.is/scripts/letsencrypt-to-hiawatha.sh
bash /home/git/test.xmpp.is/scripts/sync.sh
bash /home/git/test.xmpp.is/scripts/force-owner-and-group.sh

echo

echo "Restarting services"
service prosody restart
service hiawatha start
service tor restart

echo

echo "Deploy finished, server must be rebooted now"
