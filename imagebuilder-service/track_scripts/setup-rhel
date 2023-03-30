#!/bin/bash
LOG=/root/setup-log
#LOG=/dev/null

subscription-manager config --rhsm.manage_repos=1 >> $LOG
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force >> $LOG

dnf install -y libguestfs guestfs-tools >> $LOG
hostnamectl set-hostname rhel-$(uuidgen | cut -c 32-)
echo "export LIBGUESTFS_BACKEND=direct" >> /root/.bashrc
exec $SHELL
