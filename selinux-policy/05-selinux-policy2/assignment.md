---
slug: selinux-policy2
id: yyd2sakxrbbb
type: challenge
title: SELinux Policy 2
notes:
- type: text
  contents: |
    In this exercise, we will examine the AVCs generated when running our testapp under a simple SELinux policy to confine the application. We will use the information gathered from the AVCs to extend the policy to allow the actions that are generating the denials.

    You will use ausearch to find the AVCs in the audit log. We will interpret these events and then find the appropriate SELinux policy interface to pass our context to allow the action. We will then recompile the policy and test. This is an iterative process.

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
Our service app is up and running, but in Permissive mode. The system allows it to run and logs all the SELinux violations in /var/log/audit/audit.log
We are looking for messages of type AVC that happened today
```bash
sudo ausearch --message AVC --start today
```
There are quite a few denials!
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.686:2321): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667167638.686:2321): item=3 name=(null) inode=1510 dev=00:19 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=2 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=1 name=(null) nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=0 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667167638.686:2321): cwd="/"
type=SYSCALL msg=audit(1667167638.686:2321): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=101b750 a2=241 a3=1b6 items=4 ppid=1 pid=149921 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { write open } for  pid=149921 comm="testapp" path="/run/testapp.pid" dev="tmpfs" ino=1510 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { create } for  pid=149921 comm="testapp" name="testapp.pid" scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { add_name } for  pid=149921 comm="testapp" name="testapp.pid" scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { write } for  pid=149921 comm="testapp" name="/" dev="tmpfs" ino=1 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1
----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.692:2322): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667167638.692:2322): arch=c000003e syscall=257 success=yes exit=4 a0=ffffff9c a1=4033f3 a2=0 a3=0 items=0 ppid=1 pid=149921 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667167638.692:2322): avc:  denied  { open } for  pid=149921 comm="testapp" path="/proc/meminfo" dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.692:2322): avc:  denied  { read } for  pid=149921 comm="testapp" name="meminfo" dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1
----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.696:2323): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667167638.696:2323): item=0 name="/etc/pki/tls/openssl.cnf" inode=16781603 dev=08:02 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:cert_t:s0 nametype=NORMAL cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667167638.696:2323): cwd="/"
type=SYSCALL msg=audit(1667167638.696:2323): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=101b750 a2=0 a3=0 items=1 ppid=1 pid=149922 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667167638.696:2323): avc:  denied  { open } for  pid=149922 comm="testapp" path="/etc/pki/tls/openssl.cnf" dev="sda2" ino=16781603 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.696:2323): avc:  denied  { read } for  pid=149922 comm="testapp" name="openssl.cnf" dev="sda2" ino=16781603 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.696:2323): avc:  denied  { search } for  pid=149922 comm="testapp" name="pki" dev="sda2" ino=33576258 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=dir permissive=1
----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.697:2324): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667167638.697:2324): arch=c000003e syscall=262 success=yes exit=0 a0=3 a1=7f5c60394f15 a2=7ffe083b6520 a3=1000 items=0 ppid=1 pid=149922 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667167638.697:2324): avc:  denied  { getattr } for  pid=149922 comm="testapp" path="/etc/pki/tls/openssl.cnf" dev="sda2" ino=16781603 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:cert_t:s0 tclass=file permissive=1
...
...</pre>

