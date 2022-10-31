---
slug: selinux-policy1
id: ielkus4d8p1o
type: challenge
title: SELinux Policy 1
notes:
- type: text
  contents: |
    In this exercise, we will start writing a simple SELinux policy to confine a custom application.

    The sample application is a simple C program that pulls the current weather for each of the worldwide Red Hat offices from a weather site. The code for the sample application is loaded and compiled already on your system.

    When we apply a policy to the application we will find that a number of AVCs become apparent.

    Let's build the default policy and see how it behaves.
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
### Generate a generic SELinx policy
We will normally use source control, like git, to manage our policy content and follow good DevSecOps practice as we work through creating the policy. In our workshop we will not be using source control. Let's just isolate our code in a directory.

```bash
mkdir /root/selinuxlab/policy
cd /root/selinuxlab/policy
sepolicy generate --init /usr/local/sbin/testapp
```
This will generate a bit of output. What we should see is that the command has created a number of files in the policy directory. We will use these files to define the policy. You should see 5 files.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Created the following files:
/root/selinuxlab/policy/testapp.te # Type Enforcement file
/root/selinuxlab/policy/testapp.if # Interface file
/root/selinuxlab/policy/testapp.fc # File Contexts file
/root/selinuxlab/policy/testapp_selinux.spec # Spec file
/root/selinuxlab/policy/testapp.sh # Setup Script</pre>

**SELinux Policy Source Compnents**
1. **testapp.te** is the base policy for the application. It sets the rules for the **testapp_t** domain.
2. **testapp.if** is the interface file. Interfaces are like public functions, in that they provide ways for other SELinux modules to interact with the one that you are writing. This file the mapping of the endpoints.
3. **testapp.fc is** the file contexts file. It contains the labeling information for all filesystem objects that the policy references
4. **testapp_selinux.spec** the selinux policy is packaged as an rpm for distribution for you automatically. The spec file defines the rpm build.
5. **testapp.sh** is a Red Hat provided script that compiles and loads the SELinux policy module.

**Compile the policy framework**
Run the testapp.sh script to compile the SELinux base policy and cause it to load into the security server. These scripts need to run as root.

```
sudo /root/selinuxlab/policy/testapp.sh
```
You should see the process start with something like the following.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Building and Loading Policy
+ make -f /usr/share/selinux/devel/Makefile testapp.pp
Compiling targeted testapp module
/usr/bin/checkmodule:  loading policy configuration from tmp/testapp.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 19) to tmp/testapp.mod
Creating targeted testapp.pp policy package
rm tmp/testapp.mod tmp/testapp.mod.fc
+ /usr/sbin/semodule -i testapp.pp
+ sepolicy manpage -p . -d testapp_t
./testapp_selinux.9</pre>

 You will see the source and binary rpms being built, installed and written to the policy directory. The rpm allows you to easily redistribute the SELinux policy with your application installation and automation.
 <pre class="file" style="white-space: pre-wrap; font-family:monospace;">+ /sbin/restorecon -F -R -v /usr/local/sbin/testapp
++ pwd
+ pwd=/home/ec2-user/src/policy
+ rpmbuild --define '_sourcedir /home/ec2-user/src/policy' --define '_specdir /home/ec2-user/src/policy' --define '_builddir /home/ec2-user/src/policy' --define '_srcrpmdir /home/ec2-user/src/policy' --define '_rpmdir /home/ec2-user/src/policy' --define '_buildrootdir /home/ec2-user/src/policy/.build' -ba testapp_selinux.spec
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.8GjK3r
...
...
Wrote: /root/selinuxlab/policy/testapp_selinux-1.0-1.el9.src.rpm
Wrote: /root/selinuxlab/policy/noarch/testapp_selinux-1.0-1.el9.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.aqm3qv
+ umask 022
+ cd /root/selinuxlab/policy
+ /usr/bin/rm -rf /root/selinuxlab/policy/.build/testapp_selinux-1.0-1.el9.x86_64
+ exit 0
</pre>

### See the policy in action

Let's reload the application to see the app in action.
```
sudo systemctl restart testapp
ps -efZ | grep sbin | grep testapp
```
We now see the application running under the testapp_t context (commonly called a domain when referring to a process).
 <pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:system_r:testapp_t:s0  root      8737     1  0 20:51 ?        00:00:00 /usr/local/sbin/testapp</pre>

**How does the application get the context?**
The basic policy defines the target context type and label for the process context, that is, what domain/context the application runs in. The application is started by the systemd process though which runs under *init_t*. We can't have the application inherit the init_t context, so, the policy also defines the **transition** between the starting process and the target context for the application and the label that the process will have. The policy basically states that:

when a process labeled **init_t** starts a binary labeled **testapp_exec_t** the system transitions the newly created process to a context **testapp_t**

All of these transitions are defined in the policy database. You can view them using the **sesearch** utility. Check out the man page for all the switches and how they work.
```
sesearch --type_trans --source init_t --target testapp_exec_t
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">type_transition init_t testapp_exec_t : process testapp_t;</pre>

**Current state of the policy**
At this point, we have a generic policy for the testapp application, which is set for **permissive** mode. Thus, the application can run, and SELinux will generate alerts when existing system policy is violated, but will take no action.

Let's track down any AVCs that get generated and adjust our policy to allow testapp to run cleanly in Enforcing mode. On to the next challenge!
