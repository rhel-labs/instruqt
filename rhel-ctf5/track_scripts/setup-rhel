#!/bin/bash
while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    echo "Waiting for Instruqt to finish booting the VM"
    sleep 1
done

yum remove -y google-rhui-client-rhel8.noarch
yum clean all
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

dnf -y install tmux

#Create a done file to signal we have finished
touch ${LOG}.done
n=1
GREEN='\033[0;32m' 
NC='\033[0m' # No Color

while [ ! -f ${LOG}.done ] ;
do
      if test "$n" = "1"
      then
	    clear
            n=$(( n+1 ))	 # increments $n
      else
	    printf "."
      fi
      sleep 2
done
clear
echo -e "${GREEN}Ready to start your scenario${NC}"
