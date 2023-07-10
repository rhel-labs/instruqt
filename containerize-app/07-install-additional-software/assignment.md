---
slug: install-additional-software
id: quql4u07g26a
type: challenge
title: Install additional pre-requisite software
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: Containerized Web App
  type: service
  hostname: rhel
  path: /
  port: 8080
difficulty: basic
timelimit: 1
---
In this step, you will install web server software to support the web application you will position in the next step.

Install the apache web server from the configured UBI software repository.

```bash
buildah run ubi-working-container-1 -- dnf -y install httpd
```

<pre class=file>
<<< OUTPUT ABRIDGED >>>

================================================================================
 Package            Arch   Version       Repository                        Size
================================================================================
Installing:
 httpd              x86_64 2.4.37-47.module+el8.6.0+15654+427eba2e.2
                                         rhel-8-for-x86_64-appstream-rpms 1.4 M

<<< OUTPUT ABRIDGED >>>
</pre>

Next, enable the httpd service so that when the container starts, apache will also start.

```bash
buildah run ubi-working-container-1 -- systemctl enable httpd
```

<pre class=file>
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
</pre>

Configure the container to listen on port 80 so that traffic being sent to the container is being routed to the apache web server within the container.

```bash
buildah config --port 80 --cmd "/usr/sbin/init" ubi-working-container-1
```

In the next step, you will be positioning our github based application content into the container.
