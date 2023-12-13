---
slug: selinux-policy3
id: ihdrrzswugyk
type: challenge
title: SELinux Policy 3
notes:
- type: text
  contents: |
    In the previous challenge, we learned how to find and interpret AVCs and find the interfaces to resolve those AVCs

    In this challenge, we will continue examining the AVCs generated when running our testapp. This time we will be looking at network related AVCs and how we remdiate our policy to allow appropriate access. You will use ausearch again to find the AVCs in the audit log, following a similar process to the last challenge.

    Find. Interpret. Write. Compile. Restart. Test.

    Remember, everything in the operating system is an object and has a label and context. This includes network ports. Similar interfaces exist for passing our context to the kernel to allow network access.

    Let's look at the next AVC. Start your challenge!
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

Let's find the next AVC that happened since our most recent restart. If you need to, restart the service again to get a good starting point.

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sudo ausearch --message AVC --just-one --start $TIME;
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Tue Jul 18 17:09:28 2023
type=PROCTITLE msg=audit(1689700168.540:4680): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1689700168.540:4680): item=0 name="/etc/pki/tls/openssl.cnf" inode=16781603 dev=08:02 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:cert_t:s0 nametype=NORMAL cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1689700168.540:4680): cwd="/"
type=SYSCALL msg=audit(1689700168.540:4680): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=992750 a2=0 a3=0 items=1 ppid=1 pid=89864 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1689700168.540:4680): <strong style="color: red">avc:  denied  { search }</strong> for  pid=89864 comm="testapp" <strong style="color: red">name="pki"</strong> dev="sda2" ino=33576258 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=dir permissive=1
</pre>

It seems that our application is trying to access ssl certificates and is being denied access them. Let's take a look at the interfaces. Again we will use find, grep, less and a search to find the interface.

```bash
find /usr/share/selinux/devel/include -type f -name "*.if" -exec grep -iH 'ssl certificate' {} \; | grep -i read
```

This turns up several files. We are looking at a home directory, so that rules one out. We don't need to look at *all* SSL certificates. Hmmm..

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">/usr/share/selinux/devel/include/system/miscfiles.if:## Read all SSL certificates.
/usr/share/selinux/devel/include/system/miscfiles.if:## Read all SSL certificates.
/usr/share/selinux/devel/include/system/miscfiles.if:## <strong style="color: red">Read generic SSL certificates</strong>.
/usr/share/selinux/devel/include/system/miscfiles.if:## Read SSL certificates.
/usr/share/selinux/devel/include/system/userdomain.if:##        Read system SSL certificates in the users homedir.</pre>


So look let's look in the miscfiles files for the interface that reads generic SSL certs.
When we do, using *less* and a search, we see the interface definition below.

```bash
less /usr/share/selinux/devel/include/system/miscfiles.if
```
Now search for "Read generic" within the file by typing:

```bash
/Read generic
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">interface(`miscfiles_read_generic_certs',`
        gen_require(`
                type cert_t;
        ')

        allow $1 cert_t:dir list_dir_perms;
        read_files_pattern($1, cert_t, cert_t)
        read_lnk_files_pattern($1, cert_t, cert_t)
')</pre>

The interface we need is **miscfiles_read_generic_certs**. We can see that this macro has an allow statement and additional calls that allow the process to access the appropriate files. Let's add it to our testapp.te file. As in the previous examples, pass testapp_t as the parameter in the interface call.

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

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

kernel_read_system_state(testapp_t)

logging_send_syslog_msg(testapp_t)

<strong style="color: red">miscfiles_read_generic_certs(testapp_t)</strong>
miscfiles_read_localization(testapp_t)</pre>

> ASIDE: miscfiles_read_generic_certs() replaces miscfiles_read_certs(). When you run audit2allow -R it recommends miscfiles_read_certs(). When you compile the template, the sepolicy compiler throws a warning letting you know that you should use miscfiles_read_generic_certs().

Run testapp.sh, get a time, search the audit.log for a relevant search term like *openssl* or *pki*. Make sure that there are no more coming up.

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; ausearch --message AVC --start $TIME | grep openssl | wc -l
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; ausearch --message AVC --start $TIME | grep pki | wc -l
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

Another one down. Next!

If we take a look at the output from the beginning of our last run, we see lots of AVCs with getattr, getopt, create, connect, etc.. on tcp/udp sockets and ports. Since our testapp is trying to pull data from a website, that seems logical and critical for the application to function. Let's dig in a little. If you were to examine testapp.c you would discover that we are pulling from the https version of the site.

So let's see if there is an AVC for port 443 and what audit2allow suggests.

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sleep 15; ausearch --message AVC --start $TIME | grep 'dest=443' | audit2allow -R
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----

require {
        type testapp_t;
}

#============= testapp_t ==============
<strong style="color: red">corenet_tcp_connect_http_port(testapp_t)</strong></pre>

OK, we can add that to our policy file. What about the tcp / udp sockets

```bash
sudo ausearch -m AVC -ts $TIME | egrep 'tcp|udp' | audit2allow -R
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">require {
        type testapp_t;
        class tcp_socket { connect create getattr getopt setopt };
}

#============= testapp_t ==============
<strong style="color: red">allow testapp_t self:tcp_socket { connect create getattr getopt setopt };</strong>
<strong style="color: red">allow testapp_t self:udp_socket { connect create getattr getopt setopt };</strong>
<strong style="color: green">corenet_tcp_connect_http_port(testapp_t)</strong></pre>

The search brings up the same recommendation, plus some specific allow statements. Let's add the lines to our testapp.te file. When you are done editing. The file should look something like the following.

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

<strong style="color: red">allow testapp_t self:tcp_socket { connect create getattr getopt setopt }; </strong>
<strong style="color: red">allow testapp_t self:udp_socket { connect create getattr getopt setopt }; </strong>

<strong style="color: red">corenet_tcp_connect_http_port(testapp_t)</strong>

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

kernel_read_system_state(testapp_t)

logging_send_syslog_msg(testapp_t)

miscfiles_read_generic_certs(testapp_t)
miscfiles_read_localization(testapp_t)
</pre>

OK. Save your file and run the testapp.sh script again. **Restart** the testapp service. And check your results.

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sleep 15; sudo ausearch -m AVC -ts $TIME | egrep 'tcp|udp' | wc -l
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

```bash
TIME=`date +%T`;export TIME; sudo systemctl restart testapp; sleep 15; sudo ausearch -m AVC -ts $TIME | grep 'dest=443' | wc -l
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>

OK. Let's go to the last challenge and finish up the policy.
