---
slug: installation
id: dfnx1jnxvbhy
type: challenge
title: Installation
notes:
- type: text
  contents: |+
    # Goal:
    After completing this scenario, users will be able to create customized Red Hat Enterprise Linux images using the `composer-cli` command.

    # Concepts included in this scenario:
    * Creating a custom blueprint to use for machine image creation
    * Building a custom Red Hat Enterprise Linux machine image
    * Monitoring the image build process
    * Validate the completed machine image

    # Example Usecase:
    Using the Image Builder commandline interface to make system images would be a
    consistent, repeatable, automatable way to build the same machine images, but
    output the image to different cloud formats for use in a hybrid cloud
    environment.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
---
# Install and enable required software

Before you start building images with image builder, the software required to
perform the tasks must be installed on the system.  Specifically, the
`composer-cli` package which provides the `composer-cli` command, and the
`osbuild-composer` package which provides the back-end service used to produce
the virtual machine images.

```
dnf install -y composer-cli osbuild-composer
```

<pre class='file'>
<<< OUTPUT ABRIDGED >>>

============================================================================================================================================================
 Package                                  Architecture          Version                               Repository                                       Size
============================================================================================================================================================
Installing:
 osbuild-composer                         x86_64                76-2.el9_2.2                          rhel-9-for-x86_64-appstream-rpms                 24 k
 weldr-client                             x86_64                35.9-1.el9                            rhel-9-for-x86_64-appstream-rpms                3.0 M
Installing dependencies:
 fuse                                     x86_64                2.9.9-15.el9                          rhel-9-for-x86_64-baseos-rpms                    84 k
 osbuild                                  noarch                81-1.el9_2.1                          rhel-9-for-x86_64-appstream-rpms                156 k

<<< OUTPUT ABRIDGED >>>

Complete!
</pre>

Now that the software has been successfully installed on the system, you also need to activate the `osbuild-composer` service so that the `composer-cli`
command can interact with the service that is responsible for queuing and creating the machine images.

```
systemctl enable --now osbuild-composer.socket
```

<pre class='file'>
Created symlink /etc/systemd/system/multi-user.target.wants/osbuild-composer.socket → /usr/lib/systemd/system/osbuild-composer.socket.
</pre>

Now that the service is accessible, you are ready to start working with image builder to create machine images.
