---
slug: subscribe-ansible
id: iwjacczlj7mj
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
- id: vl2s7es3aspr
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: 8fj8wqqotrqy
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 3000
enhanced_loading: null
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

We have already installed "rhel-system-roles" and “ansible-core” for this lab.

You can check to see what version of `rhel-system-roles` package are installed with the command below. Copy and paste the command below into __> Shell__.

```bash,run
sudo dnf list rhel-system-roles ansible-core
```

Here's what the result should look similar to.

<pre>
<<< OUTPUT ABRIDGED >>>
Installed Packages
ansible-core.noarch    1:2.16.14-1.el10    @rhel-10-for-x86_64-appstream-rpms
rhel-system-roles.noarch    1.95.7-0.1.el10_0    @rhel-10-for-x86_64-appstream-rpms

<<< OUTPUT ABRIDGED >>>
</pre>
With our packages installed lets head to the next step.
