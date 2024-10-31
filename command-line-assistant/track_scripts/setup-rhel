#!/bin/bash

subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "setting password" >> /root/post-run.log
echo redhat | passwd --stdin rhel
