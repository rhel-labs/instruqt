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

virsh attach-interface --domain vm1 --type network --source default --model virtio

TMUX='' tmux new-session -d -s 'networking-setup' ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1; clear > /dev/null 2>&1
tmux set -g pane-border-status top
tmux setw -g pane-border-format ' #{pane_index} #{pane_current_command}'
ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1 'nmcli connection delete Wired\ connection\ 1'
cat >> ~/.bashrc <<-EOF

session_name="networking-setup"
tmux has-session -t=$session_name 2> /dev/null
if [[ -z "$TMUX" ]]; then
  tmux attach-session -t "$session_name" > /dev/null 2>&1
else
  tmux switch-client -t "$session_name" > /dev/null 2>&1
fi
EOF
