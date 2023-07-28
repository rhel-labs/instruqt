---
slug: systemctl
id: a91ihv7upxxd
type: challenge
title: Starting and enabling a service with systemctl
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

For this example, you will be using the Network File System (NFS) service. This service allows users on client systems to view files and directories over a network as if they were on the client's local drive. Rather than focusing on the functionality of this service, though, this lab simply uses it as an example of how to start a service and implement configuration file changes.

To begin, run the command to show the export list for the NFS server:

```bash
showmount -e
```

This throws an error, because the NFS service is not running.

<pre class=file>
clnt_create: RPC: Program not registered
</pre>

To solve this issue, you need to start the service. However, if you want the service to start each time you boot the system, you need to enable the service. You can do both of these operations in one line:

```bash
systemctl enable --now nfs-server
```

<pre class=file>
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-server.service → /usr/lib/systemd/system/nfs-server.service
</pre>

>_Note:_ If you just wanted to start a service, `systemctl start` followed by the service name will do the trick. However, the service will not start again if you reboot the system.

Now the __nfs-server__ service is started, and it will start every time the system starts as well. Run the `showmount` command again now that the service is active:

```bash
showmount -e
```

<pre class=file>
Export list for rhel:
</pre>

The export list is currently blank, which is something controlled by a configuration file. You may assume that changing a config file would immediately lead to changes in the service, but this is not the case. The next step will walk you through restarting a service to reload configuration files.
