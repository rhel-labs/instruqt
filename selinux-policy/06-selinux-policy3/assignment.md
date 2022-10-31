---
slug: selinux-policy3
id: ihdrrzswugyk
type: challenge
title: SELinux Policy 3
notes:
- type: text
  contents: |
    In this exercise, we will continue examining the AVCs generated when running our testapp. This time we will be looking at network related AVCs and how we remdiate our policy to allow appropriate access. You will use ausearch again to find the AVCs in the audit log, following a similar process to the last challenge.

    Remember, everything in the operating system is an object and has a label or context. This includes network ports. Similar interfaces exist for handling passing our context to the kernel for network access.

    Let's look at the next AVC. A new challenge!
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
### Checking for Network AVC denials.

Let's get next AVC that happened since our most recent restart.

```bash
ausearch --message AVC --just-one --start <your_time_here>
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 23:36:54 2022
type=PROCTITLE msg=audit(1667173014.581:2465): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667173014.581:2465): item=0 name="/etc/pki/tls/openssl.cnf" inode=16781603 dev=08:02 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:cert_t:s0 nametype=NORMAL cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667173014.581:2465): cwd="/"
type=SYSCALL msg=audit(1667173014.581:2465): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=4fe750 a2=0 a3=0 items=1 ppid=1 pid=154136 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667173014.581:2465): avc:  denied  { open } for  pid=154136 comm="testapp" path="/etc/pki/tls/openssl.cnf" dev="sda2" ino=16781603 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667173014.581:2465): avc:  denied  { read } for  pid=154136 comm="testapp" name="openssl.cnf" dev="sda2" ino=16781603 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667173014.581:2465): avc:  denied  { search } for  pid=154136 comm="testapp" name="pki" dev="sda2" ino=33576258 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=dir permissive=1</pre>


It seems that our application is trying to read ssl certificates and is being denied access them. Let's take a look at the interfaces

```
find /usr/share/selinux/devel/include -type f -name "*.if" -exec grep -iH 'ssl certificate' {} \; | grep -i read
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">/usr/share/selinux/devel/include/system/miscfiles.if:## Read all SSL certificates.
/usr/share/selinux/devel/include/system/miscfiles.if:## Read all SSL certificates.
/usr/share/selinux/devel/include/system/miscfiles.if:## Read generic SSL certificates.
/usr/share/selinux/devel/include/system/miscfiles.if:## Read SSL certificates.
/usr/share/selinux/devel/include/system/userdomain.if:##        Read system SSL certificates in the users homedir.</pre>

So look let's look in the miscelleaneous files interfaces for the interface that reads generic SSL certs. Again we will use find, grep, less and a search to find the interface. When we do, we see the interface definition below.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">########################################
## <summary>
##      Read generic SSL certificates.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
## <rolecap/>
#
interface(`miscfiles_read_generic_certs',`
        gen_require(`
                type cert_t;
        ')

        allow $1 cert_t:dir list_dir_perms;
        read_files_pattern($1, cert_t, cert_t)
        read_lnk_files_pattern($1, cert_t, cert_t)
')</pre>

The interface we need is **miscfiles_read_generic_certs**, again passing our testapp_t context as the parameter. We can see that this inferface is performing a number of additional calls for us to allow us to get the job done. Let's add it to our testapp.te file, recompile and test. Your testapp.te file should look like this.
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
allow testapp_t var_run_t:file { create open write };  # added in challenge selinux-policy2

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)   # added in challenge selinux-policy2

kernel_read_system_state(testapp_t) # added in challenge selinux-policy2

logging_send_syslog_msg(testapp_t)

miscfiles_read_generic_certs(testapp_t) # added in challenge selinux-policy3
miscfiles_read_localization(testapp_t)</pre>

> ASIDE: miscfiles_read_generic_certs() replaces miscfiles_read_certs(). When you run audit2allow -R it recommends miscfiles_read_certs(). When you compile the template, the sepolicy compiler throws a warning letting you know that you should use miscfiles_read_generic_certs().

You should have this down by now. Run testapp.sh, get a time, search the audit.log for a relevant search term like *openssl* or *pki*. Make sure that there are no more coming up.
```
ausearch --message AVC --start <your_time_here> | grep openssl | wc -l
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

```
ausearch --message AVC --start <your_time_here> | grep openssl | wc -l
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

Another one down. Next!

If we take a look at the output from the following, we see lots of AVCs with getattr, getopt, create, connect, etc.. on tcp/udp sockets and ports. Since our testapp is trying to pull data from a website, that seems logical and critical for the application to function. Let's dig in a little. If you were to examine testapp.c you would discover that we are pulling from the https version of the site. So let's see if there is an AVC for port 443 and what audit2allow suggests.
```
ausearch --message AVC --start recent | grep 'dest=443'
ausearch --message AVC --start recent | grep 'dest=443' | audit2allow
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
type=AVC msg=audit(1667178101.046:2578): avc:  denied  { name_connect } for  pid=156063 comm="testapp" dest=443 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:http_port_t:s0 tclass=tcp_socket permissive=1


require {
        type testapp_t;
}

#============= testapp_t ==============
corenet_tcp_connect_http_port(testapp_t)</pre>

OK, we can add that to our policy file. What about the tcp / udp sockets

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">sudo ausearch -m AVC -ts recent | egrep 'tcp|udp' | audit2allow -R

require {
        type testapp_t;
        class udp_socket { connect create getattr setopt };
        class tcp_socket { connect create getattr getopt setopt };
}

#============= testapp_t ==============
allow testapp_t self:tcp_socket { connect create getattr getopt setopt };
allow testapp_t self:udp_socket { connect create getattr setopt };
corenet_tcp_connect_http_port(testapp_t)</pre>

The search brings up the same recommendation, plus some specific allow statements. Let's add the three lines to our testapp.te file. When you are done editing. The file should look something like the following.

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
allow testapp_t var_run_t:file { create open write };  # added in challenge selinux-policy2

allow testapp_t self:tcp_socket { connect create getattr getopt setopt }; # added this line now
allow testapp_t self:udp_socket { connect create getattr setopt };        # added this line now

corenet_tcp_connect_http_port(testapp_t)   # added this line now

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)   # added in challenge selinux-policy2

kernel_read_system_state(testapp_t) # added in challenge selinux-policy2

logging_send_syslog_msg(testapp_t)

miscfiles_read_generic_certs(testapp_t) # added in challenge selinux-policy3
miscfiles_read_localization(testapp_t)
</pre>

OK. Save your file and run the testapp.sh script again. **Restart** the testapp service. And check your results.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">sudo ausearch -m AVC --start 01:15:54 | egrep 'tcp|udp' | wc -l
0
sudo ausearch -m AVC -ts 01:15:54 | grep 'dest=443' | wc -l
0</pre>

OK. Let's go to the last challenge and finish up the policy.
