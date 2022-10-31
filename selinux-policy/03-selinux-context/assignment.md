---
slug: selinux-context
id: yu19x3x0dldz
type: challenge
title: SELinux Context
notes:
- type: text
  contents: |
    In this exercise, we will discuss what SELinux Context is.

    SELinux context is the identifier used to define the domain for an object. The object can be a running process, network port, usb device, file, or really anything in the operating system. The context is sometimes called the label, especially when dealing with files. The context is used by the SELinux security server whenever the object is the subject or target of an action in operating system. We use context when we define SELinux policies.

    A context defines 4 attributes of an object; its user, role, type and level information.

    - **user**  - maps a system user login to an SELinux User definition. e.g. unconfined user, super user, etc..
    - **role**  - maps an SELinux domain to an SELinux user
    - **type**  - defines the SELinux type for a file or the SELinux domain for a process, each process has a specific domain. Policy makes use of **type** the most
    - **level** - level is used in multi-level/multi-category security where the segmentation of content and operations is required. The level is defined as a range i.e. lowlevel-highlevel e.g. s0-s3

    Lets look at how we can determine the context of objects, modify it, restore it and propagate it.
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
### Examining Context
Let's examine the content on a file from the tester user's home directory
```bash
ls -Z ~tester/.vimrc
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">unconfined_u:object_r:user_home_t:s0 /home/tester/.vimrc</pre>

As a side note, the -Z flag is present, in a wide variety of common CLI tools, including ls and ps. That flag indicates that SELinux context information should be displayed.

Following the standard linux permissions, user and group information, the SELinux context attached to the file is displayed. In this example we can see the fields are: SELinux user (unconfined_u), role (object_r), type (user_home_t), and level (s0).

The SELinux user is not the same as the UNIX user, as it exists to associate a system user (local or from a centralized identity store) to a set of SELinux roles. This allows system users to managed at scale more easily using SELinux policy. This case shows the default; the unconfined_u user means that the user is mapped to the default SELinux login. The user is allowed to launch any application that standard filesystem permissions allow. If that application has a defined domain transition, then a confined domain will still be applied to the process.

To demonstrate the difference between confined and unconfined processes, let’s launch an application which doesn’t have a defined domain transition.
```bash
yes >/dev/null &
ps -Z | grep yes
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:system_r:unconfined_service_t:s0 149643 pts/0 00:00:00 yes</pre>

You can see that the **yes** process is labeled with the unconfined_service_t domain, indicating that the process is unrestricted. This is due to the way the terminal is launch by the lab. Try using the RHEL web console and log in as tester with a password of tester.

If we launch the passwd utility, we see a different result. Let's stop the yes command and run the passwd command for the local user 'tester'
```
#switch to foreground and end the process with ctrl+c
fg

```

```
passwd tester >/dev/null &
ps -Z | grep passwd
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">unconfined_u:unconfined_r:passwd_t:s0-s0:c0.c1023 29498 pts/0 00:00:00 passwd</pre>

See that the third field is **passwd_t**, indicating that the passwd process has been confined by the **passwd_t domain**.

Let’s stop the running process and move on:
```bash
kill %1
```
### Changing and Restoring context
If I had to suggest to a new administrator the one thing about SELinux that they should remember (and no, it’s not setenforce 0!), it would be **restorecon**. The restorecon command will reset the SELinux context of an object to what is defined in the system’s context database for that object. The context database is where all the SELinux policy is stored. Red Hat Enterprise Linux ships with a preloaded context database that provides SELinux context for all parts of the operating system. SELinux is enabled and enforcing by default, providing us with a very secure system out of the box. We can modify the context of objects when we have root privledge and if necessary restore them to the default.

We can change the context of an object temporarily using the **chcon** command

To try this out, let’s purposefully set the context incorrectly on our example SELinux AVC log file.
```bash
chcon -t httpd_sys_content_t ./testaudit
ls -Z ./testaudit
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:object_r:httpd_sys_content_t:s0 ./testaudit</pre>
Oh, no! What was the context supposed to be? Whew, restorecon saves the day.
```bash
restorecon -v ./testaudit
ls -Z ./testaudit
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Relabeled /root/testaudit from system_u:object_r:httpd_sys_content_t:s0 to system_u:object_r:admin_home_t:s0

-rw-------. root root system_u:object_r:admin_home_t:s0 ./testaudit</pre>

We can see that our testfile access is magically restored.

Bonus marks: Do it again and try to access the auditfile. Are you able to access the file? Why or Why not?

Bonus marks: How would actually correct the violation that we found listed in the test audit file?

You can change SELinux context more permanently by managing the default policy for an object using the **semanage** command. The **semanage fcontext** command sets the context of a file object.

Now that we understand SELinux context let's write a simple policy to manage a custom application. On to the next challenge!

