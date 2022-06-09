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
tail /var/log/audit/audit.log
```

<pre class=file>
type=SERVICE_STOP msg=audit(1654785357.108:201): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=user@0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'UID="root" AUID="unset"
type=SERVICE_STOP msg=audit(1654785357.127:202): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=user-runtime-dir@0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'UID="root" AUID="unset"
type=ADD_GROUP msg=audit(1654785383.760:203): pid=1576 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:unconfined_service_t:s0 msg='op=add-group acct="google-sudoers" exe="/usr/sbin/groupadd" hostname=? addr=? terminal=? res=failed'UID="root" AUID="unset"
type=ADD_GROUP msg=audit(1654785443.806:204): pid=1587 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:unconfined_service_t:s0 msg='op=add-group acct="google-sudoers" exe="/usr/sbin/groupadd" hostname=? addr=? terminal=? res=failed'UID="root" AUID="unset"
type=ADD_GROUP msg=audit(1654785503.853:205): pid=1591 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:unconfined_service_t:s0 msg='op=add-group acct="google-sudoers" exe="/usr/sbin/groupadd" hostname=? addr=? terminal=? res=failed'UID="root" AUID="unset"
</pre>

If you wish to then see the entire file, a text viewer like `less` or `view`
will show the entire file.

Adding the `-f` option will follow the log file so that you can see new entries.

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
