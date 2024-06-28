---
slug: sudo
id: lzli0o6kb7zp
type: challenge
title: Sudo Rule Management
teaser: Controlling user authorization on systems
notes:
- type: text
  contents: |
    ## Sudo Rule Management

    One of the favourite features of Administrators using IdM is centralized sudo management. The ability to centrally manage privilege policy and then have it applied to systems as they join the realm is a boon to productivity. With the **Sudo Rules** feature in IdM we are able to use all our organizational objects within IdM to control how privilege is assigned within the realm without having to reach out to every system when each time a change must occur.

    In this challenge we will create sudo commands, place them in command groups and apply those commands to users and groups in our realm to control the activities that users can perform on the hosts that they are authorized to access.
tabs:
- title: IdM Server
  type: terminal
  hostname: idmserver1
- title: IdM Web UI
  type: external
  url: https://idmserver1.${_SANDBOX_ID}.instruqt.io
- title: IdM Client
  type: terminal
  hostname: idmclient1
difficulty: basic
timelimit: 5760
---
<!-- markdownlint-disable MD033 -->
## Welcome to challenge 5

### Sudo Rule Management

Sudo is a program that allows users to run programs as another user with different privileges. Sudo is typically used to allow non-root users to execute administrative commands that are normally reserved for the root user. When users need to perform an administrative command they precede the privileged command with sudo. ``sudo <command>`` After entering their password, the command is executed as if they were the privileged user they are mapped to. As an example, you can use sudo to run command as a database service account. The ***RunAs alias*** for a sudo rule maps a the user to another user or service account.

With IdM, all this can be managed centrally instead of on each individual server. This generates a higher degree of consistency in the configuration, simplifies administration, and reduces user error.

<hr>

### Exercise 5.1 - Configure a sudo rule policy

We have 2 users in our environment at this time - ***alice*** and ***bob***. ***alice*** is a member of the admins group. She is able to login to all machines within the realm. When she logs into the machine, as an admin she should be able to act as a root user based on her group membership.

Using the IdM Server tab, let's authenticate as ***alice*** and ensure that we have a TGT. We will then ssh to the client host as alice.

