---
slug: step3
id: eenmpzvvlzpp
type: challenge
title: Administer the container
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
timelimit: 1
---
Switch back to *Pane 0* by type `ctrl-b` and then the up arrow key.  Exit the container's shell

```bash
exit
```

When the process on an interactive container is closed, the container stops running.  You can verify this by looking at the list of container processes:

```bash
podman ps -a
```

<pre class="file">
CONTAINER ID  IMAGE                         COMMAND    CREATED      STATUS                    PORTS  NAMES
df54b664f133  localhost/rhel9-httpd:latest  /bin/bash  2 hours ago  Exited (0) 5 seconds ago         heuristic_cray
</pre>

Notice the __STATUS__ field is now reported as Exited.

A container in this state can be resumed, however, this one will no longer be used.  You will remove it from the system. using __podman rm <CONTAINER ID>__.  In the command below, we use a bit of bash scripting to determine the CONTAINER ID as it is unique to each container image.

```bash
podman rm $(podman ps -a | grep Exited | cut -d" " -f1)
```

The output of this removal is the full CONTAINER ID which was removed from the system.
