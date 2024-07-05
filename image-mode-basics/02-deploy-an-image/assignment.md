---
slug: deploy-an-image
id: 8gatpzwi8ecq
type: challenge
title: Deploy the bootc image as a VM
notes:
- type: text
  contents: |
    # Goal:

    You will take the bootc image from the registry and convert it to a disk image for KVM.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: basic
timelimit: 1
---

Copy the disk image we created to the default storage pool.
```bash,run
cp qcow2/disk.qcow2 /var/lib/libvirt/images/bootc-vm.qcow2
```

Using virt-install we can define a simple VM and import the new disk image.
```bash,run
virt-install --name bootc \
 --disk /var/lib/libvirt/images/bootc-vm.qcow2 \
--import \
--memory 2048 \
--graphics none \
--osinfo rhel9-unknown \
--noautoconsole \
--noreboot
```

Once the VM has been defined, we're ready to start it and attach to the console.
```bash,run
virsh start bootc
```
<div style="border: 1px solid black; border-radius: 5px; padding-left: 1em; padding-bottom: 1em; background-color: lightgray; color: black; border-radius: 5px;">
  <h3 style="color: black; border-radius: 5px;">✅ Use Tab: <strong>VM console</strong></h3>
</div>

> [!NOTE]
> If the console hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name

Once the system has finished booting, you can log in with the following credentials. These were injected by `bootc-image-builder` when creating the disk image. There are several ways to handle user creation and authentication methods, customizing the disk image with `bootc-image-builder` is just one.

Username: __core__
Password: __redhat__

The initial image included Apache, so let's check on it's status

```bash,run
systemctl status httpd
```

Somehow, we missed installing our standard editor!
```bash,run
which vim
```

Let's add vim to our image in the next step