```bash
kinit alice
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
klist
Ticket cache: KCM:634000003:33566
Default principal: alice@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]

Valid starting       Expires              Service principal
06/25/2024 17:19:47  06/26/2024 17:15:49  krbtgt/[[ Instruqt-Var key="realm" hostname="idmserver1" ]]@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
</pre>

Now let's ssh to the idmclient1 system.

```bash
ssh alice@idmclient1.[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[alice@idmclient1 ~]$
</pre>

If we are an admin we would expect that we should be able to perform admin like activities like set the message of the day. Now since we are not root, we need to use sudo to do this.

```bash
sudo vim /etc/motd
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
sudo vim /etc/motd

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for alice:
</pre>

ooops!

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
alice is not allowed to run sudo on idmclient1.  This incident will be reported.
[alice@idmclient1 ~]$
</pre>


Logout from the client system by typing ``exit``.

Logout of alice's context by typing ``kdestroy -A``.
kinit as the admin user ``kinit admin``.

If you were to repeat the previous example now as admin, you would find that you would be successful in setting the motd.
As we mentioned earlier, the IdM 'admins' group is like a super user for the realm.
Alice as a member of the sysadmins group does not have the same privilege.
Separating the realm administration from system administratrion is good security practice.

We can create a sudo rule for the sysadmins group to have super user privilege on a subset the realm's systems.
In this case we will set this up for production systems.

If we investigate using the CLI, we find the following:

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
# ipa help sudorule
Sudo Rules

Sudo (su "do") allows a system administrator to delegate authority to
give certain users (or groups of users) the ability to run some (or all)
commands as root or another user while providing an audit trail of the
commands and their arguments.

IPA provides a means to configure the various aspects of Sudo:
   **Users:** The user(s)/group(s) allowed to invoke Sudo.
   **Hosts:** The host(s)/hostgroup(s) which the user is allowed to to invoke Sudo.
   **Allow Command:** The specific command(s) permitted to be run via Sudo.
   **Deny Command:** The specific command(s) prohibited to be run via Sudo.
   **RunAsUser:** The user(s) or group(s) of users whose rights Sudo will be invoked with.
   **RunAsGroup:** The group(s) whose gid rights Sudo will be invoked with.
   **Options:** The various Sudoers Options that can modify Sudo's behavior.

An order can be added to a sudorule to control the order in which they
are evaluated (if the client supports it). This order is an integer and
must be unique.
...
</pre>

We want to add a sudo rule for sysadmins group to:
- run any command
- on production systems
- as any user
- as any group

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa help sudorule-add
Usage: ipa [global-options] sudorule-add SUDORULE-NAME [options]

Create new Sudo Rule.
Options:
  -h, --help            show this help message and exit
  --desc=STR            Description
  --usercat=['all']     User category the rule applies to
  --hostcat=['all']     Host category the rule applies to
  --cmdcat=['all']      Command category the rule applies to
  --runasusercat=['all']
                        RunAs User category the rule applies to
  --runasgroupcat=['all']
                        RunAs Group category the rule applies to
  --order=INT           integer to order the Sudo rules
...
</pre>

We can see from the help listing that this command is very similar to the hbacrule-add command we saw in the previous challenge.

Create a new sudo rule named ***sysadmins_allow_all_production*** with a description ***Allow sysadmins group root access to production servers*** that meets the criteria that we specified above.

```bash
ipa sudorule-add sysadmins_allow_all_production \
  --desc="Allow sysadmins group root access to production servers" \
  --cmdcat="all" \
  --runasusercat="all" \
  --runasgroupcat="all"
```

Now lets make sure that this rule applies only to production servers.

```bash
ipa sudorule-add-host sysadmins_allow_all_production \
  --hostgroups "production"
```

Now lets ensure that the sysadmins have this sudo rule applied to them.

```bash
ipa sudorule-add-user sysadmins_allow_all_production \
  --groups=sysadmins
```
Alice should now have sudo access on all the systems in the realm.
Logout and log back in as alice, then ssh to idmclient1 as alice.

```bash
kdestroy -A
```

```bash
kinit alice
```

```bash
ssh alice@idmclient1.[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
```
Confirm that you are running with a TGT for alice
```bash
klist
```

Try again to edit the /etc/motd file and provide the password for ***alice***

```bash
 sudo vim /etc/motd
```

What happens? Are you allowed access?
If you are not allowed, wait for about 5 minutes, or go to the client machine tab and run ``systemctl restart sssd`` to force .

Try again...

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
We Now have sudo access!
~
~
~
"/etc/motd" 0L, 0B
</pre>

You have created your first simple sudo policy. We will now make something a little more restrictive for user ***bob***

<hr>

### Exercise 5.2 - Creating sudo commands, command groups, and using them in rules.

#### Exercise 5.2.1 - Prepare IdM objects
The goal of this exercise it to pull together a number of the things that we have learned to give user **bob** access to our client machine and allow him enough authorization to manage the web server that was installed as part of the setup.

For this exercise, use the skills you have learned so far to do the following:
- create a user group named **webadmins**
- add **bob** as a member of **webadmins**
- create a host group called **webservers**
- add your **idmclient1** machine to the **webservers** group
- create an hbac rule named **allow_webadmins_webservers_sshd** to allow **webadmins** to log in to hosts that are part of the **webservers** host group using the **sshd** service

The shell commands to perform this are provided at the end of this section.

<hr>

Once you have completed creating the above prerequisites, ***bob*** should be able to login to your client, however, he can not use ``su -l`` to create a login shell.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[bob@idmclient1 ~]$ su -l bob
Password:
su: Authentication failure
<pre>

Bob also can't restart the httpd service using sudo. You will find that the error is different for ***bob*** than it was for ***alice***. This is because where the hbac rule for *alice* was created with ``--servicecat=all``, the hbac rule for *bob* was create to limit access to ***sshd***

As a webadmin controlling the web services ***bob*** needs to run both ``su -l`` and ``sudo``. Make sure that both commands are added to the list of allowed services in the host based access control rule **allow_webadmins_webservers_sshd**

```bash
ipa hbacrule-add-service allow_webadmins_webservers_sshd \
    --hbacsvcs=sudo --hbacsvcs=su-l
```
Ensure that you logout of the client system and relogin as ***bob***. Now you should be able to use the appropriate commands. However, notice that bob still can't restart httpd

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[bob@idmclient1 ~]$ su -l bob
Password:
Last login: Wed Jun 26 17:55:51 EDT 2024 from 10.5.2.41 on pts/1
[bob@idmclient1 ~]$ sudo systemctl restart httpd
[sudo] password for bob:
Sorry, user bob is not allowed to execute '/bin/systemctl restart httpd' as root on idmclient1.[[ Instruqt-Var key="realm" hostname="idmserver1" ]].
</pre>

<hr>

#### Exercise 5.2.2 - Add the commands, command groups and rules

Let's solve this problem by creating a new sudo rule to give webadmins the appropriate permissions.

```bash
ipa sudorule-add webadmin_sudo \
    --runasusercat=all \
    --runasgroupcat=all
```

We now need to add the restrictions for groups that the rule applies to and hosts that they are allowed sudo access to.

```bash
ipa sudorule-add-user webadmin_sudo --groups webadmins
```

```bash
ipa sudorule-add-host webadmin_sudo --hostgroups webservers
```

Great! Now we need to create the commands and command group to restrict their actions to manage the httpd service.

```bash
ipa sudocmd-add "/usr/bin/systemctl start httpd"
```

```bash
ipa sudocmd-add "/usr/bin/systemctl restart httpd"
```

```bash
ipa sudocmd-add "/usr/bin/systemctl stop httpd"
```

Create the group
```bash
ipa sudocmdgroup-add webadmin_cmds
```
```bash
ipa sudocmdgroup-add-member webadmin_cmds \
    --sudocmds "/usr/bin/systemctl start httpd" \
    --sudocmds "/usr/bin/systemctl restart httpd" \
    --sudocmds "/usr/bin/systemctl stop httpd"

```

Now we can add the command group to our sudo rule.

```bash
ipa sudorule-add-allow-command webadmin_sudo \
    --sudocmdgroups webadmin_cmds
```

#### Exercise 5.2.3 - Verify sudo access for webadmins.

Login to idmclient1 from idmserver1 as bob again using ssh.

Verify that bob can restart the web server
```bash
su -l bob
```

```bash
sudo systemctl restart httpd
```
You should see output similar to this:

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[bob@idmclient1 ~]$ su -l bob
Password:
Last login: Wed Jun 26 17:57:01 EDT 2024 from 10.5.2.41 on pts/1
[bob@idmclient1 ~]$ sudo systemctl restart httpd
[sudo] password for bob:
[bob@idmclient1 ~]$
<pre>

Remember if you don't want to wait for the timeout go to the idmclient1 terminal and restart sssd.
Try again.

Is there a problem?

Verify that bob can't run other commands as root
```bash
sudo id
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
Sorry, user bob is not allowed to execute '/bin/id' as root on...
</pre>

> NOTE: The solution for ***Exercise 5.2.1*** command line example is below.


<hr>

This concludes the unit 5 and IdM Workshop - Part I, your Red Hat Team thanks you for participating!


If you are interested in more, IdM Workshop - Part II covers the following:

- Replica Deployment
- Certificate and Service Management
- SELinux User Mapping
- User and Service Vaults
- Integrating with External IDPs
- and much more.

You can let us know how you enjoyed the workshop on the next page.

<hr>

### Solution to Exercise 5.2.1

Login as the admin
```bash
kinit admin
```

Create the ***webadmins*** user group
```bash
ipa group-add --desc="Web Application Administrators" webadmins
```

Add ***bob*** as a member of ***webadmins***
```bash
ipa group-add-member webadmins --users=bob
```

Create a host group ***webservers***
```bash
ipa hostgroup-add --desc="Web Servers" webservers
```

Add the idmclient1 system to the webservers host group
```bash
ipa hostgroup-add-member webservers --hosts=idmclient1.[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
```

Create the hbac rule to allow webadmins access via ssh
```bash
ipa hbacrule-add allow_webadmins_webservers_sshd \
    --desc="Allow webadmins to login to web servers via ssh"
```

Add the webadmins to the rule
```bash
ipa hbacrule-add-user allow_webadmins_webservers_sshd \
    --groups=webadmins
```

Add the webservers to the rule
```bash
ipa hbacrule-add-host allow_webadmins_webservers_sshd \
    --hostgroups=webservers
```

Add the services to the rule
```bash
ipa hbacrule-add-service allow_webadmins_webservers_sshd \
    --hbacsvcs=sshd \
    --hbacsvcs=sudo \
    --hbacsvcs=su-l
```
Test the hbac rule for ***bob***

```bash
ipa hbactest --user=bob --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=sshd
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hbactest --user=bob --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=sshd
--------------------
Access granted: True
--------------------
  Matched rules: allow_webadmins_webservers_sshd
  Not matched rules: admins_allow_all
  Not matched rules: allow_systemd-user
</pre>
