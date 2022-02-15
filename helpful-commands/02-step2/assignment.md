---
slug: step2
id: zdwvplncife9
type: challenge
title: Step 2 - Viewing the end of log files with `tail`
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
# Viewing the end of log files with `tail`

Some files are large enough that it is not practical to display their contents
with `cat`. A common example is log files, which are often packed full of
information.

Since `tail` only displays the last ten lines of a file, it is particularly
useful for viewing recent entries in log files. Take a look at the final
ten lines of the _boot_ log.

```
tail /var/log/boot.log
```

<pre class=file>
Starting Enable periodic update of entitlement certificates....
Starting Dynamic System Tuning Daemon...
Starting Network Manager Wait Online...
Starting Hostname Service...
[  OK  ] Started Enable periodic update of entitlement certificates..
[  OK  ] Started Permit User Sessions.
Starting Hold until boot process finishes up...
Starting Terminate Plymouth Boot Screen...
[  OK  ] Started Command Scheduler.
[  OK  ] Started OpenSSH server daemon.
</pre>

If you wish to then see the entire file, a text viewer like `less` or `view`
will show the entire file.

Adding the `-f` option will follow the log file so that you can see new entries.
Run this command in Terminal 2 to open an updating view of the _messages_ log, which
will display system information:

```
tail -f /var/log/messages
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Jul 15 22:37:26 6d5380e16498 NetworkManager[886]: <warn>  [1626403046.8294] device (ens5): Activation: failed for connection 'Wired connection 1'
Jul 15 22:37:26 6d5380e16498 NetworkManager[886]: <info>  [1626403046.8298] device (ens5): state change: failed -> disconnected (reason 'none', sys-iface-state: 'managed')
Jul 15 22:37:26 6d5380e16498 NetworkManager[886]: <info>  [1626403046.8343] dhcp4 (ens5): canceled DHCP transaction
Jul 15 22:37:26 6d5380e16498 NetworkManager[886]: <info>  [1626403046.8343] dhcp4 (ens5): state changed timeout -> done
</pre>

Enter Ctrl-c to break out of this stream.

<pre>
Dec  8 18:37:15 rhel systemd[1]: Started man-db-cache-update.service.
Dec  8 18:37:15 rhel systemd[1]: run-rcd7035fb3d1d4176bf081e5732f65f65.service: Succeeded.
^C
</pre>

The `logger` utility will write to this _messages_ log. From the original terminal,
write to this log:

```
logger Hello World
```

Check that this message was recorded.
```
tail /var/log/messages
```

<pre class=file>
Jul 15 22:39:06 6d5380e16498 dnf[3679]: Metadata cache created.
Jul 15 22:39:06 6d5380e16498 systemd[1]: dnf-makecache.service: Succeeded.
Jul 15 22:39:06 6d5380e16498 systemd[1]: Started dnf makecache.
Jul 15 22:42:07 6d5380e16498 root[3693]: Hello World
</pre>

The message you just sent with `logger` is present in _messages_.
