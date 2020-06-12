#!/bin/bash
# @sacloud-once

USERNAME=@@@user_name@@@	# centos
ETH1_IP=@@@eth1_ip@@@ 	      	# *.*.*.*/**
UPDATE=@@@update@@@ 	      	# yes
FIREWALL=@@@firewall@@@       	# no
LOOPBACK_IP=@@@loopback_ip@@@ 	# *.*.*.*
HTTPD=@@@httpd@@@		# yes

function create_user() {
  USER=$USERNAME
  if [ "$USER" == ""]; then return 0; fi
  id $USER > /dev/null 2>&1 && return 0;
  useradd $USER
  TEST=`cat /etc/shadow | grep root | awk -F':' '{print $2}'`
  sed -i -e "s|^$USER:!!|$USER:$TEST|" /etc/shadow
  mkdir /home/$USER/.ssh
  cp /root/.ssh/authorized_keys /home/$USER/.ssh/
  chown -R $USER:$USER /home/$USER/.ssh/
  chmod 700 /home/$USER/.ssh/
  chmod 600 /home/$USER/.ssh/authorized_keys
  echo "$USER ALL=(ALL) NOPASSWD: ALL"> /etc/sudoers.d/$USER
}
create_user

function eth1_setup() {
  IP=$ETH1_IP
  if [ "$IP" == "" ]; then return 0; fi
  ip a s | grep -q $IP && return 0;
  nmcli con mod "System eth1" \
  ipv4.method manual \
  ipv4.address $IP \
  connection.autoconnect "yes" \
  ipv6.method ignore
  nmcli con down "System eth1"; nmcli con up "System eth1"
}
eth1_setup

function init_loopback() {
  IP=$LOOPBACK_IP
  if [ "$IP" == "" ]; then return 0; fi
  if [ -f /etc/sysconfig/network-scripts/ifcfg-lo:0 ]; then
    return 0;
  fi
cat <<__EOF__ >> /etc/sysconfig/network-scripts/ifcfg-lo:0
DEVICE=lo:0
IPADDR=$IP
NETMASK=255.255.255.255
__EOF__
  ifup lo:0

  grep -q "net.ipv4.conf.all.arp_ignore = 1" /etc/sysctl.conf && return 0;
  echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
  echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
  sysctl -p
}
init_loopback

function start_update() {
  if [ "$UPDATE" == "yes" ]; then
    yum -y update
  fi
}
start_update

function install_httpd() {
  systemctl list-unit-files | grep -q "httpd" && return 0;
  if [ "$HTTPD" == "yes" ]; then
    yum install -y httpd mod_ssl
    systemctl enable httpd
    systemctl start httpd
    hostname > /var/www/html/index.html
  fi
}
install_httpd

function disable_firewalld() {
  if [ "$FIREWALL" == "no" ]; then
    systemctl stop firewalld
    systemctl disable firewalld
  fi
}
disable_firewalld

