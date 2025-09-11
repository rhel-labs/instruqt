---
slug: untitled-challenge-j8aa3p
id: taknj0l0tv6j
type: challenge
title: Install Ansible & System Roles
notes:
- type: text
  contents: |-
    Step 1: Configuring prerequisite repositories and packages.
    Lab Feedback
    If you would like to report any bugs or make suggestions on how we can improve our labs, please leave us a message here.

    YouTube
    For more information about Red Hat Enterprise Linux, we invite you to view our YouTube channel. red.ht/rhel-youtube

    If you are interested in learning critical administration skills for Red Hat Enterprise Linux, you might be interested in our show Into the Terminal.

    Here are our playlists. You can find various playlists on topics such as product updates and Satellite configuration and administration.

    Reddit
    Come find us on Reddit at r/redhat. https://www.reddit.com/r/redhat/
difficulty: ""
enhanced_loading: null
---
Red Hat Enterprise Linux System Roles are a collection of supported Ansible roles that ensure consistent workflows and streamline the execution of manual tasks.

First we'll install the rhel-system-roles package. Copy and paste the command below into > Shell.
```run
sudo dnf install ansible-core rhel-system-roles -y
```

Here's what the result should look similar to.
```nocopy
<<< OUTPUT ABRIDGED >>>

==========================================================================================================================================
Package                         Architecture        Version                        Repository                                       Size
==========================================================================================================================================
Installing:
 rhel-system-roles                   noarch         1.21.1-1.el9_2              rhel-9-for-x86_64-appstream-rpms         2.4 M
Installing dependencies:
 ansible-core                        x86_64         2.14.2-5.el9_2              rhel-9-for-x86_64-appstream-rpms         3.4 M
<<< OUTPUT ABRIDGED >>>
```

