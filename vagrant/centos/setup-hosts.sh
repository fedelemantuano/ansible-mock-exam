#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.56.11  ansible-1
192.168.56.12  ansible-2
192.168.56.13  ansible-3
192.168.56.14  ansible-4
EOF

# install epel repository
yum install epel-release -y

# install ansible package
rpm --import /etc/pki/rpm-gpg/*
sudo yum install ansible -y

