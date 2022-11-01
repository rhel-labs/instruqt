---
slug: selinux-context
id: yu19x3x0dldz
type: challenge
title: SELinux Context
notes:
- type: text
  contents: |
    In the previous challenge, we learned how to find AVC denials in the logs and some of the information logged by SELinux when a violation occurs.

    In this challenge, we will discuss SELinux context. SELinux policy is built on context information.

    The term *context* is overloaded when we discuss SELinux. It describes a label or identifier **and** defines the runtime security domain for an object. The *object* can be a running process, network port, usb device, file, or really anything in the operating system. All objects in the operating system are labelled with a context. The context is used by the SELinux security server whenever the object is the *subject* or *target* of an *action* in the operating system. We use context when we define SELinux policies.

    A context defines 4 attributes of an object; its user, role, type and level information.

    - **user**  - maps a system user login to an SELinux User definition. e.g. unconfined user, super user, etc..
    - **role**  - defines a group of policy elements. An SELinux user can be mapped to multiple roles.
    - **type**  - defines the SELinux type for a object. The targeted policy is focused on type enforcement. We will use this the most.
    - **level** - level is used in multi-level/multi-category security where the segmentation of content and operations is enforced. The level is defined as a range i.e. lowlevel-highlevel e.g. s0-s3

    Lets look at how we can determine the context of objects, modify context, restore it and propagate it.
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
> **IMPORTANT** You will be using the RHEL Web Console tab for this exercise. Log into the console as user tester with a password of tester

### Before beginning the lab

1. Select the **RHEL Web Console tab** at the top of the pane on the left. Accept the warning.
2. Log into the RHEL Web console as user **tester** with a password of *tester*.
3. In the RHEL Web console, select the Terminal window element at the bottom of the left hand bar.
4. Become the root user by running **sudo -i** in the terminal and providing the password for tester.

## <strong>Examining Context</strong>

Let's examine the content on a file from the tester user's home directory.

```bash
ls -lZ ~tester/.vimrc
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">-rw-r--r--. 1 root root <strong style="color: red">unconfined_u:object_r:user_home_t:s0</strong> 1464 Oct 31 16:29 /home/tester/.vimrc</pre>

The -Z flag is present in a wide variety of common CLI tools including ls and ps. The flag indicates that SELinux context information should be displayed. In this example we can see the fields are:
- user (unconfined_u)
- role (object_r)
- type (user_home_t)
- level (s0).

The SELinux user is not the same as the UNIX user. It exists to associate a system user (local or from a centralized identity store) to a set of SELinux roles. This allows system users to managed at scale more easily using SELinux policy. On a freshly deployed system with no additional configuration, there is a \__default__ SELinux user assigned to each system user. This default maps to the *unconfined_u* SELinux user. There are a number of other SELinux users. The unconfined_u user is allowed to launch any application that standard filesystem permissions allow. If that application has a defined context transition, then a confined context will still be applied to the process. You will find that context and domain are used interchangably when refering to processes. We will launch some processes to see these policy rules in action.

To demonstrate the difference between confined and unconfined processes, let’s launch an application which doesn’t have a defined domain transition.

```bash
yes >/dev/null &
ps -Z | grep yes
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:system_r:<strong style="color: red">unconfined_service_t</strong>:s0 149643 pts/0 00:00:00 yes</pre>

You can see that the *yes* process is labeled with the unconfined_service_t context, indicating that the process is unrestricted.

Stop the *yes* process by switching it to foreground and ending it using Crtl+C.

```bash
#switch to foreground and end the process with ctrl+c
fg
```

If we launch the passwd utility, we see a different result.

```bash
passwd tester >/dev/null &
ps -Z | grep passwd
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">unconfined_u:unconfined_r:<strong style="color: red">passwd_t</strong>:s0-s0:c0.c1023 29498 pts/0 00:00:00 passwd</pre>

See that the third field is *passwd_t*, indicating that the passwd process has been confined by the *passwd_t* domain.

Let’s stop the running process and move on:

```bash
kill %1
```

### Changing and Restoring context

If I had to suggest to a new administrator the one thing about SELinux that they should remember (and no, it’s not setenforce 0!), it would be *restorecon*. The restorecon command will reset the SELinux context of an object to what is defined for that object in the system’s context database. Red Hat Enterprise Linux ships with a preloaded context database that provides the default SELinux context policy information for all parts of the operating system. SELinux is enabled and enforcing by default, providing us with a very secure system out of the box. We can modify the context of objects when we have root privlege and if necessary restore them to the default.

We can change the context of an object the *chcon* command

To try this out, let’s purposefully set the context incorrectly on our example SELinux AVC log file.

```bash
chcon -t httpd_sys_content_t ./testaudit
ls -Z ./testaudit
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:object_r:<strong style="color: red">httpd_sys_content_t</strong>:s0 ./testaudit</pre>

Oh, no! What was the context supposed to be? Whew, restorecon saves the day.

```bash
restorecon -v ./testaudit
ls -Z ./testaudit
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Relabeled /root/testaudit from system_u:object_r:httpd_sys_content_t:s0 to system_u:object_r:admin_home_t:s0

-rw-------. root root system_u:object_r:<strong style="color: red">admin_home_t</strong>:s0 ./testaudit</pre>

The context of the file is magically restored to the default.

You can also manage context with the **semanage** command. The **semanage fcontext** command sets the context of a file system objects. Check out the man pages for more info!

Now that we understand SELinux context better let's write a simple policy to manage a custom application. On to the next challenge!