---
slug: step6
id: gk9svob2iyj1
type: challenge
title: Step 6
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Terminal SQL Server
  type: terminal
  hostname: rhel
- title: Terminal SQL Client
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
## Checkpoint and restore the SQL Server container

Podman can be used to checkpoint and restore running containers. Podman uses CRIU (Checkpoint/Restore In Userspace) to save the contents of the memory of a container (in a checkpoint file) and launch a container from the saved checkpoint file (restore). This greatly improves container portability, and reduces  application start up or cache warming time.

To install the CRIU dependency package (__criu__) that is needed for checkpoint-restore podman functionality execute -

```bash
yum -y install criu
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Updating Subscription Management repositories.
Last metadata expiration check: 0:16:23 ago on Thu 19 Nov 2020 03:26:20 PM EST.
Package criu-3.14-2.module+el8.3.0+8221+97165c3f.x86_64 is already installed.
Complete!
</pre>

After installing the criu package, create a configuration file to adjust the maximum ghost file limit. By default, 1MB is the maximum size of a deleted file that criu can handle, but in the case of SQL Server, temporary files might exceed this limit and hence the ghost-file size must be adjusted.

```bash
echo ghost-limit = 40000000 > /etc/criu.conf
```

In the *Terminal Server* tab of the lab interface, checkpoint the running SQL Server container and export the checkpoint to a compressed file

```podman container checkpoint -l --export=/tmp/checkpoint1.tar.gz```

<pre class="file">
cb88e6ff3f5e671211b000c7fa4f2006951302145885d87d50e7bbadefd85f27
</pre>

Taking a checkpoint without the *--leave-running* option will stop the running container. At this point, confirm that there is no running container -

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE  COMMAND  CREATED  STATUS  PORTS  NAMES
</pre>

Now, restore the container from the stored checkpoint file. This capability can be quite useful in the case of a migration or debugging scenario.

```bash
podman container restore --import=/tmp/checkpoint1.tar.gz --name mssqlserver-restored
```

<pre class="file">
ea72c83f945af03d2b03fedd21c3b6743310b7cacc77d6152f453c37cc8cf56c
</pre>

Finally, verify that the container restored from the checkpoint file is running - The name of the container should be *mssqlserver-restored*

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE                                            COMMAND               CREATED             STATUS                 PORTS                   NAMES
ea72c83f945a  mcr.microsoft.com/mssql/rhel/server:2019-latest  /opt/mssql/bin/sq...  About a minute ago  Up About a minute ago  0.0.0.0:1400->1433/tcp  mssqlserver-restored
</pre>

Also, notice that the port mapping matches the original port mapping (Host port *1400* maps to container port *1433*).
