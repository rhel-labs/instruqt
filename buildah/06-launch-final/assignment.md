---
slug: launch-final
id: apvnzu9i9ywg
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
localhost/el-httpd2                       latest      076c3116b4c1  40 seconds ago  299 MB
localhost/el-httpd1                       latest      c08e21fe69a5  16 minutes ago  299 MB
registry.access.redhat.com/ubi9/ubi-init  latest      849d803e50eb  32 hours ago    247 MB
</pre>

Note the name matches what was set using `buildah commit`.

`Podman` and `buildah` use the same storage locations on the host, which lets us immediately run the image we just built via `podman`.

```bash
podman run -d -p 80:80 el-httpd2
```

<pre class="file">
561019c2a69fd3826bcaf4a62240ba2b5edd542e664bd2fee0381da746d58d95
</pre>

Check the status of the application container using `podman`.

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE                       COMMAND         CREATED        STATUS            PORTS               NAMES
2a1cd10a719a  localhost/el-httpd2:latest  /usr/sbin/init  8 seconds ago  Up 8 seconds ago  0.0.0.0:80->80/tcp  youthful_hertz
</pre>

Note the ports and command match the metadata set using `buildah config`.

Inspect the image metadata for the application container using `buildah inspect`.

```bash
buildah inspect localhost/el-httpd2 | grep -A 8 rootfs
```

<pre class="file">
--
        "rootfs": {
            "type": "layers",
            "diff_ids": [
                "sha256:89cadc3789b9f5ab3768f50d578a389e2719cf9981b585e70ca409b8b143defc"
            ]
        },
        "history": [
            {
                "created": "2022-06-15T15:55:04.662511309Z",
--
        "rootfs": {
            "type": "layers",
            "diff_ids": [
                "sha256:89cadc3789b9f5ab3768f50d578a389e2719cf9981b585e70ca409b8b143defc"
            ]
        },
        "history": [
            {
                "created": "2022-06-15T15:55:04.662511309Z",
</pre>

Look for the `rootfs` section in the JSON output. You will see the single layer created by the `buildah commit` subcommand.

Run the following `curl` command to check that the container is serving a web page.

```bash
curl localhost:80
```

<pre class="file">
<!DOCTYPE html>
<head>
  <title>Welcome to a container!</title>
</head>
<body>
<h1>You've deployed your new web application into a container from scratch!</h1>
</body>
</pre>