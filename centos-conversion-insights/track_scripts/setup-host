while [ ! -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    echo "Waiting for Instruqt to finish booting the VM"
    sleep 1
done

agent variable set sandboxid $_SANDBOX_ID

virsh start centos

echo "${SSHKEY}" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keygen -f /root/.ssh/id_rsa -y > /root/.ssh/id_rsa.pub

# This sleep call is to give libvirt-nss time to find the ip address of the vm.
sleep 30

# Attempt to register the vm 3 times, waiting 30 seconds for each attempt.
#(r=3;while ! ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" centos "subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force" ; do ((--r))||exit;sleep 30;done)

centosid="centos-conversion-$(uuidgen | cut -c 32-)"
agent variable set vmid "$centosid"
ssh -o "StrictHostKeyChecking no" root@centos hostnamectl set-hostname "$centosid"
echo "nameserver 8.8.8.8" > /etc/resolv.conf
