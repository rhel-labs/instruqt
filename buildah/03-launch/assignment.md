---
slug: launch
id: tzc1xgcbicue
type: challenge
title: Launching and inspecting the application container
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
More information on managing containers with `podman` can be found in the ["Deploying containers with container tools"](https://lab.redhat.com/podman-deploy) scenario.

Inspect the images available on the host using `podman images`

```bash
podman images
```

<pre class="file">
REPOSITORY                                TAG         IMAGE ID      CREATED         SIZE
localhost/el-httpd1                       latest      c08e21fe69a5  42 seconds ago  299 MB
registry.access.redhat.com/ubi9/ubi-init  latest      849d803e50eb  32 hours ago    247 MB
</pre>

Note the name matches what was set using `buildah commit`. The `localhost` prepended to the name of the image indicates that the image is stored locally.

`podman` and `buildah` use the same storage locations on the host, which lets us immediately run the image we just built via `podman`.

```bash
podman run -d -p 80:80 el-httpd1
```

<pre class="file">
f4d9db69e9b512517f9490d3bcc5096e69cca5e9b3a50b3890430da39ae46573
</pre>

Check the status of the application container using `podman`.

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE                       COMMAND         CREATED        STATUS            PORTS               NAMES
6ff3318f0036  localhost/el-httpd1:latest  /usr/sbin/init  3 minutes ago  Up 3 minutes ago  0.0.0.0:80->80/tcp  focused_roentgen
</pre>

Note the ports and command match the metadata set using `buildah config`.

Inspect the image metadata for the application container using `buildah inspect`.

```bash
buildah inspect localhost/el-httpd1 | grep -A 8 rootfs
```

<pre class="file">
"rootfs": {
    "type": "layers",
    "diff_ids": [
        "sha256:24d85c895b6b870f6b84327a5e31aa567a5d30588de0a0bdd9a669ec5012339c",
        "sha256:c613b100be1645941fded703dd6037e5aba7c9388fd1fcb37c2f9f73bc438126",
        "sha256:188ab351dfda8afc656a38073df0004cdc5196fd5572960ff5499c17e6442223",
        "sha256:2aa09f066ed0ce8aad332cbefe237cbe05777f5790bccfdcda439aff5f5f7509"
    ]
},
</pre>

Look for the `rootfs` section in the JSON output. You will see layers for each of the `buildah` subcommands run.

Run the following curl command to check that the container is serving an index page on port 80.

```bash
curl localhost:80
```

<pre class="file">
<!DOCTYPE html>
<head>
  <title>Welcome to a container!</title>
</head>
<body>
<h1>You've deployed your new web application into a UBI based container!</h1>
</body>
</pre>

Stop all running containers before moving to the next step:

```bash
podman stop -a
```
