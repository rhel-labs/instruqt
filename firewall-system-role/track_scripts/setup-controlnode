#!/bin/bash
while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    echo "Waiting for Instruqt to finish booting the VM"
    sleep 1
done

virsh start vm1

subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

dnf install -y nc tmux

echo "${SSHKEY}" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keygen -f /root/.ssh/id_rsa -y > /root/.ssh/id_rsa.pub

(r=3;while ! ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1 "subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force" ; do ((--r))||exit;sleep 30;done)
