#!/bin/bash
while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    echo "Waiting for Instruqt to finish booting the VM"
    sleep 1
done

dnf remove -y google-rhui-client*
dnf clean all
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

dnf install -y tmux

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setting password" >> /root/post-run.log
echo redhat | passwd --stdin rhel

echo "Fixing permissions" >> /root/post-run.log
chown -R rhel:rhel /home/rhel/
