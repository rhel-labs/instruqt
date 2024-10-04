---
slug: administer
id: eenmpzvvlzpp
type: challenge
title: Administer the container
tabs:
- id: togzfvjxx3vl
  title: Podman
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "podman" > /dev/null 2>&1
- id: z9bbhvaxg9rx
  title: RHEL Host
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "host" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Switch back to the `Podman` tab.  Exit the container's shell

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

<a href="#example_image">
 <img alt="An example image" src="../assets/stopped-container.png" />
</a>

<a href="#" class="lightbox" id="example_image">
 <img alt="An example image" src="../assets/stopped-container.png" />
</a>

Notice the __STATUS__ field is now reported as Exited.

A container in this state can be resumed, however, this one will no longer be used.  You will remove it from the system. using __podman rm <CONTAINER ID>__.  In the command below, we use a bit of bash scripting to determine the CONTAINER ID as it is unique to each container image.

```bash
podman rm $(podman ps -a | grep Exited | cut -d" " -f1)
```

The output of this removal is the full CONTAINER ID which was removed from the system.

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
