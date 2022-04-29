---
slug: step2
id: vmy0cfk0cxdf
type: challenge
title: Creating an application image from an existing base
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
timelimit: 100
---
The `ubi-init` image is very complete, including tools like `yum` and `systemd`.  You can install `httpd` via `yum` in the container using the `buildah run` subcommand.

```bash
buildah run ubi-init-working-container -- yum -y install httpd
```

<pre class="file">
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)               2.4 MB/s | 7.0 MB     00:02
Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)                  1.3 MB/s | 3.7 MB     00:02
Red Hat Enterprise Linux 8 for x86_64 - Supplementary (RPMs)            23 kB/s |  78 kB     00:03
Last metadata expiration check: 0:00:01 ago on Fri 17 May 2019 03:41:34 PM EDT.
Dependencies resolved.
=======================================================================================================
 Package                 Arch   Version                         Repository                        Size
=======================================================================================================
Installing:
 httpd                   x86_64 2.4.37-30.module+el8.0.0+2969+90015743
                                                                rhel-8-for-x86_64-appstream-rpms 1.4 M

<< OUTPUT ABRIDGED >>

Complete!
</pre>

This subcommand acts like the RUN directive in an Containerfile.  Since the `yum` command includes a switch, we need to use the `--` syntax to tell `buildah run` there are no buildah options to look for past this point.

Once the packages are installed in the working container, enable `httpd` to start when the container is run via systemd using the `buildah run` subcommand.

```bash
buildah run ubi-init-working-container -- systemctl enable httpd
```

<pre class="file">
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
</pre>

Deploying web content to the container image can be done using the `buildah copy` subcommand.

```bash
buildah copy ubi-init-working-container index1.html /var/www/html/index.html
```

This subcommand acts like the COPY directive in a Containerfile.

To expose the web server port and set systemd to start when the container is run, modify the metadata with the `buildah config` subcommand.

```bash
buildah config --port 80 --cmd "/usr/sbin/init" ubi-init-working-container
```

These options to `buildah config` are equivalent to the EXPOSE and CMD directives in a Containerfile.

> _NOTE:_  As we're using systemd to start the service, use the `--cmd` option not `--entrypoint`.

Once the contents of the working container are complete, and the metadata has been updated, save the working container as the target application image using `buildah commit`.

```bash
buildah commit ubi-init-working-container el-httpd1
```

<pre class="file">
Getting image source signatures
Skipping fetch of repeat blob sha256:24d85c895b6b870f6b84327a5e31aa567a5d30588de0a0bdd9a669ec5012339c
Skipping fetch of repeat blob sha256:c613b100be1645941fded703dd6037e5aba7c9388fd1fcb37c2f9f73bc438126
Skipping fetch of repeat blob sha256:188ab351dfda8afc656a38073df0004cdc5196fd5572960ff5499c17e6442223
Copying blob sha256:8df24355b15ad293a5dd60d0fe2c14dca68b0412b62f9e9c39c15bb8230d1936
 26.80 MiB / 26.80 MiB [====================================================] 0s
Copying config sha256:b04fe2c73b034e657da2fee64c340c56086a38265777556fa8a02c5f12896e66
 2.42 KiB / 2.42 KiB [======================================================] 0s
Writing manifest to image destination
Storing signatures
b04fe2c73b034e657da2fee64c340c56086a38265777556fa8a02c5f12896e66
</pre>

In this example, each previous `buildah` subcommand results in a separate layer, much like building using a Containerfile.
