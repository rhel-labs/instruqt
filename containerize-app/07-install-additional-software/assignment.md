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
Installed:
  apr-1.7.0-11.el9.x86_64                         apr-util-1.6.1-20.el9_2.1.x86_64              
  apr-util-bdb-1.6.1-20.el9_2.1.x86_64            apr-util-openssl-1.6.1-20.el9_2.1.x86_64      
  httpd-2.4.53-11.el9_2.5.x86_64                  httpd-core-2.4.53-11.el9_2.5.x86_64           
  httpd-filesystem-2.4.53-11.el9_2.5.noarch       httpd-tools-2.4.53-11.el9_2.5.x86_64          
  libbrotli-1.0.9-6.el9.x86_64                    mailcap-2.1.49-5.el9.noarch                   
  mod_http2-1.15.19-4.el9_2.4.x86_64              mod_lua-2.4.53-11.el9_2.5.x86_64              
  redhat-logos-httpd-90.4-1.el9.noarch           

Complete!
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
