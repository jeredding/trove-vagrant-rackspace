#!/bin/bash
export PATH=/sbin/:/usr/sbin/:/usr/local/bin:/usr/local/sbin:$PATH
VBASE=/vagrant/public
RDI_SCRIPTS=${VBASE}/reddwarf-integration/scripts
VM_USER=ubuntu

echo "starting redstack" 
cat <<HERE  >> /etc/apt/sources.list 
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise main restricted
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise-updates main restricted
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise universe
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise-updates universe
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise-updates multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse
HERE
cat <<SUUU >> /etc/sudoers
$VM_USER ALL=(ALL) NOPASSWD:ALL

SUUU
chmod 660 /dev/pts/0
apt-get update
apt-get install -y git 
adduser $VM_USER
chown -R $VM_USER $VBASE
pushd $RDI_SCRIPTS
echo "KILL SCREEN!!!" 
killall screen
echo "if we're rebuilding..."
if [[ -n "$REBUILDIMG" ]]; then
    rm ~/images/precise_mysql_image/*
    rmdir ~/images/precise_mysql_image
fi
echo "install some things:"
apt-get install -y  build-essential python-setuptools 
echo "lets get started..."
su - $VM_USER -c "PATH=/sbin/:/usr/sbin/:/usr/local/bin:/usr/local/sbin:$PATH; \
pushd /vagrant/public/reddwarf-integration/scripts/; ./redstack install \
  && ./redstack kick-start mysql \
  && sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE"
