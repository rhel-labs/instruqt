---
slug: selinux-policy2
id: yyd2sakxrbbb
type: challenge
title: SELinux Policy 2
notes:
- type: text
  contents: |
    In the previous challenge, we built a policy template, compiled it and saw the test application be transitioned to run in the context assigned by the policy.

    In this challenge, we will examine the AVCs generated when our testapp starts to run under the policy and update the policy to allow it to run without AVCs.

    We will use the **ausearch** command to find the AVCs in the audit log. We will interpret these events in turn and then find the appropriate *allow statement* or SELinux *policy interface* to permit the action. We will update our policy file to add the allow statements and interfaces, recompile the policy and test our application. This is the iterative process that we will follow for the remainder of the workshop. We will discover a variety of methods to understand and interpret the violations and modify our policy

    Let's start by finding the AVCs. Time for the next challenge.
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
### Check for the AVC denials

Our service app is up and running, but in the policy is hard coded to make it run in Permissive mode. The system does not stop it from accessing any requested objects, but it logs all the SELinux violations in /var/log/audit/audit.log

To start building our policy we will look in the audit log for messages of type AVC that happened today. We use the **ausearch** command.

```bash
sudo ausearch --message AVC --start today
```

Wow! There are quite a few denials!

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.686:2321): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667167638.686:2321): item=3 name=(null) inode=1510 dev=00:19 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=2 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=1 name=(null) nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=0 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667167638.686:2321): cwd="/"
type=SYSCALL msg=audit(1667167638.686:2321): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=101b750 a2=241 a3=1b6 items=4 ppid=1 pid=149921 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
...
A long, long list...
</pre>

Let's just focus in in the first AVC message. We can use the filter from the ausearch command to retrieve just one entry, the first one, for the timeframe. The ausearch command takes a time (hh:mm:ss), or reference (today | recent) for the *--start* argument.

```bash
ausearch --message AVC --just-one --start recent
```

> **IMPORTANT** Remember that recent means in the last 10 minutes and today means after 00:00:00 on the system clock. You will find it useful, especially if you are a fast typer, to use *'date +%T'* to print a time to the screen **right after** you restart the testapp and substitute that in your **ausearch --start** command so that you are only looking at logs generated since the last policy compile. **--just-one** returns the first AVC that occurs after the time specified by start.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Tue Nov  1 03:36:46 2022
type=PROCTITLE msg=audit(1667273806.737:3034): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667273806.737:3034): item=3 name=(null) inode=2082 dev=00:19 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667273806.737:3034): item=2 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667273806.737:3034): item=1 name=(null) nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667273806.737:3034): item=0 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667273806.737:3034): cwd="/"
type=SYSCALL msg=audit(1667273806.737:3034): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=a76750 a2=241 a3=1b6 items=4 ppid=1 pid=153704 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667273806.737:3034): <strong style="color: red">avc:  denied  { write open }</strong> for  pid=153704 comm="testapp" <strong style="color: red">path="/run/testapp.pid"</strong> dev="tmpfs" ino=2082 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667273806.737:3034): <strong style="color: red">avc:  denied  { create }</strong> for  pid=153704 comm="testapp" <strong style="color: red">name="testapp.pid"</strong> scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667273806.737:3034): <strong style="color: red">avc:  denied  { add_name }</strong> for  pid=153704 comm="testapp" <strong style="color: red">name="testapp.pid"</strong> scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1
type=AVC msg=audit(1667273806.737:3034): <strong style="color: red">avc:  denied  { write }</strong> for  pid=153704 comm="testapp" <strong style="color: red">name="/" dev="tmpfs"</strong> ino=1 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1</pre>

We see that testapp was denied "write  open", "create", and "add_name" on "/run/testapp.pid". So our system is secure enough that our basic policy is not even allowing the application to make a pid file on the tmpfs. That's pretty secure, however, it seems reasonable that we should allow this. Our app should be able to create a pid file and other temp files as necessary.

How do we specify this?

Our policy interacts with the SELinux system through a series of interfaces and allow statements. For interfaces, we pass our context type information to the interface and a macro in the security server implements a series of rules to allow a particular behaviour. This makes creating policy easier. Allow statements can be more specific, basically stating:

*allow **domainX** to perform **actionY** in **contextZ***

or something similar.

There is a command called **audit2allow** and an alias **audit2why** (== audit2allow -w) that can give us information about why an AVC occured. It is also able to suggest policy changes we might make to allow the behaviour identified by the AVC denial. Let's take a look at the output of audit2allow for our first AVC. Adding the *-R* switch asks the program to return suggestions for the policy change that makes use of the currently installed interface macros.

> IMPORTANT: This utility does a best fit analysis. The macros that are referenced may be a less restrictive than you require. Using the -N or using no switches will produce traditional allow statements only. See the audit2allow manpage

