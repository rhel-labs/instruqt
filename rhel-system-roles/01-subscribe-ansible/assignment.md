---
slug: subscribe-ansible
id: hgfyzlfmhsem
type: challenge
title: Add the Ansible repository.
teaser: Add the Ansible repository to your server.
notes:
- type: text
  contents: |
    # Step 1: Configuring prerequisite repositories and packages.

    # Lab Feedback
      If you would like to report any bugs or make suggestions on how we can improve our labs, [please leave us a message here](https://github.com/rhel-labs/instruqt/discussions/categories/general).

      # YouTube
      For more information about Red Hat Enterprise Linux, we invite you to view our [YouTube channel]([**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)). [**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)

      If you are interested in learning critical administration skills for Red Hat Enterprise Linux, you might be interested in our show [Into the Terminal](https://www.youtube.com/playlist?list=PLXJyD2dL4oqeX-C3MvsMUJuEzWM4vLK2C).

      Here are our [playlists](https://www.youtube.com/@RedHatEnterpriseLinux/playlists). You can find various playlists on topics such as product updates and Satellite configuration and administration.

      # Reddit
      Come find us on Reddit at r/redhat.
      https://www.reddit.com/r/redhat/
tabs:
- id: c4ydyvsxbqbe
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: bmz0iripeoi1
  title: client1
  type: terminal
  hostname: client1
difficulty: basic
timelimit: 3000
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

First we'll install the `rhel-system-roles` package. Copy and paste the command below into __> Shell__.

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