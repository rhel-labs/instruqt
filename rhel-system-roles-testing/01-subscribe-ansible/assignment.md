---
slug: subscribe-ansible
id: bd9jadyg5eso
type: challenge
title: Add the Ansible repository.
teaser: Add the Ansible repository to your server.
notes:
- type: text
  contents: 'Step 1: Configuring prerequisite repositories and packages.'
tabs:
- id: sdciayjfsyjv
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: ja7fvvgjsx7a
  title: client1
  type: terminal
  hostname: client1
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

First we'll install the `rhel-system-roles` package. Click the run button to run the command in the __> Shell__.

```bash,run
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