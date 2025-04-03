#!/bin/bash
set -euxo pipefail

until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]; do
    echo "Waiting for instruqt bootstrap to complete"
    sleep 1
done

# subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force
# subscription-manager repos --enable=rhel-9-for-x86_64-baseos-rpms --enable=rhel-9-for-x86_64-appstream-rpms --enable=satellite-6.17-for-rhel-9-x86_64-rpms --enable=satellite-maintenance-6.17-for-rhel-9-x86_64-rpms

# echo "export LANG=en_US.UTF-8" >> /root/.bashrc

# Add the following hosts to /etc/hosts
cat <<EOT > /etc/hosts
192.0.2.2   rhel1 rhel1.lab
192.0.2.3   rhel2 rhel2.lab
192.0.2.1   satellite.lab satellite
192.0.2.4   satellite-2.lab satellite-2
192.0.2.5   capsule.lab capsule
EOT

cat <<EOT > /etc/wireguard/wg0.conf
[Interface]
Address = 192.0.2.1
ListenPort = 51820
PrivateKey = 6LXqhMZXv1vrZolWq2GpU5fCmDnFZgkBm6kkoCfIW3M=

# rhel1
[Peer]
PublicKey = tDS5lI+Dbf0I+p49bCjKJ+Q7QIrzwh3B1Zx3gxWXzFM=
AllowedIPs = 192.0.2.2/32

# rhel2
[Peer]
PublicKey = vZzGfBInJWpI7U1KwjNLdNn0z/rjVAeHJjJX093Dxys=
AllowedIPs = 192.0.2.3/32

# Satellite-2
[Peer]
PublicKey = r4AnEsHQaftmMX27FRib6CK0NoMyjgUnxS6Pdbf5ZxQ=
AllowedIPs = 192.0.2.4/32

# capsule
[Peer]
PublicKey = uTwxPNMJEn0ArFXxZN8VhZIqo1xKc/mLJtkj86oJMWQ=
AllowedIPs = 192.0.2.5/32
EOT

# Bring up wireguard interface
nmcli con import type wireguard file /etc/wireguard/wg0.conf

# dnsmasq is set to disabled. Since wg0 doesn't exist at startup, dnsmasq will error out since it's configured to do stuff with wg0.
systemctl enable --now dnsmasq

# This file is needed for challenge 5.
wget https://github.com/myee111/hello-rpm/releases/download/0.0.1/hello-0.0.1-1.el9.noarch.rpm
