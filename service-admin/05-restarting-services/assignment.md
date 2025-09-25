---
slug: restarting-services
id: pfzkfvzlvi7h
type: challenge
title: Restarting a service to apply configuration changes
tabs:
- id: wx2klvxdorno
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---

Restarting a service to apply configuration changes
===
To demonstrate how configuration changes behave when a service is already running, add an export directory to the NFS service on this system:

```bash,run
echo "/home" >> /etc/exports
```

This command adds the home directory to the export list configuration file for NFS. Changing this config file does not lead to any immediate changes in the NFS service, though. Print the export list again to confirm this:

```bash,run
showmount -e
```

<pre class=file>
Export list for rhel:
</pre>

To bring configuration changes into the service, you must first use `systemctl` to restart it:

```bash,run
systemctl restart nfs-server
```

Now the configuration files have been re-read and NFS reflects the configuration change.

```bash,run
showmount -e
```

<pre class=file>
Export list for rhel:
/home *
</pre>

The home directory is now listed as an exported drive that is available to all NFS clients. If you ever run into a scenario where you are unable to see configuration changes, make sure you check whether or not you have restarted the service and reloaded the config files.

systemd Cheat Sheet
===
This lab just scratches the surface of __systemd__'s capabilities. Red Hat provides a [systemd Cheat Sheet](https://access.redhat.com/articles/systemd-cheat-sheet) which has a variety of other commands that are useful for service management.