```bash
ausearch --message AVC --start recent --just-one | audit2allow -R
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
require {
        type var_run_t;
        type testapp_t;
        class file { create open write };
}

#============= testapp_t ==============
<strong style="color: red">allow testapp_t var_run_t:file { create open write };
files_rw_pid_dirs(testapp_t)</strong></pre>

**Where to find interface information**

The interface definitions that we need to find are provided as part of the *selinux-policy-devel* package. This should be installed on your system already. The files for the definitions are stored in */usr/share/selinux/devel/include*. Like our own policy interfaces, they are stored in files with the *\*.if* extention. We need to find the interfaces that allow manipulating pid files. The command audit2allow *-R* looks at the interfaces that have been built from these files to find matches. We can also search through the files ourselves to find interfaces that we want to add to our policy. For now let's use the recommendation from audit2allow and modify the testapp.te file. Open the policy with the vim editor.

```bash
vim /root/selinuxlab/policy/testapp.te
```

It should look like the following.

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

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)

logging_send_syslog_msg(testapp_t)

miscfiles_read_localization(testapp_t)</pre>

Add our recommendations to the end of the policy file under the testapp local policy section

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
allow testapp_t var_run_t:file { create open write };
files_rw_pid_dirs(testapp_t)</pre>

Save the file (use :wq!).

Traditionally, for readability and searching, we try to add the elements in alphabetical order. The resulting file should look like this.

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
<strong style="color: red">allow testapp_t var_run_t:file { create open write };</strong>

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
<strong style="color: red">files_rw_pid_dirs(testapp_t)</strong>

logging_send_syslog_msg(testapp_t)

miscfiles_read_localization(testapp_t)</pre>

OK. Ensure your file is saved and run the testapp.sh script again.

```bash
./testapp.sh
```

You should see the successful compilation of your policy. I truncated the output.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Building and Loading Policy
+ make -f /usr/share/selinux/devel/Makefile testapp.pp
Compiling targeted testapp module
...
...
Wrote: /root/selinuxlab/policy/testapp_selinux-1.0-1.el9.src.rpm
Wrote: /root/selinuxlab/policy/noarch/testapp_selinux-1.0-1.el9.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.Xm82Fg
+ umask 022
+ cd /root/selinuxlab/policy
+ /usr/bin/rm -rf /root/selinuxlab/policy/.build/testapp_selinux-1.0-1.el9.x86_64
+ RPM_EC=0
++ jobs -p
+ exit 0</pre>

Run **date +%T** just before testing to get a convenient place to search the audit.log file from. Now, restart the testapp service. And the moment of truth, check to see if the AVC is still there. **Copy and paste the time generated by *date* after the last command**.

```bash
date +%T
```

```bash
systemctl restart testapp
```

```bash
ausearch --message AVC --just-one --start
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 23:09:27 2022
type=PROCTITLE msg=audit(1667171367.011:2423): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667171367.011:2423): arch=c000003e syscall=257 success=yes exit=4 a0=ffffff9c a1=4033f3 a2=0 a3=0 items=0 ppid=1 pid=152896 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667171367.011:2423): <strong style="color: red">avc:  denied  { open }</strong> for  pid=152896 comm="testapp" <strong style="color: red">path="/proc/meminfo"</strong> dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667171367.011:2423): <strong style="color: red">avc:  denied  { read }</strong> for  pid=152896 comm="testapp" <strong style="color: red">name="meminfo"</strong> dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1</pre>

Excellent! The previous AVC is gone!

We still have more though. Let's dig into the interface files to find the answer to this next one.

If we look at the AVC, we can see that the testapp process is being denied open and read on /proc/meminfo. We need to allow our application to look at system state information in /proc. Let's use find to look for interface definition files that contain /proc and something about 'system state information'.

```bash
cd /usr/share/selinux/devel/include
find . -type f -name "*.if" -exec grep -H '/proc' {} \; | grep "system state information"
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">./kernel/kernel.if:##   <strong style="color: red">Allows caller to read system state information in /proc.</strong></pre>

Wow, lucky guess ;-)

Lets look in the file and find the "system state information" comment. You can use the *less* command and then */ read system state information*. We find this interface definition.

```bash
less /usr/share/selinux/devel/include/kernel/kernel.if
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">interface(`kernel_read_system_state',`
        gen_require(`
                attribute kernel_system_state_reader;
        ')

        typeattribute $1 kernel_system_state_reader;
')</pre>

The interface defined at the bottom of the file is called **kernel_read_system_state** and it takes one required parameter that is the context of the process that we want to be a *kernel_system_state_reader*. That means we pass **testapp_t** to the interface. Edit the testapp.te file with vim and add a line in alphabetical order that calls **kernel_read_system_state(testapp_t)**

When you are done, the end of the file should look like this.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

<strong style="color: red">kernel_read_system_state(testapp_t)</strong>

logging_send_syslog_msg(testapp_t)

miscfiles_read_localization(testapp_t)</pre>

OK. Ensure your file is saved and run the testapp.sh script again. Run **date +%T** again to get a new time. Now, restart the testapp service. And the moment of truth, check to see if the AVC is still there.
```bash
date +%T
```

```bash
systemctl restart testapp
```

```bash
ausearch --message AVC --start <time_from_above> | grep meminfo | wc -l
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>
Zero is good.

2 AVCs down and a few more to go. Let's look at some network AVCs next. On to the next challenge!
