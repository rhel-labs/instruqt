---
slug: hostbasedaccesscontrol
id: eh5ktd4isetr
type: challenge
title: Host Based Access Control
teaser: Controlling user access to systems
notes:
- type: text
  contents: |
    ## Host Based Access Control

    The centralization of user and host identities generates great benefits. One of those is the ability to map user access efficiently to hosts. This is the basis of the IdM feature Host-Based Access Control (HBAC). HBAC allows adminstrators to easily align user and group identity with the hosts and host groups that they need to access to accomplish their job function. As a system administrator, you can use HBAC rules to achieve the following goals:

    - Limit access to a specified system in your domain to members of a specific user group.
    - Allow only a specific service to be used to access systems in your domain.

    In this exercise we will create rules that control how user accounts interacted with systems.
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
## Welcome to challenge 4


### Managing Host Based Access Control (HBAC) policy

The Host Based Access Control (HBAC) features in IdM allow administrators to define policy to control **who** has access **which hosts** (or host groups) using **which services** (or service group). As you might imagine you could create a fair degree of configuration complexity using HBAC, so the HBAC system also allows you to run tests against these configuration to ensure that they behave as expected.

> ASIDE: The redhat.rhel_idm ansible collection is available to automate all configuration of Identity Management, from installation, and initial configuration to day to day tasks. Being able to treat this configuation as code is hugely valuable, allowing for repeatability and most importantly testability!

<hr>

### Exercise 4.1 - Creating a Host Group

Our lab is very simple and it isn't necessary to create a host group to implement an HBAC policy, however, this is good practice. As your environment grows, it becomes simple to add the system to the hostgroup and then inherit the rules. This is the same advantage user groups provide for managing users.

Both the Web UI and the CLI can be used complete the following tasks. You can choose. The CLI commands will be provided below. See if you can perform the tasks by investigating the UI or the CLI rather than simply using cut and paste.

- create a host group called production
- create a second host group called development
- add idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] to the production host group

If you are using the command line, here are the tasks. Note that this takes two commands to perform this. If you guessed that we use the *ipa hostgroup* topic, you are correct!

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa help hostgroup
Groups of hosts.

Manage groups of hosts. This is useful for applying access control to a
number of hosts by using Host-based Access Control.

EXAMPLES:

 Add a new host group:
   ipa hostgroup-add --desc="Baltimore hosts" baltimore

 Add another new host group:
   ipa hostgroup-add --desc="Maryland hosts" maryland

 Add members to the hostgroup (using Bash brace expansion):
   ipa hostgroup-add-member --hosts={box1,box2,box3} baltimore
...
</pre>

First, create the host group. Adding a description that identifies the reason for grouping systems together is a good practice. When you start automating these processes with Ansible Automation, it makes for self documenting code and configuration.

```bash
ipa hostgroup-add --desc "Production Servers" production
```

Create the **development** host group with a description **Development Servers** using the same process

```bash
ipa hostgroup-add --desc "Development Servers" development
```

You can list all the hostgroups using the hostgroup-find command with no arguments.

```bash
ipa hostgroup-find
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
--------------------
3 hostgroups matched
--------------------
  Host-group: development
  Description: Development Servers

  Host-group: ipaservers
  Description: IPA server hosts

  Host-group: production
  Description: Production Servers
----------------------------
Number of entries returned 3
----------------------------
</pre>

ipaservers is a builtin hostgroup for the IdM domain controllers.

Now let's add our client system to the production host group.

```bash
ipa hostgroup-add-member --hosts=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] production
```

Verify that you see host in the host group.

```bash
ipa hostgroup-show production
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hostgroup-show production
  Host-group: production
  Description: Production Servers
  Member hosts: idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]]
</pre>

Now that we have host groups it becomes easier to manage systems and maintain our HBAC rules.

<hr>

### HBAC Services, Service Groups, and Rules

Systems have a wide variety of ways that you can interact with them, we can login at a console, we can ssh to them, we can even run cron jobs as a user on them. In order to manage how a user interacts with systems we need to define the **ways** in which the user can access the systems. This brings in the notion of HBAC services - the **ways**. HBAC Service Groups allow us to make it *easier* to manage this. We can group the services that we want to manage together. Luckily, IdM comes preloaded with the common services and service groups. You can investigate them in the Web UI. Navigate to:

