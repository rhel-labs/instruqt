---
slug: cli-container-management
id: wtgula3lfz4q
type: challenge
title: Podman Container Management
tabs:
- id: nrqjosnyxrn4
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: hexrpipnbine
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- id: pv1fnlu2xoqs
  title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 3000
---
Now you will set up a new Grafana container, but this time, you will do so through the Podman command line interface (CLI).
Next, download and start a Podman image for Grafana with this command:
```bash
podman run -d --name=Grafana -p 3000:3000 docker.io/grafana/grafana:latest
```
>Explanation of the command you just ran:
>* `--name=Grafana` specifies the name of your container.
>* `-p 3000:3000` specifies that the container should connect through the host's port 3000 and the container's port 3000.
>* `docker.io/grafana/grafana:latest` is the URL of the dockerfile that your container is based on. `Grafana/grafana` is the name of the image and `:latest` indicates that you want the most recent version. This allows Podman to retrieve the correct container.

Finally, run this command to view your containers in Podman:
```bash
podman ps
```
The output should look like this, although the Container ID will differ:
<pre class="file">
CONTAINER ID  IMAGE                             COMMAND     CREATED         STATUS         PORTS                   NAMES
35079bc79503  docker.io/grafana/grafana:latest              17 seconds ago  Up 17 seconds  0.0.0.0:3000->3000/tcp  Grafana
</pre>