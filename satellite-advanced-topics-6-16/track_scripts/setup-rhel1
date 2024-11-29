#!/bin/bash
set -euxo pipefail

until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]; do
    echo "Waiting for instruqt bootstrap to complete"
    sleep 1
done

subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

dnf install wireguard-tools -y

subscription-manager unregister

# Create a stock wg0.conf.
cat <<EOT > /etc/wireguard/wg0.conf
[Interface]
Address = 192.0.2.2/24
PrivateKey = qIicy0R6xdgMThB/3gWZ6ZUFS7WABBUkeGjc4bEPwl0=
DNS = 192.0.2.1

[Peer]
PublicKey = 1Y7yWRJZxLK3kKKwGLPffsSf/E2nw6mxHg+yvnfvOV4=
AllowedIPs = 192.0.2.0/24
Endpoint = 10.128.0.14:51820
PersistentKeepalive = 20
EOT

# Edit the wireguard if wg0 to point at satellite's ip. Satellite's IP is dynamic. Then create the interface with nmcli.
sed -i "/^Endpoint /s/=.*$/= satellite.${_SANDBOX_ID}.svc.cluster.local:51820/" /etc/wireguard/wg0.conf

nmcli connection import type wireguard file /etc/wireguard/wg0.conf

cat <<EOT >> /etc/systemd/system/wg-startup.service
[Unit]
Description=Start up wireguard.
After=default.target

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/wg-startup.sh

[Install]
WantedBy=default.target
EOT

cat <<EOT >> /usr/local/sbin/wg-startup.sh
#!/bin/bash
nmcli con up wg0
wg syncconf wg0 /etc/wireguard/wg0.conf
EOT

chmod 700 /usr/local/sbin/wg-startup.sh
restorecon -Fvvv /usr/local/sbin/wg-startup.sh
systemctl enable wg-startup

hostnamectl set-hostname rhel1.lab
cat <<EOT >> /etc/hosts
192.0.2.2 rhel1.lab rhel1
EOT
