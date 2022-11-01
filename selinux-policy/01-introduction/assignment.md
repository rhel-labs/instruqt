---
slug: introduction
id: q9xht3vruyvm
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    ## History:
    In this exercise, we are going to introduce you to Security Enhanced Linux, commonly known as SELinux.

    SELinux is an implementation of the Flux Advanced Security Kernel (FLASK) system security architecture. FLASK implements a mandatory access control (MAC) architecture. Its goal is to provide an administratively-defined security policy that can control all subjects and objects on the system, basing decisions on all security-relevant information. FLASK security control is built on the concept of least privilege, in which, a process is given exactly the permissions it needs to perform its given task and no more. The Flask model allows an administrator to express a security policy in a naturally flowing manner like parts in a sentence. The architecture uses type enforcement (TE) and role-based access control (RBAC) to provide fine-grained control that is transparent to users and applications.

    The SELinux project was created by the US National Security Agency (NSA) to integrate FLASK technology into the Linux kernel. To drive the technology further, the NSA research team needed to transfer the technology to a larger developer and user community. Integration was challenging and went through several iterations. The necessity for a modular approach to security in the kernel motivated the creation of the Linux Security Modules (LSM) framework. And, at the suggestion of Linus Torvalds, SELinux leveraged LSM its implementation. SELinux code using LSM was integrated into the 2.6.x kernel. This kernel release provided the necessary full support for LSM and extended attributes (xattrs) in the ext3 file system. SELinux uses the xattrs to store security context information. The xattr namespace provides a useful separation for multiple security modules existing on the same system. Now SELinux is a standard feature of the Linux kernel.

    Much of the work to get the kernel ready for the SElinux LSM, as well as subsequent SELinux development, has been a joint effort between the NSA, Red Hat, and the community of SELinux developers. For more on this history you can read the [NSA security policies report](https://media.defense.gov/2021/Jul/29/2002815730/-1/-1/0/FLEXIBLE-SUPPORT-FOR-SECURITY-POLICIES-INTO-LINUX-FEB2001-REPORT.PDF)

    ## Other valuable resources
    - [SELinux Notebook](https://github.com/SELinuxProject/selinux-notebook/blob/main/src/toc.md) on GitHub
    - [SELinux.org FAQ](https://selinuxproject.org/page/FAQ)
    - [The SELinux Coloring Book](https://people.redhat.com/duffy/selinux/selinux-coloring-book_A4-Stapled.pdf) by Dan Walsh
tabs:
- title: Terminal
  type: terminal
  hostname: selinux1
difficulty: intermediate
timelimit: 21540
---
### Some SELinux Basics

>All current Red Hat Enterprise Linux operating systems are shipped to install with SELinux enabled and in enforcing mode.

> << **The line here is a sliding divider. Use it to give yourself more screen to read or see the instructions.**

At runtime, in general, SELinux can hold one of two states for the system. **Enforcing mode**, where SELinux security policy is loaded and enforced across the system. And, **Permissive mode**, where SELinux policy is loaded, checked, and logged, but *not enforced*.

Let's verify that SELinux is on and in enforcing mode. The **getenforce** command is used to list the current mode of SELinux.
```bash
sudo getenforce
```

You should see the output below.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">$ sudo getenforce
Enforcing
</pre>

OK, let's change the SELinux mode to permissive. The **setenforce** command governs the overall state of SELinux on the system at runtime.
```bash
sudo setenforce permissive
```
Use getenforce to list the current mode. You should now see that the output has changed. Just use up arrow to find and replay the getenforce command. Save yourself a copy and paste. :-)

<pre class="file">$ sudo getenforce
Permissive
</pre>

Let's change it back to Enforcing mode. I am using crazy capitalization here on purpose.
```bash
sudo setenforce EnForCINg
```

You can provide the word **enforcing** or **permissive** in any combination of case as long as you spell the mode correctly. You can also provide a numeric 1 (enforcing) or 0 (permissive) to change the state. Running getenforce should now show that the mode has been set to Enforcing again.
<pre class="file">$ sudo getenforce
Enforcing
</pre>

To make permanent changes to the system so that the states above survive a reboot, we edit the **/etc/selinux/config** file. There are two control statements. The statements start with **SELINUX=** and **SELINUXTYPE=**, each of these statements has three possible values.

SELINUX= can take one of these three values:
  - enforcing - SELinux security policy is enforced.
  - permissive - SELinux prints warnings instead of enforcing.
  - disabled - No SELinux policy is loaded.

> **NOTE:** On RHEL version 8.x and lower disabled actually disables SELinux entirely in the kernel. In RHEL 9 and later, SELinux is still turned on in the kernel, however, no policy is loaded at boot time (i.e. there are no rules to apply so nothing is impacted by SELinux). To ensure SELinux is disabled in the kernel, selinux=0 is added to the kernel command line.

SELINUXTYPE= can take one of these three values:
  - targeted - Targeted processes are protected,
  - minimum - Modification of targeted policy. Only selected processes are protected.
  - mls - Multi Level Security protection.

Only one policy can be active at any given time. You must reboot and possibly relabel the system if you change the policy type.q

### Managing individual applications

It is useful sometimes to manage an individual configuration while we are testing a policy or if an application with a policy has changed and we need to track its new behaviour. We can manage the scope of enforcement on an individual process using the **semanage** command. We refer to a scope of enforcement in SELinux as a **domain** or **context**. For example *httpd_t* is the domain that defines web server access. Let's set the httpd_t domain to permissive mode using the semanage command.
```bash
sudo semanage permissive --add httpd_t
```

This command adds the httpd_t domain to the list assigned SELinux Permissive mode. We can check that the domains was added to the Permissive Types using the semanage command with *--list*. Later, we will see how to add this to a policy.
```bash
sudo semanage permissive --list
```

You will see it listed like this.
<pre class="file">Builtin Permissive Types

Customized Permissive Types

httpd_t
</pre>

Changing it back is easy using semanage again.
```bash
sudo semanage permissive --delete httpd_t
```

In our case, the output tells us we have removed the last module with permissive mode.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">libsemanage.semanage_direct_remove_key: Removing last permissive_httpd_t module (no other permissive_httpd_t module exists at another priority).
</pre>

> **IMPORTANT:** Permissive mode is very important for SELinux practioners. Permissive mode may yield a different set of denials than enforcing mode. Enforcing mode prevents an operation from proceeding past the first denial. Permissive mode allows it to continue and potentially hit more denials. Some application code will fall back to a less privileged mode of operation if denied access. Permissive mode allows an administrator to find out all the SELinux rules the application is hitting under the current conditions and enables the administrator to define an appropriate policy. This is very useful when implementing SELinux in an environment where it hasn't been enforced in the past.

These are some of the basics of managing SELinux state.

In the next section we will see what happens when SELinux policy logs a violation and how we can identify it.