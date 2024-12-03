#!/bin/bash
while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    echo "Waiting for Instruqt to finish booting the VM"
    sleep 1
done

virsh start rhel08

echo "${SSHKEY}" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keygen -f /root/.ssh/id_rsa -y > /root/.ssh/id_rsa.pub

subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

# Attempt to register the vm 3 times, waiting 30 seconds for each attempt.
(r=3;while ! ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@rhel08 "subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force" ; do ((--r))||exit;sleep 30;done)

ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@rhel08 "sed -i 's/^# %wheel.*/%wheel        ALL=(ALL)       NOPASSWD: ALL/' /etc/sudoers"
