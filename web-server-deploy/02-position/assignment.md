---
slug: position
id: babmpgm0pzke
type: challenge
title: Starting the web server
tabs:
- id: kw8zxw8rlh8w
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: 704amk9iryeg
  title: Website
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: ""
timelimit: 1
---
You installed the web server software in the previous step, however it is not yet running on the machine.
You can verify this by checking the web service's status:

```bash,run
systemctl status httpd --no-pager
```

<pre class="file">
○ httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; preset: disabled)
     Active: inactive (dead)
       Docs: man:httpd.service(8)
</pre>

Of particular note in the above command output is the status of `incactive (dead)`.  Additionally, the service shows as `disabled`, which means the service is not automatically started at boot.

Start the service and configure it to automatically start when the system is booted.

```bash,run
systemctl enable --now httpd
```

By re-running the status command, you can now see that the service is both `running` and `enabled`.

```bash,run
systemctl status httpd --no-pager
```

The Apache web server runs as a pool of worker processes.  It can service multiple, simultaneous requests for web pages by managing them through a collection of web server processes.  Now that the service is running you can inspect the pool by querying your Linux system's processes and only showing those that contain the name `httpd`.

```bash,run
ps aux | grep [h]ttpd
```

<pre class="file">
root        3553  0.0  0.3  20204 11348 ?        Ss   00:56   0:00 /usr/sbin/httpd -DFOREGROUND
apache      3554  0.0  0.1  22032  6980 ?        S    00:56   0:00 /usr/sbin/httpd -DFOREGROUND
apache      3555  0.0  0.4 981452 15904 ?        Sl   00:56   0:00 /usr/sbin/httpd -DFOREGROUND
apache      3556  0.0  0.4 981452 15904 ?        Sl   00:56   0:00 /usr/sbin/httpd -DFOREGROUND
apache      3557  0.0  0.4 1112588 18092 ?       Sl   00:56   0:00 /usr/sbin/httpd -DFOREGROUND
apache      3735  0.0  0.4 981452 15008 ?        Sl   00:59   0:00 /usr/sbin/httpd -DFOREGROUND
</pre>

In the above output, you can see there are several httpd processes on your system.  One of them is owned by <b>root</b>, which is the administrative user on the system and handles traffic flow into the web server.  The rest are owned by the <b>apache</b> user, these are the worker processes.  In this `ps` command output you also see additional information like the unique process ID number of each process, the amount of CPU and Memory consumed by each process, it's current status, and other system and diagnostic information about each of these instances of the `httpd` program.

Lastly, you should now be able to select the <b>Website</b> tab at the top of the interface and see the Test Page being served by your system's running web server.