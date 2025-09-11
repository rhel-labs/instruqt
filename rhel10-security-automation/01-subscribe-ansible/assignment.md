---
slug: subscribe-ansible
id: uxq9jizpuk7e
type: challenge
title: 'Step 1: Install Ansible & System Roles'
teaser: Add the Ansible And System Roles to your server.
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
- id: dmhzx57cy7vw
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: okvwziwj0myu
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 3000
enhanced_loading: null
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

We have already installed "rhel-system-roles" for this lab.

You can check to see what version of `rhel-system-roles` package are installed with the command below. Copy and paste the command below into __> Shell__.

```bash,run
sudo dnf info  rhel-system-roles
```

Here's what the result should look similar to.

<pre>
<<< OUTPUT ABRIDGED >>>

==========================================================================================================================================
Package                         Architecture        Version                        Repository                                       Size
==========================================================================================================================================
Installing:
 rhel-system-roles                   noarch         1.95.7-0.1.el9_6             rhel-9-for-x86_64-appstream-rpms         2.6 M
Installing dependencies:
 ansible-core                        x86_64        1: 2.14.18-1.el9              rhel-9-for-x86_64-appstream-rpms         4.2 M
<<< OUTPUT ABRIDGED >>>
</pre>
With our packages installed lets head to the next step.