Policy > Host-Based Access Control and select HBAC Services or HBAC Service Groups from the drop down to display the lists.

Of course, you can define your own services and service groups.

<hr>

### Exercise 4.2 - Creating HBAC Rules

If you select "HBAC Rules" you are presented with a list with only two rules **allow_all** and **allow_systemd-user**. The allow_all rule does exactly what you would think, it allows all users to access any host from any host using any service. The **allow_systemd-user** rules is present to ensure that systemd can still create a users session when allow_all is disabled. 

To start creating our own HBAC rules we will create another rule called **admins_allow_all**

We will set this up so that only the admins group is allowed to access all systems just the same as the allow_all rule. Once that is accomplished and our admins can't get locked out, we will **disable** the allow_all rule. We do **not** want to disable **allow_systemd-user**.

Again you can choose to use the Web UI to accomplish this task or use the CLI.

- create an HBAC rule named **admins_allow_all** with a discription **Administrators all access pass** that allows the **admins** user group access to any host using any service.
- disable the **allow_all** rule.

If you are using the CLI, you can use the ipa command to give you hints. Follow the pattern that we have been learning:
ipa **topic-action**, so for this exercise **ipa hbacrule-add --help**

```bash
ipa hbacrule-add --help
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hbacrule-add --help
Usage: ipa [global-options] hbacrule-add NAME [options]

Create a new HBAC rule.
Options:
  -h, --help            show this help message and exit
  --usercat=['all']     User category the rule applies to
  --hostcat=['all']     Host category the rule applies to
  --servicecat=['all']  Service category the rule applies to
  --desc=STR            Description
...
</pre>

Let's use this to create our admins_all_all rule.

```bash
ipa hbacrule-add --desc "Administrators all access pass" --hostcat="all" --servicecat="all" admins_allow_all
```

Ensure that our idm admins and system admins are allowed to login to all systems

```bash
ipa hbacrule-add-user --groups=admins --groups=sysadmins admins_allow_all
```

Verify the rule looks as you expect

```bash
ipa hbacrule-show admins_allow_all
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hbacrule-show admins_allow_all
  Rule name: admins_allow_all
  Host category: all
  Service category: all
  Description: Administrators all access pass
  Enabled: TRUE
  User Groups: admins, sysadmins
</pre>

Now disable the allow_all rule.

```bash
ipa hbacrule-disable allow_all
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
------------------------------
Disabled HBAC rule "allow_all"
------------------------------
</pre>

That was easy!

<hr>

### Exercise 4.3 - Testing HBAC Rules

To test our HBAC rules, it is not practical to impersonate a user and try to login to each system with each protocol and log the results. We need a testing tool... ipa hbactest to the rescue.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hbactest --help
Usage: ipa [global-options] hbactest [options]

Simulate use of Host-based access controls
Options:
  -h, --help       show this help message and exit
  --user=STR       User name
  --host=STR       Target host
  --service=STR    Service
  --rules=STR      Rules to test. If not specified, --enabled is assumed
  --nodetail       Hide details which rules are matched, not matched, or
                   invalid
  --enabled        Include all enabled IPA rules into test [default]
  --disabled       Include all disabled IPA rules into test
  --sizelimit=INT  Maximum number of rules to process when no --rules is
                   specified
</pre>

Since **bob** is not in any rules, lets see what happens for **bob**

```bash
ipa hbactest --user=bob --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=all
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
ipa hbactest --user=bob --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=all
---------------------
Access granted: False
---------------------
  Not matched rules: admins_allow_all
  Not matched rules: allow_systemd-user
</pre>

What about **alice** can she access the client host?

```bash
ipa hbactest --user=alice --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=all
```

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
 ipa hbactest --user=alice --host=idmclient1.[[ Instruqt-Var key="domain" hostname="idmserver1" ]] --service=all
--------------------
Access granted: True
--------------------
  Matched rules: admins_allow_all
  Not matched rules: allow_systemd-user
</pre>

Now try at the command line to ssh from idmserver1 in your environment to idmclient1 as ***bob***. What happens?
Now try at the command line to ssh from the idmserver in your environment to idmclient1 as ***alice***. What happens?

Is this what you expected?

You have successfully completed the section on HBAC rules. Let's look at sudo rules next.
