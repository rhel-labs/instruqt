---
slug: create-from-scratch-contd
id: 2kckmwxzcjim
type: challenge
title: Creating an application image from scratch
tabs:
- id: yf7inbytbila
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "buildah-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
In order to install `httpd` in the scratch container, use `yum` on the host with the `installroot` option targeting the mount point of the container's filesystem.

> _NOTE:_ Setting the `releasever` and `module_platform_id` are required as this will be operating in a chroot environment where `yum` config files are not available.

```bash,run
yum install --installroot ${scratchmnt} httpd --releasever 9 --setopt=module_platform_id="platform:el9" -y
```

<pre class="file">
Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)               2.4 MB/s | 7.0 MB     00:02
Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)                  1.3 MB/s | 3.7 MB     00:02
Red Hat Enterprise Linux 9 for x86_64 - Supplementary (RPMs)            23 kB/s |  78 kB     00:03
Last metadata expiration check: 0:00:01 ago on Fri 17 May 2019 03:41:34 PM EDT.
Dependencies resolved.
=======================================================================================================
 Package                 Arch   Version                         Repository                        Size
=======================================================================================================
Installing:
 httpd                   x86_64 2.4.37-11.module+el9.0.0+2969+90015743
                                                                rhel-9-for-x86_64-appstream-rpms 1.4 M

<< OUTPUT ABRIDGED >>

Complete!
</pre>

This method installs more packages than using the pre-built base image, but we have `httpd` and `systemd` but not other typical system tools like `yum`.

To enable `httpd` to start when the container is run using systemd, use the following `buildah` command.

```bash,run
buildah run working-container systemctl enable httpd
```

<pre class="file">
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
</pre>

Deploying web content to the container image can be done using a `cp` command on the host to the working container mount point. We've included an html index file in /root called `index2.html`.

```bash,run
cp index2.html ${scratchmnt}/var/www/html/index.html
```

After installing packages and adding the index file, unmount the filesystem with the `buildah unmount` subcommand.

```bash,run
buildah unmount working-container
```

To expose the web server port and set systemd to start when the container is run, modify the metadata with the `buildah config` subcommand.

```bash,run
buildah config --port 80 --cmd "/usr/sbin/init" working-container
```

These options to `buildah config` are equivalent to the EXPOSE and CMD directives in a Containerfile.

> _NOTE:_  As we're using systemd to start the service, use the `--cmd` option not `--entrypoint`.

Once the contents of the working container are complete, and the metadata has been updated, save the working container as the target application image using `buildah commit`.

```bash,run
buildah commit working-container el-httpd2
```

<pre class="file">
Getting image source signatures
Copying blob sha256:273497ce3451052db7cc333d8e90c259314f9cb8d6d4f7a5b865656f65c24083
 162.17 MiB / 162.17 MiB [==================================================] 6s
Copying config sha256:a3c678a7d7c63edbac6e57a86da11ff4d916c0734bcbea9cfd55ae2b515275b9
 308 B / 308 B [============================================================] 0s
Writing manifest to image destination
Storing signatures
a3c678a7d7c63edbac6e57a86da11ff4d916c0734bcbea9cfd55ae2b515275b9
</pre>

In this example, all operations were done directly to the container filesystem, resulting in a single layer.  The `buildah commit` step can be run at any point where a layer is needed, for example to cache a common set of packages across multiple applications.
