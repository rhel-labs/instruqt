---
slug: deploy-an-image
id: 8gatpzwi8ecq
type: challenge
title: Deploy the bootc image as a VM
teaser: Deploy the bootc image as a VM in KVM.
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
Prepare and run the bootc image
===

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

Once the VM has been defined, we're ready to start it.

Click on `run` to run the command below.

```bash,run
virsh start bootc
```

Attach to the console of the VM running our container image
===

Next, attach to the console. Switch to the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-1) tab.

> [!NOTE]
> If the console hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name. The prompt will look like this. ![](../assets/terminal_prompt.png)

Check the vm is running the image we created
===

Once the system has finished booting, you can log in with the following credentials. These were injected by `bootc-image-builder` when creating the disk image. There are several ways to handle user creation and authentication methods, customizing the disk image with `bootc-image-builder` is just one.

In the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-1) tab, log into the vm with the following credentials.

Username:

```bash,run
core
```

Password:

```bash,run
redhat
```

The initial image included Apache, so let's check on it's status

```bash,run
systemctl status httpd --no-pager
```

The output will look like this.

![](../assets/httpd_service.png)

Let's check if the editor `vim` was installed.

```bash,run
which vim
```

![](../assets/no_vim.png)

Somehow, we missed installing our standard editor!

Let's add vim to our image in the next step
