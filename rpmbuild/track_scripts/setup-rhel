#!/bin/bash

echo "subscription setup"
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

echo "trashing GCP repos"
mv /etc/yum.repos.d/google-cloud.repo /root

echo "installing packages"
dnf -y install bash-completion dnf-plugins-core nano tree vim-enhanced wget

echo "always ignore invalid-url rpmlint warnings"
mkdir /etc/rpmlint
echo 'addFilter("W: invalid-url")' >> /etc/rpmlint/invalid-url.config

echo "giving rhel user sudo permission"
echo 'rhel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/rhel

echo "setting password"
echo redhat | passwd --stdin rhel

echo "configuring rhel user bashrc"
cat /root/.bashrc > /home/rhel/.bashrc

echo "creating rhel downloads directory"
mkdir /home/rhel/downloads
chown rhel: /home/rhel/downloads

echo "DONE"