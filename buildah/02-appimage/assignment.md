---
slug: appimage
id: vmy0cfk0cxdf
type: challenge
title: Creating an application image from an existing base
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "buildah-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 1
---
The `ubi-init` image is very complete, including tools like `yum` and `systemd`.  You can install `httpd` via `yum` in the container using the `buildah run` subcommand.

```bash
buildah run ubi-init-working-container -- yum -y install httpd
```

<pre class="file">
Updating Subscription Management repositories.
Unable to read consumer identity
Subscription Manager is operating in container mode.

This system is not registered with an entitlement server. You can use subscription-manager to register.

Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)                                       2.7 MB/s | 2.1 MB     00:00
Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)                                     10 MB/s | 7.8 MB     00:00
Red Hat Universal Base Image 9 (RPMs) - BaseOS                                              255 kB/s | 541 kB     00:02
Red Hat Universal Base Image 9 (RPMs) - AppStream                                           680 kB/s | 1.4 MB     00:02
Red Hat Universal Base Image 9 (RPMs) - CodeReady Builder                                   7.9 kB/s |  12 kB     00:01
Dependencies resolved.
============================================================================================================================
 Package                      Architecture     Version                     Repository                                  Size
============================================================================================================================
Installing:
 httpd                        x86_64           2.4.51-7.el9_0              rhel-9-for-x86_64-appstream-rpms           1.5 M
Installing dependencies:
 apr                          x86_64           1.7.0-11.el9                rhel-9-for-x86_64-appstream-rpms           127 k
 apr-util                     x86_64           1.6.1-20.el9                rhel-9-for-x86_64-appstream-rpms            98 k
 apr-util-bdb                 x86_64           1.6.1-20.el9                rhel-9-for-x86_64-appstream-rpms            15 k
 httpd-filesystem             noarch           2.4.51-7.el9_0              rhel-9-for-x86_64-appstream-rpms            17 k
 httpd-tools                  x86_64           2.4.51-7.el9_0              rhel-9-for-x86_64-appstream-rpms            88 k
 libbrotli                    x86_64           1.0.9-6.el9                 rhel-9-for-x86_64-baseos-rpms              317 k
 mailcap                      noarch           2.1.49-5.el9                rhel-9-for-x86_64-baseos-rpms               35 k
 redhat-logos-httpd           noarch           90.4-1.el9                  rhel-9-for-x86_64-appstream-rpms            18 k
Installing weak dependencies:
 apr-util-openssl             x86_64           1.6.1-20.el9                rhel-9-for-x86_64-appstream-rpms            17 k
 mod_http2                    x86_64           1.15.19-2.el9               rhel-9-for-x86_64-appstream-rpms           153 k
 mod_lua                      x86_64           2.4.51-7.el9_0              rhel-9-for-x86_64-appstream-rpms            63 k

<< OUTPUT ABRIDGED >>

Complete!
</pre>

This subcommand acts like the RUN directive in an Containerfile.  Since the `yum` command includes a switch `-y`, we need to use the `--` syntax to tell `buildah run` there are no buildah options to look for past this point.

Once the packages are installed in the working container, enable `httpd` to start when the container is run via systemd using the `buildah run` subcommand.

```bash
buildah run ubi-init-working-container -- systemctl enable httpd
```

<pre class="file">
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
</pre>

Deploying web content to the container image can be done using the `buildah copy` subcommand. In the /root directory we've included an html index file `index1.html`. Copy this file into the container with `buildah copy` with the command below.

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

Once the contents of the working container are complete, and the metadata has been updated, save the working container as the target application image using `buildah commit`. We are naming the contianer `el-httpd1`.

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
