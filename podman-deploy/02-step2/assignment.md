---
slug: step2
id: b509nwihtx3h
type: challenge
title: Deploy a container image into an interactive container runtime
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 60
---
The __rhel8-httpd__ container includes a bash shell.  In this step, you will
deploy the container in an interactive fashion, which will allow you to run commands within the deployed container. Use *Pane 0*.

```bash
podman run -it rhel8-httpd /bin/bash
```

You should now be looking at a generic bash shell prompt:
<pre class="file">
bash-4.4#
</pre>

In *Pane 0*, the displayed shell is running inside the container image, not the host operating system.  To confirm this, take a look at the mounted filesystems:

```bash
df -hP
```

<pre class="file">
Filesystem      Size  Used Avail Use% Mounted on
overlay          35G  6.1G   30G  36% /
tmpfs            64M     0   64M   0% /dev
tmpfs           909M  9.8M  900M   2% /etc/hosts
shm              63M     0   63M   0% /dev/shm
tmpfs           909M     0  909M   0% /sys/fs/cgroup
tmpfs           909M     0  909M   0% /proc/acpi
tmpfs           909M     0  909M   0% /proc/scsi
tmpfs           909M     0  909M   0% /sys/firmware
tmpfs           909M     0  909M   0% /sys/fs/selinux
tmpfs           909M     0  909M   0% /sys/dev
</pre>

You will notice that all of the filesystem contents are either memory-based (tmpfs, shm) or the overlay file associated with this runtime of the container image (overlay).

Switch to *Pane 1* by typing `ctrl-b` and then the down arrow key.  *Pane `* is running on the host system.  Use this shell to verify that the container is running:

```bash
podman ps -a
```

<pre class="file">
CONTAINER ID  IMAGE                         COMMAND               CREATED         STATUS                    PORTS                   NAMES
df54b664f133  localhost/rhel8-httpd:latest  /bin/bash             34 seconds ago  Up 33 seconds ago                                 heuristic_cray
</pre>

__Note:__ Your CONTAINER ID and NAMES will be different than the output displayed above as each container is assigned a unique ID and Name.
