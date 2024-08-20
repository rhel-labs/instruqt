---
slug: apply-image
type: challenge
title: Apply the new image
teaser: Apply the new image changes to the system
notes:
- type: text
  contents: |-
    # Goal:

    Managing changes to a bootc host is centralized in one tool, bootc. You will explore this tool, understand the information it provides, and how to apply an update to a host. Understanding how bootc manages images on disk is key to day 2 management.

    In this exercise, we'll apply the updated image we created containing vim.
tabs:
- id: 1yjdpi8srzix
  title: Terminal
  type: terminal
  hostname: rhel
- id: pzj6sgp9ncuu
  title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
- id: yr6lhrue8afd
  title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: ""
---
Image vs host state
===

You can return to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab to explore what happened to the new index.html file

Did the new index get created in the image? We can check by running the image as a container and inspecting the directory.

```bash,run
podman run --rm -d [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:v2 ls /var/www/html
```

The file is there, so why didn't it show up on the host? In the first lab, we discussed how `/etc` is treated in image mode. The `/var` hierarchy is also treated specially.

|directory|owner|bootc action|
|---|---|---|
|/usr|image|overwrite|
|/etc|host|merge|
|/var|host|ignore|

Since `/var` is considered to be machine state, we need to change the webroot of Apache to somehwere we can control from the image. Let's look at a new Containerfile to see how we can do that.

Click on the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab.

Select Containerfile.index from the list on the right side of the tab.

![](../assets/containerfile_scripteditor.png)

Look at the new `RUN` command that uses the `heredoc` format to wrap several lines. This block will move the default directory and files installed by Apache to a new directory under `/var`. The second line will update the default config file to change the default document root to our new directory.  Note that since we haven't made any local changes to this file in `/etc` on the host, this change will show up on the host. If you had made local changes to the config, you may need to to create a drop-in file or use some other means to update the Apache config.

Once you feel you understand the change, you can return to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab 
Use podman to update the image.
===
We can pass this file to the `podman build` command to get an updated image, but this time with a `v3` tag.

```bash,run
podman build -t [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:v3 -f Containerfile.index
```

Push the image to the registry
===

Once the updated image has been built, we can push it to the registry. Once again, note how only the changed layers need to be added to the registry even though we created a new tag.

```bash,run
podman push [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:v3
```

Check the VM is running the applications we installed
===
To update the VM, return to the the VM Console by clicking on the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-2) tab.

> [!NOTE]
> If the console hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name. The prompt will look like this. ![](../assets/terminal_prompt.png)

Log in with the following credentials:

Username:

```bash,run
core
```

Password:

```bash,run
redhat
```

Switch to the v3 image
===
Just like in the first exercise, we can use `bootc switch` to change to the image we just created with the updated Apache config.
```bash,run
sudo bootc switch [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:v3
```
Check that the new image has been staged for the next boot.
```bash,run
sudo bootc status | grep staged:
```

Let's go ahead and restart the system once more to get our changes.
```bash,run
sudo reboot
```

Once the system has completed rebooting, you can log back in.
Username:

```bash,run
core
```

Password:

```bash,run
redhat
```

You've now explored how to change the image that a host is tracking, gained some insights into the differences between directory states, and been able to roll back from an image update. This should provide a good basis to explore image mode further on your own!