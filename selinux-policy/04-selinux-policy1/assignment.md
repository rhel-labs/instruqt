---
slug: selinux-policy1
id: ielkus4d8p1o
type: challenge
title: SELinux Policy 1
notes:
- type: text
  contents: |
    In the previous challenge we learned what SELinux context is, how to list context for different operating system objects, how to search for it in policy, how to change context on an object and how to reset it to the default.

    In this exercise, we will start writing a simple SELinux policy using type enforcement to confine a custom application.

    The sample application is a simple C program that pulls the current weather for each of the worldwide Red Hat offices from a weather site. The code for the sample application is already compiled and running on your system. You can find the source in the /root/selinuxlab directory.

    When we apply a policy to the application we will find that a number of AVCs become apparent.

    We will build the default policy and see how it behaves. Time to start the next challenge.
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
### Generate a default SELinx policy

We will normally use source control, like git, to manage our policy content and follow good DevSecOps practice as we work through creating the policy. In our workshop we will not be using source control. Let's just isolate our code in a directory.

```bash
mkdir /root/selinuxlab/policy
cd /root/selinuxlab/policy
```

Now we will create a template policy using the **sepolicy generate** command. The *--init* switch says to make a policy template for a process started as a service. We can generate other template types. See the sepolicy man page.

```bash
sepolicy generate --init /usr/local/sbin/testapp
```

What we should see is that the command has created a number of files in the policy directory. The contents of these 5 files help us define the policy that will be applied to our app.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Created the following files:
/root/selinuxlab/policy/<strong style="color: red">testapp.te</strong> # Type Enforcement file
/root/selinuxlab/policy/<strong style="color: red">testapp.if</strong> # Interface file
/root/selinuxlab/policy/<strong style="color: red">testapp.fc</strong> # File Contexts file
/root/selinuxlab/policy/<strong style="color: red">testapp_selinux.spec</strong> # Spec file
/root/selinuxlab/policy/<strong style="color: red">testapp.sh</strong> # Setup Script</pre>

**SELinux Policy Source Components**

1. **testapp.te** is the base policy for the application. It sets the rules for the *testapp_t* domain.
2. **testapp.if** is the interface file. Interfaces are like public functions, in that they provide ways for other SELinux modules to interact with the one that you are writing. This file contains the definition and mapping of the domain transition and execution endpoints for testapp policy.
3. **testapp.fc is** the file contexts file. It contains the labeling information for all filesystem objects that the policy references, including the executable.
4. **testapp_selinux.spec** the selinux policy is packaged as an rpm for distribution for you automatically. The spec file defines the rpm build.
5. **testapp.sh** is a Red Hat provided script that compiles and loads the SELinux policy module.

**Compile the default policy**

Run the testapp.sh script to compile the SELinux base policy and cause it to load into the security server. These scripts need to run as root.

```bash
sudo /root/selinuxlab/policy/testapp.sh
```

> You may see a bunch of lines that state **Error: duplicate definition of ...**. These can safely be ignored.
You should see the process start with something like the following.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">Building and Loading Policy
<strong style="color: red">+ make -f /usr/share/selinux/devel/Makefile testapp.pp
Compiling targeted testapp module</strong>
/usr/bin/checkmodule:  loading policy configuration from tmp/testapp.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 19) to tmp/testapp.mod
Creating targeted testapp.pp policy package
rm tmp/testapp.mod tmp/testapp.mod.fc
+ /usr/sbin/semodule -i testapp.pp
+ sepolicy manpage -p . -d testapp_t
./testapp_selinux.9
...
</pre>

 The process builds the source and binary rpms, installs rpm and writes the resulting files to the policy directory. The rpm files allow you to easily redistribute the SELinux policy with your application installation and automation.

 <pre class="file" style="white-space: pre-wrap; font-family:monospace;">...
...
Wrote: <strong style="color: red">/root/selinuxlab/policy/testapp_selinux-1.0-1.el9.src.rpm</strong>
Wrote: <strong style="color: red">/root/selinuxlab/policy/noarch/testapp_selinux-1.0-1.el9.noarch.rpm</strong>
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.aqm3qv
+ umask 022
+ cd /root/selinuxlab/policy
+ /usr/bin/rm -rf /root/selinuxlab/policy/.build/testapp_selinux-1.0-1.el9.x86_64
+ exit 0
</pre>

### See the policy in action

Let's reload the application to see the policy in action.

```bash
sudo systemctl restart testapp
ps -efZ | grep sbin | grep testapp
```

We now see the application running under the testapp_t context (sometimes called domain when referring to a process).
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">system_u:system_r:<strong style="color: red">testapp_t</strong>:s0  root      8737     1  0 20:51 ?        00:00:00 /usr/local/sbin/testapp</pre>

**How does the application get the context?**

The policy defines the labels and the rules for the domain/context the application runs in - the target context - in our case *testapp_t*. The application is started by the systemd process which runs under context *init_t* and has a very high level of privilege. We can't have the application inherit the init_t context, so, the policy also defines the **transition** between the context of the starting process and the target context for the application. The policy basically states that:

when a process labeled *init_t* starts a binary labeled *testapp_exec_t* the system transitions the newly created process to a context of *testapp_t*

Labels, transitions, etc.. are defined in the policy database. You can view them using the **sesearch** utility. Check out the man page for all the switches and how they work, but for now try this.

```bash
sesearch --type_trans --source init_t --target testapp_exec_t
```

You should see that we have a type transition that gets our testapp to the proper context.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">type_transition init_t testapp_exec_t : process testapp_t;</pre>

**Current state of the policy**

At this point, we have a generic policy for the testapp application, which is set for **permissive** mode. Thus, the application can run, and SELinux will generate alerts when existing system policy is violated, but will take no action.

Let's track down any AVCs that get generated and adjust our policy to allow testapp to run cleanly in Enforcing mode. On to the next challenge!
