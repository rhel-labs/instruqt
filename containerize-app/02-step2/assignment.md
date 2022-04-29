---
slug: step2
id: xz5d9zx17xlq
type: challenge
title: Positioning yum Repository
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 60
---
In this lab, you are going to containerize a software package that is already
packaged in RPM format and stored in the Extra Packages for Enterprise Linux
(EPEL) repository.

Software often has requirements for prerequisite software that must be installed
on the machine in order for it to work properly.  `yum` will resolve those
dependencies for you, as long as it is able to locate the required packages in
repositories defined on the machine.  The Red Hat Universal Base Image (UBI)
downloaded in the previous step has access to some Red Hat Enterprise Linux
repositories.  However, the target package for the lab is from EPEL.  In
this step you will install the EPEL repository inside the container working
image.

In the command below, `buildah` is going to run a command on the
`ubi-working-container` image.  The `--` indicates that the command should be
executed from within the container, which means the results will be applied into
the container image.  Lastly, you are providing the `yum` command to install a
package that defines all of the repositories from EPEL, `epel-release-latest-8`.

```bash
buildah run ubi-working-container -- yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
```

<pre class="file">
<<< OUTPUT ABRIDGED >>>

==========================================================================================================================================
 Package                            Architecture                 Version                         Repository                          Size
==========================================================================================================================================
Installing:
 epel-release                       noarch                       8-10.el8                         @commandline                        22 k

<<< OUTPUT ABRIDGED >>>

Installed:
  epel-release-8-10.el8.noarch

Complete!
</pre>

From the above output, you can see that the epel-release RPM was installed
successfully inside the container.  You could verify this was not completed
on the host by looking for the RPM on the host system.

```bash
rpm -q epel-release
```

<pre class="file">
package epel-release is not installed
</pre>

If your repository configurations are not distributed as an RPM, but instead as
individual `.repo` files, you could use the `buildah copy` command to copy
files from the host operating system into the container image.  You will see
an example of using `buildah copy` later in this lab.
