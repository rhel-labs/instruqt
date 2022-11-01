---
slug: selinux-policy4
id: yukofzc9kynw
type: challenge
title: SELinux Policy 4
notes:
- type: text
  contents: |
    This is our last challenge. Let's wrap our policy.
tabs:
- title: Terminal
  type: terminal
  hostname: selinux1
- title: RHEL Web Console
  type: external
  url: https://selinux1.${_SANDBOX_ID}.instruqt.io:9090
difficulty: intermediate
timelimit: 1
---
### The Last Interface

We are just about done. List the remaining denials. Only 4 or so entries!

```bash
ausearch --message AVC --start recent
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Mon Oct 31 01:17:50 2022
type=PROCTITLE msg=audit(1667179070.329:2758): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667179070.329:2758): arch=c000003e syscall=262 success=yes exit=0 a0=ffffff9c a1=7fe240f7497b a2=7fe2402ba270 a3=0 items=0 ppid=1 pid=156808 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667179070.329:2758): <strong style="color: red">avc:  denied  { getattr }</strong> for  pid=156808 comm="testapp" <strong style="color: red">path="/etc/resolv.conf"</strong> dev="sda2" ino=50340168 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
----
time->Mon Oct 31 01:17:50 2022
type=PROCTITLE msg=audit(1667179070.335:2759): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667179070.335:2759): arch=c000003e syscall=257 success=yes exit=7 a0=ffffff9c a1=7fe240f7497b a2=80000 a3=0 items=0 ppid=1 pid=156808 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667179070.335:2759): <strong style="color: red">avc:  denied  { open }</strong> for  pid=156808 comm="testapp" <strong style="color: red">path="/etc/resolv.conf"</strong> dev="sda2" ino=50340168 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667179070.335:2759): <strong style="color: red">avc:  denied  { read }</strong> for  pid=156808 comm="testapp" <strong style="color: red">name="resolv.conf"</strong> dev="sda2" ino=50340168 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
----
time->Mon Oct 31 01:18:00 2022
type=PROCTITLE msg=audit(1667179080.614:2785): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667179080.614:2785): arch=c000003e syscall=262 success=yes exit=0 a0=ffffff9c a1=7fe240f7497b a2=7fe2402ba270 a3=0 items=0 ppid=1 pid=156808 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667179080.614:2785): <strong style="color: red">avc:  denied  { getattr }</strong> for  pid=156808 comm="testapp" <strong style="color: red">path="/etc/resolv.conf"</strong> dev="sda2" ino=50340168 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
----
time->Mon Oct 31 01:18:00 2022
type=PROCTITLE msg=audit(1667179080.614:2786): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667179080.614:2786): arch=c000003e syscall=257 success=yes exit=7 a0=ffffff9c a1=7fe240f74c5e a2=80000 a3=0 items=0 ppid=1 pid=156808 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667179080.614:2786): <strong style="color: red">avc:  denied  { open }</strong> for  pid=156808 comm="testapp" <strong style="color: red">path="/etc/hosts"</strong> dev="sda2" ino=50343045 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667179080.614:2786): <strong style="color: red">avc:  denied  { read }</strong> for  pid=156808 comm="testapp" <strong style="color: red">name="hosts"</strong> dev="sda2" ino=50343045 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1</pre>

It seems that we can't read /etc/resolv.conf or /etc/hosts. Use your favourite approach on this one, audit2allow or a search.

Do that now.

No peaking.

OK. If you take a look at
- audit2allow -R
- audit2allow -N
- and search for the file
You find that the interface specified by *-R* ends up encapsulating the allow statements specified when using *-N*

Write. Compile. Restart. Test.

Your testapp.te file should look like this.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">policy_module(testapp, 1.0.0)

########################################
#
# Declarations
#

type testapp_t;
type testapp_exec_t;
init_daemon_domain(testapp_t, testapp_exec_t)

permissive testapp_t;

########################################
#
# testapp local policy
#
allow testapp_t self:process { fork };
allow testapp_t self:fifo_file rw_fifo_file_perms;
allow testapp_t self:unix_stream_socket create_stream_socket_perms;
allow testapp_t var_run_t:file { create open write };

allow testapp_t self:tcp_socket { connect create getattr getopt setopt };
allow testapp_t self:udp_socket { connect create getattr setopt };

corenet_tcp_connect_http_port(testapp_t)

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

kernel_read_system_state(testapp_t)

logging_send_syslog_msg(testapp_t)

miscfiles_read_generic_certs(testapp_t)
miscfiles_read_localization(testapp_t)

<strong style="color: red">sysnet_read_config(testapp_t)</strong></pre>

Compile. Restart. Test.

```
sudo ausearch -m AVC --start
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">no matches</pre>

No AVCs!!

The final test! Let's turn on enforcement. Comment out the **permissive testapp_t;** line in declarations of testapp.te, recompile the policy and test.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">sudo ausearch -m AVC --start recent
no matches

# systemctl status testapp
● testapp.service - Testing SELinux app
     Loaded: loaded (/usr/lib/systemd/system/testapp.service; disabled; vendor preset: disabled)
     Active: <strong style="color: green">active (running)</strong> since Mon 2022-10-31 01:37:27 UTC; 7min ago
    Process: 157288 ExecStart=/usr/local/sbin/testapp (code=exited, status=0/SUCCESS)
   Main PID: 157289 (testapp)
      Tasks: 1 (limit: 21954)
     Memory: 3.0M
        CPU: 3.081s
     CGroup: /system.slice/testapp.service
             └─157289 /usr/local/sbin/testapp

Oct 31 01:37:27 selinux1 systemd[1]: Starting Testing SELinux app...
Oct 31 01:37:27 selinux1 testapp[157288]: testapp parent process ended
Oct 31 01:37:27 selinux1 systemd[1]: Started Testing SELinux app.</pre>

We have successfully created an SELinux policy to manage our custom application!

Congratulations!
