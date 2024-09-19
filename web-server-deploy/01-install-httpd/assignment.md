---
slug: install-httpd
id: bv4zx9bj8kyn
type: challenge
title: Installing Web Server Software
notes:
- type: text
  contents: |
    # Goal:
    After completing this lab, you will have installed and run a web server on Red Hat Enterprise Linux.

    # Concepts included in this scenario:
    * Installing web server software
    * Starting and controlling services
    * Editing website content
    * Deploying website content and web applications

    # Example Usecase:

    You need to publish a new website.  Some of this site may be static page content, while another part is a javascript application.
tabs:
- id: 2b2jhyxjs1js
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: ""
timelimit: 3000
---
Software in Red Hat Enterprise Linux is packaged in a format called RPM.  These
packages contain compiled, binary applications that are ready to run after being
installed on your system.  However, applications can be complex and require other
applications or libraries in order to run.  You will use a command called DNF which
will analyze RPM package files to install not just the requested package, but all it's
required dependencies on the system.

Install the Apache Web Server software, httpd (hyper text transfer protocal daemon):

```bash,run
dnf -y install httpd
```

<pre class="file">
<<< OUTPUT ABRIDGED >>>

Installed:
  apr-1.7.0-12.el9_3.x86_64                   apr-util-1.6.1-23.el9.x86_64           apr-util-bdb-1.6.1-23.el9.x86_64
  apr-util-openssl-1.6.1-23.el9.x86_64        httpd-2.4.57-11.el9_4.1.x86_64         httpd-core-2.4.57-11.el9_4.1.x86_64
  httpd-filesystem-2.4.57-11.el9_4.1.noarch   httpd-tools-2.4.57-11.el9_4.1.x86_64   mailcap-2.1.49-5.el9.noarch
  mod_http2-2.0.26-2.el9_4.x86_64             mod_lua-2.4.57-11.el9_4.1.x86_64       redhat-logos-httpd-90.4-2.el9.noarch

Complete!
</pre>

From the output above, you can see that the the package, httpd was installed as were
several required pieces of additional software.
