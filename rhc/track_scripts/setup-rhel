#!/bin/bash
LOG=/root/setup-log
#LOG=/dev/null




subscription-manager config --rhsm.manage_repos=1 >> $LOG
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force >> $LOG

dnf install -y rhc >> $LOG

subscription-manager unregister >> $LOG
subscription-manager clean >> $LOG

echo "export KEY='rhc-lab'" >> /root/.bashrc

hostnamectl set-hostname rhel-$(uuidgen | cut -c 32-)
exec $SHELL