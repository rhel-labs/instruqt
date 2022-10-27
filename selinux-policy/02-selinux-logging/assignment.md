---
slug: selinux-logging
id: 87xpavgssnsr
type: challenge
title: SELinux Logging
notes:
- type: text
  contents: |
    In this exercise, we will discuss the WHO, WHAT, WHERE, WHY, WHEN and HOW of SELinux logging.
    - WHO did the event happened for
    - WHAT was being accessed when the violation occured
    - WHERE SELinux logs are stored anyways?
    - WHY a particular SELinux denial took place
    - WHEN we might change policy to allow the behaviour, and most importantly
    - HOW we search for SELinux messages efficiently

    In Red Hat Enterprise Linux many activities are logged by default. SELinux denials are one of those things. SELinux configuration is loaded at boot time and SELinux policy is cached for very fast access. Remember that SELinux information is stored in the xattrs of every file, so as soon as anything is touched, that information is loaded as part of the objects attributes. The cache that stores the information is called the Access Vector Cache or AVC. When an AVC entry is checked and the result of the access action is logged with an entry of type=AVC. The AVCs tell us a lot about how our applications are behaving with SELinux

    Let's look at how we find them first.
tabs:
- title: Terminal
  type: terminal
  hostname: selinux1
difficulty: basic
timelimit: 1
---
SELinux messages are logged to the system journal and in <b>/var/log/audit/audit.log</b> file. WHERE. Check.
The <b>ausearch</b> command is used to search the audit.log file for various message types. Take a look at the command below. It uses the message argument to look for SELinux Policy Load events, the interpret argument to make the output more human readable, and --just-one to say give me only one result item.
```bash
sudo ausearch --message MAC_POLICY_LOAD --interpret --just-one
```

You should see the output below.
<pre class="file">$ sudo ausearch --message MAC_POLICY_LOAD --interpret --just-one
----
type=PROCTITLE msg=audit(2022-10-25 16:28:40.264:109855) : proctitle=/sbin/load_policy
type=SYSCALL msg=audit(2022-10-25 16:28:40.264:109855) : arch=x86_64 syscall=write success=yes exit=3544287 a0=0x4 a1=0x7f78e68c4000 a2=0x3614df a3=0x0 items=0 ppid=790034 pid=790038 auid=parmstro uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=3 comm=load_policy exe=/usr/sbin/load_policy subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=MAC_POLICY_LOAD msg=audit(2022-10-25 16:28:40.264:109855) : auid=parmstro ses=3 lsm=selinux res=yes
</pre>

Examining the output you can see that /usr/sbin/load_policy is called to load the SELinuix policy. The policy was loaded by the SELinux LSM and that the operation was successful. A more through example of understanding an audit record is discussed in the [RHEL Security Hardening Guide, Chapter 12](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/auditing-the-system_security-hardening#understanding-audit-log-files_auditing-the-system). The [RHEL AUdit System Reference](https://access.redhat.com/articles/4409591) provides the definitive list of each of the Audit Event Fields and Audit Record Types.

From an SELinux perspective, some useful record types to search for are: avc, user_avc, selinux_err, user_selinux_err. You can search for multiple at the same time by specifying a list.
```bash
sudo ausearch --message avc,user_avc --interpret
```
You can limit your search to a time period, like today (-ts | --start == time start). Or bracket a particular window with -ts and -te (-te | --end == time end). This is very useful for troubleshooting issues that may have involved and SELinux denial.
```bash
sudo ausearch --message avc --interpret --start today
```

The key word recent means in the last 10 minutes.
```bash
sudo ausearch --message avc --interpret --start recent
```
HOW. Check.

There should be a testaudit file located in /root. It contains some audit information taken from a test machine that will help use understand some of the SELinux messages we will see when we have a denial. To see what an AVC audit message looks like, run the following.
```bash
sudo ausearch --input /root/testaudit --message avc
```
<pre class="file">----
time->Tue Oct 25 16:28:40 2022
type=SYSCALL msg=audit(1666729720.264:86): arch=40000003 syscall=196 success=no exit=-13 a0=b9a1e198 a1=bfc2921c a2=54dff4 a3=2008171 items=0 ppid=2425 pid=2427 auid=502 uid=48 gid=48 euid=48 suid=48 fsuid=48 egid=48 sgid=48 fsgid=48 tty=(none) ses=4 comm="httpd" exe="/usr/sbin/httpd" subj=unconfined_u:system_r:httpd_t:s0 key=(null)
type=AVC msg=audit(1666729720.264:86): avc:  denied  { getattr } for  pid=2427 comm="httpd" path="/var/www/html/file1" dev=dm-0 ino=284133 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:samba_share_t:s0 tclass=file
</pre>

From the output, we can see that the httpd process, pid=2427, was denied when it tried to check the attributes on /var/www/html/file1. The result also gives an indication of why! The source context was httpd_t and the target context was samba_share_t. The target class was a file.
WHO and WHAT. Check.

There is a cool tool called audit2why. This gives you a more plain language reason as to why the action was denied. Try this.
```bash
sudo ausearch --input /root/testaudit --message avc | audit2why
```

You should see something like the following.
<pre class="file">type=AVC msg=audit(1666729720.264:86): avc:  denied  { getattr } for  pid=2427 comm="httpd" path="/var/www/html/file1" dev=dm-0 ino=284133 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:samba_share_t:s0 tclass=file

        Was caused by:
                Missing type enforcement (TE) allow rule.

                You can use audit2allow to generate a loadable module to allow this access.
</pre>

The audit2why command is telling use that ther is a missing type enforcement rule. Hmmm... Does that mean that we should allow httpd to access samba files? No! This is obviously not the complete picture of the situation, but it is pointing use towards the problem that maybe the file's context is not set properly.

WHY? This is a good start. This also brings up the point of WHEN do we really want to make a change to policy. I think we still need more information.

And Context? What is a file or any other object's "context". Let's find out in the next exercise.
