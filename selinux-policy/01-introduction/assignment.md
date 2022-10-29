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
tabs:
- title: Terminal
  type: terminal
  hostname: selinux1
difficulty: basic
timelimit: 21600
---
### Some SELinux Basics

>All current Red Hat Enterprise Linux operating systems are shipped to install with SELinux enabled and in enforcing mode.

> << **The line here is a sliding divider. Use it to give you more room to read or see the instructions.**

Lets find verify that SELinux is on and in enforcing mode.
```bash
sudo getenforce
```

You should see the output below.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">$ sudo getenforce
Enforcing
</pre>

OK, let's change the SELinux mode to permissive.
```bash
sudo setenforce 0
```
Use getenforce to list the current mode. You should now see that the output has changed.

<pre class="file">$ sudo getenforce
Permissive
</pre>

Let's change it back to Enforcing mode.
```bash
sudo setenforce EnForCINg
```

You can provide the word enforcing or permissive in any case and the system will apply the appropriate mode. Running getenforce should now show that the mode has been set to Enforcing again.
<pre class="file">$ sudo getenforce
Enforcing
</pre>

The setenforce command governs the overall state of SELinux on the system. It is useful sometimes to manage an individual configuration while we are testing. We refer to a scope of enforcement in SELinux as a domain. For example 'httpd_t' is the domain that defines web server access. Let's set the httpd_t domain to permissive mode using the semanage command.
```bash
sudo semanage permissive --add httpd_t
```

This adds the httpd_t domain to the list of customized domains assigned SELinux Permissive mode. We can list the domains add to the Permissive list using the semanage command again.
```bash
sudo semanage permissive --list
```

You will see it listed like this.
<pre class="file">Builtin Permissive Types

Customized Permissive Types

httpd_t
</pre>

Changing it back is easy using the semanage again.
```bash
sudo semanage permissive --delete httpd_t
```

It returns the rather long output below telling us we have removed the last module with permissive mode in the listing...
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">libsemanage.semanage_direct_remove_key: Removing last permissive_httpd_t module (no other permissive_httpd_t module exists at another priority).
</pre>

### IMPORTANT
**Permissive mode is very important** for SELinux practioners as it still checks all policy and **only logs any potential violations**, but it **doesn't enforce the denials**. The **action continues normally** and is fully logged. This allows an administrator to find out what SELinux rules a particular application is hitting and helps in our efforts to define an appropriate policy.

In the next section we will see what happens when SELinux policy logs a violation and how we can identify it.