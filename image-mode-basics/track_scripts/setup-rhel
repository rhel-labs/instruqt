#!/bin/bash
set -euxo pipefail

subscription-manager config --rhsm.manage_repos=1
subscription-manager register --activationkey=${ACTIVATION_KEY} --org=12451665 --force

# Log into terms based registry and stage bootc and bib images
dnf -y install podman skopeo
BOOTC_RHEL_VER=9.5
agent variable set BOOTC_RHEL_VERSION $BOOTC_RHEL_VER
podman login -u='1979710|rhel-tmm' -p=${REG_SVC_ACCT} registry.redhat.io
podman pull registry.redhat.io/rhel9/rhel-bootc:$BOOTC_RHEL_VER registry.redhat.io/rhel9/bootc-image-builder:$BOOTC_RHEL_VER

# Some shortcuts for users
# reglogin - uses podman secret to log into the terms based registry in case creds time out or initial pull fails
# registry ENV variable -  the registry target created for the lab
printf ${REG_SVC_ACCT} | podman secret create regpass -
cat <<EOF >> /root/.bashrc
export REGISTRY="${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io:5000"
alias reglogin="podman login -u='1979710|rhel-tmm' --secret regpass registry.redhat.io"
EOF

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "setting password" >> /root/post-run.log
echo redhat | passwd --stdin rhel

# set up SSL for fully functioning registry
# Enable EPEL for RHEL 9
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install -y certbot

# stop the process that is using TCP port 80; we need that port open for certbot
# fuser -k 80/tcp

# request certificates
certbot certonly --standalone --preferred-challenges http -d ${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io --non-interactive --agree-tos -m trackbot@instruqt.com -v

# run a local registry with the provided certs
podman run --privileged -d \
  --name registry \
  -p 5000:5000 \
  -v /etc/letsencrypt/live/${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io/fullchain.pem:/certs/fullchain.pem \
  -v /etc/letsencrypt/live/${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io/privkey.pem:/certs/privkey.pem \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/fullchain.pem \
  -e REGISTRY_HTTP_TLS_KEY=/certs/privkey.pem \
  registry:2

# For the target bootc system build, we need to set up a few config files to operate in the lab environment
# create sudoers drop in and etc structure to add to container
mkdir -p ~/etc/sudoers.d/
echo "%wheel  ALL=(ALL)   NOPASSWD: ALL" >> ~/etc/sudoers.d/wheel

# create the etc/hosts override to let the target VM see the registry
echo $(getent hosts ${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io) >> ~/etc/hosts

# add hostname to runtime variable

agent variable set CONTAINER_REGISTRY_ENDPOINT ${HOSTNAME}.${INSTRUQT_PARTICIPANT_ID}.instruqt.io:5000

# turn off complexity checks in target for passwords to ease the learner experience
mkdir -p ~/etc/security
cat <<EOF> ~/etc/security/pwquality.conf
# Configuration for systemwide password quality limits
# Defaults:
#
# Number of characters in the new password that must not be present in the
# old password.
# difok = 1
#
# Minimum acceptable size for the new password (plus one if
# credits are not disabled which is the default). (See pam_cracklib manual.)
# Cannot be set to lower value than 6.
minlen = 6
#
# The maximum credit for having digits in the new password. If less than 0
# it is the minimum number of digits in the new password.
# dcredit = 0
#
# The maximum credit for having uppercase characters in the new password.
# If less than 0 it is the minimum number of uppercase characters in the new
# password.
# ucredit = 0
#
# The maximum credit for having lowercase characters in the new password.
# If less than 0 it is the minimum number of lowercase characters in the new
# password.
# lcredit = 0
#
# The maximum credit for having other characters in the new password.
# If less than 0 it is the minimum number of other characters in the new
# password.
# ocredit = 0
#
# The minimum number of required classes of characters for the new
# password (digits, uppercase, lowercase, others).
# minclass = 0
#
# The maximum number of allowed consecutive same characters in the new password.
# The check is disabled if the value is 0.
# maxrepeat = 0
#
# The maximum number of allowed consecutive characters of the same class in the
# new password.
# The check is disabled if the value is 0.
# maxclassrepeat = 0
#
# Whether to check for the words from the passwd entry GECOS string of the user.
# The check is enabled if the value is not 0.
# gecoscheck = 0
#
# Whether to check for the words from the cracklib dictionary.
# The check is enabled if the value is not 0.
dictcheck = 0
#
# Whether to check if it contains the user name in some form.
# The check is enabled if the value is not 0.
# usercheck = 0
#
# Length of substrings from the username to check for in the password
# The check is enabled if the value is greater than 0 and usercheck is enabled.
# usersubstr = 0
#
# Whether the check is enforced by the PAM module and possibly other
# applications.
# The new password is rejected if it fails the check and the value is not 0.
enforcing = 0
#
# Path to the cracklib dictionaries. Default is to use the cracklib default.
# dictpath =
#
# Prompt user at most N times before returning with error. The default is 1.
# retry = 3
#
# Enforces pwquality checks on the root user password.
# Enabled if the option is present.
# enforce_for_root
#
# Skip testing the password quality for users that are not present in the
# /etc/passwd file.
# Enabled if the opt
EOF

# create config.json for BIB to add a user / pass
cat <<EOF> ~/config.json
{
  "blueprint": {
    "customizations": {
      "user": [
        {
          "name": "core",
          "password": "redhat",
           "groups": [
	            "wheel"
	          ]
        }
      ]
    }
  }
}
EOF

# create basic bootc containerfile
cat <<EOF> Containerfile
FROM registry.redhat.io/rhel9/rhel-bootc:$BOOTC_RHEL_VER

ADD etc /etc

RUN dnf install -y httpd
RUN systemctl enable httpd

EOF
