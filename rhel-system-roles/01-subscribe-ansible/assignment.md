---
slug: subscribe-ansible
id: hgfyzlfmhsem
type: challenge
title: Add the Ansible repository.
teaser: Add the Ansible repository to your server.
notes:
- type: text
  contents: 'Step 1: Configuring prerequisite repositories and packages.'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
- title: client1
  type: terminal
  hostname: client1
- title: client2
  type: terminal
  hostname: client2
difficulty: basic
timelimit: 3000
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

First we'll install the `rhel-system-roles` package. Copy and paste the command below into __> Shell__.

```bash
dnf -y install rhel-system-roles
```

Here's what the result should look similar to.

<pre>
<<< OUTPUT ABRIDGED >>>

==========================================================================================================================================
Package                         Architecture        Version                        Repository                                       Size
==========================================================================================================================================
Installing:
 rhel-system-roles                   noarch         1.21.1-1.el9_2              rhel-9-for-x86_64-appstream-rpms         2.4 M
Installing dependencies:
 ansible-core                        x86_64         2.14.2-5.el9_2              rhel-9-for-x86_64-appstream-rpms         3.4 M
<<< OUTPUT ABRIDGED >>>
</pre>