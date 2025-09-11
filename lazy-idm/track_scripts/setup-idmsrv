#!/bin/bash

subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "setting password" >> /root/post-run.log
echo redhat | passwd --stdin rhel

echo "trashing GCP repos" >> /root/post-run.log
mv /etc/yum.repos.d/google-cloud.repo /root

myip="$(hostname -I | awk '{print $1}')"
agent variable set MY_IP $myip

hostnamectl set-hostname idmsrv.idm.example.com

echo "DONE" >> /root/post-run.log
