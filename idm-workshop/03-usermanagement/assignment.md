---
slug: usermanagement
id: k9cirezut12m
type: challenge
title: User Management and Kerberos Authentication
teaser: Create and Manage users, groups and services
notes:
- type: text
  contents: |
    ## User Management and Kerberos Authentication

    Once our Identity Management servers are configured, we can start creating the objects that
    we use to manage our realm. These objects include users, user groups, hosts, host groups and services.
    IdM uses a directory server backend and can store all the pertinent information required for
    complete user management - user facts, user authentication methods, ssh keys, certificates,
    login shell and home directory.

    We are also able to configure elements like password policy, SELinux policy, etc.. We will explore
    these in more detail in later exercises.

    In this challenge we will use both the IdM CLI and the Web User Interface of IdM
    to configure user groups, users and to manage their authentication to the systems.

    For more information on managing users, groups, hosts and controlling access, please refer to the official documentation in [Managing IdM users, groups, hosts, and access control rules](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/managing_idm_users_groups_hosts_and_access_control_rules/index)
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
## Welcome to challenge 3

This unit introduces the IdM web interface and the **ipa** CLI program. We will perform some simple administrative tasks using these tools:

* adding groups
* adding users and
* managing group membership

<hr>

### The IdM Web UI

Use the **IdM Web UI** tab. This should direct you to the web UI for *your* lab instance.
You will get a TLS **untrusted issuer warning** which you should dismiss accordingly in your browser.

> ***NOTE:*** The Web UI **must** open in a separate browser tab or window. For security reasons the Web UI does not allow itself to be opened in an embedded iframe.

Log in as **admin** with the password of **redhat2024** (or the password you used in previous exercises).

Welcome to the Identity Management Web UI. Management activities can be
performed here, or via the **ipa** CLI program.  The web UI should be very intuitive.

<hr>

### Exercise 3.1 - Using the Web UI
Use the Web UI to perform the following actions:

1. Add a *User* with the username **alice** with an initial password of **test123**.
2. Ensure that a *User Group* for system administrators named **sysadmins** exists. Create it if necessary.
3. Add **alice** to the **sysadmins** user group.
4. Add a new *User Group* for developers named **developers** with a description of **Application Developers** and accept the default settings.
5. Verify that the default **admin** user is a member of the **admins** user group.

Reach out to your workshop instructor if you get stuck.

Note that we can create users immediately, or we can **stage** them to be activated at a later date.
Staging is a standard practice in most environments as part of the on-boarding process for
newly hired employees. Staged users have a UID of -1. Activating a staged user moves their login
in the UI to the Active users category.

When you delete a user, you have the option to delete it completely or **preserve** the user that has
been removed from service. Preserving the user is ideal for accounts that have be created for temporary
activities like consulting engagements, etc. They can be restore or re-stage the user if, for example,
the user will resume working for the organization.

If you have time during this exercise come back to this and experiment with staging, activating,
preserving, reactivating, restaging and deleting a user.

We can create a variety of groups as well, in our exercise, we are creating a user
group. We can create **host groups** to apply policy more easily across servers. Legacy
Netgroups are supported if necessary. We will see a lot more about host groups in later
exercises.

<hr>

### Exercise 3.2 - Discovering the ipa CLI

For this part of the challenge, use one of the terminal windows
IdM Server or IdM Client.

Make sure you have a Kerberos ticket for **admin** (reminder:
**kinit admin**). To perform many of the tasks that the **ipa**
command is capable of we need authentication as a kerberos user that
has authorization to perform these actions on the realm. The
admin user is essentially *root* on the realm.

All IdM administrative actions can be carried out using the
**ipa** CLI program.  Let's see what commands are available.

```bash
ipa help commands
```
> << Remember you can expand this column
>    using the slider to the left to see this content more easily

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
automember-add                    Add an automember rule.
automember-add-condition          Add conditions to an automember rule.
automember-default-group-remove   Remove default (fallback) group for all unmatched entries.
automember-default-group-set      Set default (fallback) group for all unmatched entries.
automember-default-group-show     Display information about the default (fallback) automember groups.
...
</pre>

Wow! There are nearly 450 commands! We will be using only a handful
of these today.

> Command completion is enabled, you can type a partial
> command and press **<TAB>** a couple of times to see
> what commands are available, e.g. all the commands starting
> with **cert-**
>
> ipa cert-<TAB>
> cert-find         cert-request      cert-show
> cert-remove-hold  cert-revoke       cert-status

