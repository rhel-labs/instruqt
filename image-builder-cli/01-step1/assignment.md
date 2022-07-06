---
slug: step1
id: dfnx1jnxvbhy
type: challenge
title: Step 1
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
difficulty: basic
timelimit: 600
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

==========================================================================================================================================
 Package                            Arch      Version                                           Repository                           Size
==========================================================================================================================================
Installing:
 composer-cli                  x86_64       28.14.58-1.el8                                    rhel-8-for-x86_64-appstream-rpms        86 k
 osbuild-composer              x86_64       28.4-1.el8                                        rhel-8-for-x86_64-appstream-rpms        19 k
Installing dependencies:
 bubblewrap                    x86_64       0.4.0-1.el8                                       rhel-8-for-x86_64-baseos-rpms           50 k
 fuse                          x86_64       2.9.7-12.el8                                      rhel-8-for-x86_64-baseos-rpms           83 k

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
