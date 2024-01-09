#!/bin/bash
while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
   echo "Waiting for Instruqt to finish booting the VM"
   sleep 1
done
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force