The ipa commands are grouped by *topic*, that is, the kind of
object they act upon.  Run **ipa help topics** to list all topics.
You can read a general overview of a topic by running the command
**ipa help <topic>**. Some topics have multiple levels. We can dig
in by following the listings. To get specific information on a particular
command by running **ipa help <command>**. The hbac topic that manages
host based access control is an example that has multiple levels.

Try these now.

```bash
ipa help topics
```

```bash
ipa help hbac
```

```bash
ipa help hbacrule
```

Now its time to practice using the help to get some users created.

<hr>

### Exercise 3.3 - Creating a user
Using the ipa CLI and the help command, add a user named **bob**.

Make sure you are logged in as admin. (**hint**: check with klist)

Use the CLI help to find the right command and create the user.
(**hint**: the *user* plugin provides the command).

Lastly, add **bob** to the **developers** user group using the CLI.

<hr>

### Exercise 3.3 - User authentication

We have seen how to authenticate as **admin**. The process is the
same for regular users - just use **kinit <username>**

Try to authenticate as **bob**
```bash
kinit bob
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
kinit bob
kinit: Pre-authentication failed: Invalid argument while getting initial credentials
</pre>

If you did **not** encounter this error, congratulations - you must be
a disciplined reader of documentation!

To set an initial password when creating a user via the **ipa user-add** command
you must supply the **--password** flag (the command will prompt for the
password). The user ***must then change their password*** on first login.

Use the **ipa passwd** command to (re)set bob's password to ***test123***

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa passwd bob
  New Password:
  Enter New Password again to verify:
  ----------------------------------------
  Changed password for bob@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
  ----------------------------------------
</pre>

```bash
ipa passwd bob
```

Whenever a user has their password reset (including the first time
it is set), the next **kinit** will prompt them to enter a new
password.

Now try to authenticate as bob using kinit. You should see something
like the following:

When prompted for a password for bob, use **redhat2024**
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
kinit bob
Password for bob@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]:
Password expired.  You must change it now.
Enter new password:
Enter it again:
</pre>

If you didn't get this result, what do you think happened.
**HINT**: run klist

Who are you logged in as?

You can use ``kdestroy`` to logout the current session and
``kdestroy -A`` to logout all sessions.

If you were unsuccessful the first time, make sure you are
logged in a admin. Try to reset the password for bob, kinit
as bob again.

If you are logged in as **bob**, you can see that he has a
kerberos Ticket Granting Ticket (TGT). Run ``klist`` to confirm.
The current shell can use this to authenticate to other hosts
and services. Try logging into the other host you have configured
using ssh. If you are on the client tab, try to log into the server;
if you are on the server tab, try to log into the client.

```bash
ssh bob@idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]]
```
OR

```bash
ssh bob@idmserver1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]]
```

You should see somthing similar to the following:
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[bob@idmclient1 ~]$
</pre>

Verify that you are in the home directory for **bob**
```bash
pwd
```
You should see:

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
[bob@idmclient1 ~]$ pwd
/home/bob
[bob@idmclient1 ~]$
</pre>

You are now logged into the client as *bob*.  Type **Ctrl+D** or
**exit** to log out and return to the previous shell.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
logout
Connection to idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] closed.
</pre>

If you run *klist* again, you will see not only the TGT but a **service ticket**
that was automatically acquired to log in to
*idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]]*
without prompting for a password.  Kerberos
is a true **single sign-on** protocol!

Try that now. You should see output similar to the following:

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
klist
  Ticket cache: KEYRING:persistent:1000:1000
  Default principal: bob@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]

  Valid starting       Expires              Service principal
  06/04/2018 21:45:50  06/05/2018 21:38:24  host/idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]]@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
  06/04/2018 21:38:41  06/05/2018 21:38:24  krbtgt/[[ Instruqt-Var key="realm" hostname="idmserver1" ]]@[[ Instruqt-Var key="realm" hostname="idmserver1" ]]
</pre>

Logout of all sessions using **kdestroy**
```bash
kdestroy -A
```

When you klist, you will see ``klist: Credentials cache 'KCM:0' not found``

Now try to kinit as ***alice***

```bash
kinit alice
```

Make sure that ***alice*** can authenticate with the password ***redhat2024***

Now that you have created some users, it's time to define some
access policies.
