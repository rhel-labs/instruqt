#!/bin/bash

subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "setting password" >> /root/post-run.log
echo redhat | passwd --stdin rhel

echo "adding ansible-core" >> /root/post-run.log
dnf install -y ansible-core ansible-freeipa bind-utils

echo "trashing GCP repos" >> /root/post-run.log
mv /etc/yum.repos.d/google-cloud.repo /root

myip="$(hostname -I | awk '{print $1}')"
agent variable set MY_IP $myip
ssh_password=`openssl rand -base64 8`
agent variable set SSH_PASSWORD $ssh_password

agent variable set SHORTNAME $_SANDBOX_ID

# Grab some ansible stuff and configure our directory structure
pushd /root
git clone https://github.com/mralph-rh/conf24 > /root/post-run.log
popd

pushd /var/tmp
ansible-galaxy collection install ./ansible-windows-2.3.0.tar.gz
ansible-galaxy collection install microsoft-ad-1.5.0.tar.gz
ansible-galaxy collection install redhat-rhel_idm-1.12.1.tar.gz
popd

cat << EOF >> /usr/bin/mkhosts.sh
#!/bin/bash
grep idmsrv /etc/hosts
if [ \$? -ne 0 ]
then
  for i in idmsrv node1 node2
    do ip=\`host \$i | grep address | awk '{print \$4}'\`;echo \$ip \$i.idm.example.com \$i >> /etc/hosts
  done
else
  rm /etc/cron.d/00-mkhosts
fi
EOF
chmod +x /usr/bin/mkhosts.sh

/usr/bin/mkhosts.sh
