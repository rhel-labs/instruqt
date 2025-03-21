#!/bin/bash

dnf -y install podman

# Set the expected version of the base image to pull
BOOTC_RHEL_VER=9.4

# For the target bootc system build, we need to replicate a container from
# the image-mode-basics lab. We pull from the setup-rhel.sh to create the
# source bootc image and then use BIB to build a fresh VM every run

virsh undefine bootc2 --remove-all-storage

# Since BIB needs root privs to run and we are using local storage to avoid
# the need for a registry, and we need a system QMEU session for the VM, 
# this script should be run via sudo so the whole context is system level

# create sudoers drop in and etc structure to add to container
mkdir -p ~/etc/sudoers.d/
echo "%wheel  ALL=(ALL)   NOPASSWD: ALL" >> ~/etc/sudoers.d/wheel

#  create updated bootc containerfile from image-mode-basics
cat <<EOF> ~/containerfile.foo
FROM registry.redhat.io/rhel9/rhel-bootc:$BOOTC_RHEL_VER

ADD etc /etc

RUN dnf install -y httpd vim
RUN systemctl enable httpd

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

# Log into the terms registry and pull the two containers
podman login -u='1979710|rhel-tmm' -p=eyJhbGciOiJSUzUxMiJ9.eyJzdWIiOiI4YjI5Yzk2YzQ0OGI0Njc5ODdhMGY5OGZlYmVlYTcwZCJ9.hRYDEQXe98m5-pvCdiKAcdvHMdIK57RsNn5YR7-uCDUQC3503sjXlMYZMIDBUVK6T5HZijv4Hs5wGjGw4STLt5-ZF9Tyg1AlXHP-HTYpYLiCngt93o9Uf6-wVDj7fH2MDw3AwMzGkjduAgCouotP-JP9HkhP9trmqnPtDECkhnw3Q5CVYT_i576RtWO9VQ0iyjiSGGaRtEcePFlxs53UJ3mj5wD3yE6Mvek7Dt1gSl-nDXdSdiQoekR8AMPPJRhj1W4btuV6gTOS1uY6YfEBH6_d1KUEMolRGzkXJURB9T2Nr6S4xgWLT7yuJLl906Y9_jXYMolpzY0Zx15EHmyHrFdnJV6qXRABFfP49UsLaYmnNBWKqXm-8uX1-XgVSBpuGUGG0NDdKS9BCiflmXXcgsZakX-HRz-hZhMYl3-8-wVHiw5qh4Xm5Jj3SsjaRH16DWMFQEXC3HzUQtq8a-eHMP0COnioGy7Sc-hwpLjnmHnUCR2zgASO_Tb-6uP8e7IVpsyo7Wpg9tlOnkBRoggissHhnnTdqVRbKKNV6zOIlJI9KIfMtxUUlpxAv1oKLLnvBuY9wyRl_i2C2GGoaGB68iyYldncrzQROS9tvIg2u1bCiB5HwtJ--U4jf1am1vC5TDnmAFC3ZYfvNpX6L8CeCNjI2NXGUzQ0Z_JyKdAHbF0 registry.redhat.io

podman pull registry.redhat.io/rhel9/rhel-bootc:$BOOTC_RHEL_VER registry.redhat.io/rhel9/bootc-image-builder:$BOOTC_RHEL_VER

# Build the bootc image then convert to a QCOW2 using local storage
# The tag is a real Instruqt particpant ID with one letter removed
# This way it looks close enough but shouldn't accidentally collide
# with a real session
podman build -t rhel.pdnis0xkcq.instruqt.io:5000/test-bootc -f ~/containerfile.foo

podman run --rm --privileged \
	--security-opt label=type:unconfined_t \
        --volume ~:/output \
        --volume ~/config.json:/config.json \
        --volume /var/lib/containers/storage:/var/lib/containers/storage \
		registry.redhat.io/rhel9/bootc-image-builder:$BOOTC_RHEL_VER \
        --local \
        --type qcow2 \
        --config config.json \
         rhel.pdnis0xkcq.instruqt.io:5000/test-bootc

# The QCOW needs to be renamed and BIB doesn't support target names yet
# The virt-install is taken directly from the image-mode-basics assignment
cp ~/qcow2/disk.qcow2 /var/lib/libvirt/images/bootc2-vm.qcow2

virt-install --name bootc2 \
--disk /var/lib/libvirt/images/bootc2-vm.qcow2 \
--import \
--memory 2048 \
--graphics none \
--osinfo rhel9-unknown \
--noautoconsole \
--noreboot

podman rmi rhel.pdnis0xkcq.instruqt.io:5000/test-bootc