Let's focus in in the first AVC message. We can use the filter from the ausearch command to retrieve just one entry, the first one, for the timeframe.
```bash
 ausearch --message AVC --start recent --just-one
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 22:07:18 2022
type=PROCTITLE msg=audit(1667167638.686:2321): proctitle="/usr/local/sbin/testapp"
type=PATH msg=audit(1667167638.686:2321): item=3 name=(null) inode=1510 dev=00:19 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=2 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=1 name=(null) nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=PATH msg=audit(1667167638.686:2321): item=0 name=(null) inode=1 dev=00:19 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:var_run_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
type=CWD msg=audit(1667167638.686:2321): cwd="/"
type=SYSCALL msg=audit(1667167638.686:2321): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=101b750 a2=241 a3=1b6 items=4 ppid=1 pid=149921 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { write open } for  pid=149921 comm="testapp" path="/run/testapp.pid" dev="tmpfs" ino=1510 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { create } for  pid=149921 comm="testapp" name="testapp.pid" scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { add_name } for  pid=149921 comm="testapp" name="testapp.pid" scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1
type=AVC msg=audit(1667167638.686:2321): avc:  denied  { write } for  pid=149921 comm="testapp" name="/" dev="tmpfs" ino=1 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=1</pre>

We see that testapp was denied "write open", "create", and "add_name" on "/run/testapp.pid". So our system is secure enough that our basic policy is not even allowing the application to make a pid file on the tmpfs. That's pretty secure, however, it seems reasonable that we should allow this our app to create a pid file and other temp files as necessary. How can we do this though? Our policy interacts with the SELinux system through a series of interfaces and allow statements. For interfaces, we pass our context type information to the interface and a macro in the security server implements a series of rules to allow a particular behaviour. This makes creating policy easier. Allow statements can be more specific, basically stating *allow this domain to perform this action in this context* or similar.

There is a utility called audit2allow and an alias audit2why (== audit2allow -w) that can give us information about why an AVC occured and what we policy change we might make to allow the behaviour that was restricted by the AVC denial. Let's take a look at audit2allow for our first AVC. Adding the *-R* switch asks the program to return suggestions for the policy change that makes use of the currently installed interface macros.

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
allow testapp_t var_run_t:file { create open write };
files_rw_pid_dirs(testapp_t)</pre>

**Some of the basics**
The interface definitions that we need to find are provided as part of the *selinux-policy-devel* package. This should be installed on your system already. The files for the definitions are stored in */usr/share/selinux/devel/include*. Like our own policy interfaces, they are stored in files with the extention *\*.if*. We need to find the interfaces that allow pid files. The audit2allow application looks at the interfaces that have been built from these files to find matches with using *-R*. We can also search through them ourselves to find interfaces that we want to add to our policy. For now let's use the recommendation from audit2allow. We will modify the testapp.te file. Open the file with the vim editor.
```bash
vim /root/selinuxlab/policy/testapp.te
```
 It should look like the following.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;"></pre>

Add our recommendations to the end of the policy file under the testapp local policy section
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">#============= testapp_t ==============
allow testapp_t var_run_t:file { create open write };
files_rw_pid_dirs(testapp_t)</pre>

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
allow testapp_t var_run_t:file { create open write };

domain_use_interactive_fds(testapp_t)

files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

logging_send_syslog_msg(testapp_t)

miscfiles_read_localization(testapp_t)</pre>

OK. Ensure your file is saved and run the testapp.sh script again.

```bash
./testapp.sh
```
I trucated the output. You should see the successful compilation of your policy.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Building and Loading Policy
+ make -f /usr/share/selinux/devel/Makefile testapp.pp
Compiling targeted testapp module
Creating targeted testapp.pp policy package
rm tmp/testapp.mod tmp/testapp.mod.fc
+ /usr/sbin/semodule -i testapp.pp
...
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

Run **date +%T** just before testing to get a convenient place to search the audit.log file from. Now, restart the testapp service. And the moment of truth, check to see if the AVC is still there.
```bash
date +%T
```
```bash
systemctl restart testapp
```
```
ausearch --message AVC --just-one --start 23:09:13
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">----
time->Sun Oct 30 23:09:27 2022
type=PROCTITLE msg=audit(1667171367.011:2423): proctitle="/usr/local/sbin/testapp"
type=SYSCALL msg=audit(1667171367.011:2423): arch=c000003e syscall=257 success=yes exit=4 a0=ffffff9c a1=4033f3 a2=0 a3=0 items=0 ppid=1 pid=152896 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="testapp" exe="/usr/local/sbin/testapp" subj=system_u:system_r:testapp_t:s0 key=(null)
type=AVC msg=audit(1667171367.011:2423): avc:  denied  { open } for  pid=152896 comm="testapp" path="/proc/meminfo" dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1
type=AVC msg=audit(1667171367.011:2423): avc:  denied  { read } for  pid=152896 comm="testapp" name="meminfo" dev="proc" ino=4026532024 scontext=system_u:system_r:testapp_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=file permissive=1</pre>

Excellent! The previous AVC is gone! We still have more though. Let's take a look for this one in the files themselves.

If we look at the AVC, we can see that the testapp process is being denied open on /proc/meminfo, and read on the /proc directory. We need to allow our application to look at system state information in /proc. Let's take a look to see what we can find.

```bash
cd /usr/share/selinux/devel/include
find . -type f -name "*.if" -exec grep -H '/proc' {} \; | grep "system state information"
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">./kernel/kernel.if:##   Allows caller to read system state information in /proc.</pre>

This file looks like what we want. Lets look in the file and find the "system state information" comment. You can use the *less* command and then */ read system state information*. We find this interface definition.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
########################################
## <summary>
##      Allows caller to read system state information in /proc.
## </summary>
## <desc>
##      <p>
##      Allow the specified domain to read general system
##      state information from the proc filesystem (/proc).
##      </p>
##      <p>
##      Generally it should be safe to allow this access.  Some
##      example files that can be read based on this interface:
##      </p>
##      <ul>
##              <li>/proc/cpuinfo</li>
##              <li>/proc/meminfo</li>
##              <li>/proc/uptime</li>
##      </ul>
##      <p>
##      This does not allow access to sysctl entries (/proc/sys/*)
##      nor process state information (/proc/pid).
##      </p>
## </desc>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
## <infoflow type="read" weight="10"/>
## <rolecap/>
#
interface(`kernel_read_system_state',`
        gen_require(`
                attribute kernel_system_state_reader;
        ')

        typeattribute $1 kernel_system_state_reader;
')</pre>

After interface we see **kernel_read_system_state** and it takes one parameter and that is the context of the process that we want to be a kernel_system_state_reader. That is we pass **testapp_t** to the interface. Edit the testapp.te file with vim and add a line in alphabetical order that calls **kernel_read_system_state(testapp_t)**

The end of the file should look like this.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">files_read_etc_files(testapp_t)
files_rw_pid_dirs(testapp_t)

kernel_read_system_state(testapp_t)

logging_send_syslog_msg(testapp_t)

miscfiles_read_localization(testapp_t)</pre>

OK. Ensure your file is saved and run the testapp.sh script again. Run **date +%T** again to get a new time. Now, restart the testapp service. And the moment of truth, check to see if the AVC is still there.
```bash
date +%T
```
```bash
systemctl restart testapp
```
```
ausearch --message AVC --start 23:36:12 | grep meminfo | wc -l
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">0</pre>
Zero is good.

2 AVCs down and a few more to go. Let's look at some network AVCs next. On to the next challenge!
