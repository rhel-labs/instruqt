#!/bin/bash
# until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
# do
#     echo "Waiting for Instruqt to finish booting the VM"
#     sleep 1
# done

#useradd rhel
subscription-manager register --org=12451665 --activationkey=${ACTIVATION_KEY} --force

echo -e "test\ntest" | passwd rhel
mkdir -p /home/rhel/.ssh
cp .ssh/id_rsa.pub /home/rhel/.ssh/
cp .ssh/authorized_keys /home/rhel/.ssh/
chown rhel:rhel -R /home/rhel/.ssh/