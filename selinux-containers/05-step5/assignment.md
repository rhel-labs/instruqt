---
slug: step5
id: zsbeponiarc1
type: challenge
title: Re-inspect the running container
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Terminal 2
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 240
---
In 'Pane 1' of the lab interface, exec into the running container and start a bash shell

```bash
podman exec -t -i $CONTAINER /bin/bash
```

Check whether container has access to the */home* directory

```bash
cd /home/; ls
```

<pre class="file">
bas  gke-930957db5604c7804fbd  gke-f34473de869e40d6894d  mochtar  myee  rhel
</pre>

This is now successful since there is an allow rule in place that tells SELinux to allow this action.

Check whether container has read access to the */var/spool/* directory

```bash
cd /var/spool/; ls
```

<pre class="file">
anacron  cron  lpd  mail  plymouth  rhsm
</pre>

Similarly, this is also successful because there is an allow rule in place that tells SELinux to allow this action.

Check whether container has write access to the /var/spool/ directory

```bash
touch test; ls
```

<pre class="file">
anacron  cron  lpd  mail  plymouth  rhsm  test
</pre>

Install the netcat (nc) package inside the container to test for port bindings

```bash
yum install -y nc
```

Tell nc to listen on port 80 inside the container, and timeout after 5 seconds.

```bash
timeout 5s nc -lvvp 80
```

<pre class="file">
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::80
Ncat: Listening on 0.0.0.0:80
</pre>

You can see from the above output that netcat was able to connect and listen on port 80. This is successful
because there is a allow rule in place that tells SELinux to allow this network action on port 80.

Tell nc to listen on port 8080 inside the container, and timeout after 5 seconds.

```bash
timeout 5s nc -lvvp 8080
```

<pre class="file">
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: bind to :::8080: Permission denied. QUITTING.
</pre>

You can see from the above output that netcat was NOT able to connect and listen on port 8080. There is no allow
rule in place that tells SELinux to allow this operation, and hence it was blocked by SELinux.
