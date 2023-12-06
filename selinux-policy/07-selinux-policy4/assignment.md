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

We are just about done. List the remaining denials. Only 2 entries!

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sudo ausearch -m AVC -ts $TIME
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Tue Jul 18 17:35:31 2023
type=PROCTITLE msg=audit(1689701731.851:5322): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1689701731.851:5322): arch=c000003e syscall=262 success=yes exit=0 a0=ffffff9c a1=7f87d2af7ace a2=7f87d1e3e270 a3=0 items=0 ppid=1 pid=91158 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1689701731.851:5322): <strong style="color: red">avc:  denied  { getattr }</strong> for  pid=91158 comm="testapp" <strong style="color: red">path="/etc/resolv.conf"</strong> dev="sda2" ino=50340715 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
----
time->Tue Jul 18 17:35:31 2023
type=PROCTITLE msg=audit(1689701731.853:5323): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1689701731.853:5323): arch=c000003e syscall=257 success=yes exit=7 a0=ffffff9c a1=7f87d2af7ace a2=80000 a3=0 items=0 ppid=1 pid=91158 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1689701731.853:5323): avc:  <strong style="color: red">denied  { open }</strong> for  pid=91158 comm="testapp" <strong style="color: red">path="/etc/resolv.conf"</strong> dev="sda2" ino=50340715 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1
type=AVC msg=audit(1689701731.853:5323): <strong style="color: red">avc:  denied  { read }</strong> for  pid=91158 comm="testapp" <strong style="color: red">name="resolv.conf"</strong> dev="sda2" ino=50340715 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:net_conf_t:s0 tclass=file permissive=1</pre>

It seems that we can't get access to /etc/resolv.conf. Use your favourite approach on this one, audit2allow or a search.

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

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sleep 60; sudo ausearch -m AVC -ts $TIME
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">no matches</pre>

No AVCs!!

The final test! Let's turn on enforcement. Comment out the **permissive testapp_t;** line in declarations of testapp.te, recompile the policy and test.

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sleep 60; sudo ausearch -m AVC -ts $TIME
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
no matches

# systemctl status testapp
● testapp.service - Testing SELinux app
     Loaded: loaded (/usr/lib/systemd/system/testapp.service; disabled; preset: disabled)
     Active: <strong style="color: green">active (running)</strong> since Tue 2023-07-18 17:45:19 UTC; 1min 9s ago
    Process: 91790 ExecStart=/usr/local/sbin/testapp (code=exited, status=0/SUCCESS)
   Main PID: 91791 (testapp)
      Tasks: 1 (limit: 23116)
     Memory: 1.2M
        CPU: 12ms
     CGroup: /system.slice/testapp.service
             └─91791 /usr/local/sbin/testapp

Jul 18 17:45:19 selinux1 systemd[1]: Starting Testing SELinux app...
Jul 18 17:45:19 selinux1 testapp[91790]: testapp parent process ended
Jul 18 17:45:19 selinux1 systemd[1]: Started Testing SELinux app.</pre>

We have successfully created an SELinux policy to manage our custom application!

Congratulations!
