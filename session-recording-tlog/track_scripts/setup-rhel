#!/bin/bash
# Create an output file
touch /root/post-run.log
# configure rhel account
usermod -aG wheel rhel
echo redhat | passwd --stdin rhel

subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

dnf -y install sssd-proxy

# setup webui
# Create a done file to signal we have finished
touch /root/post-run.log.done
