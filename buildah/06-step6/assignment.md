---
slug: step6
id: apvnzu9i9ywg
type: challenge
title: Launching and inspecting the application container
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
timelimit: 100
---
More information on managing containers with `podman` can be found in the ["Deploying containers with container tools"](https://lab.redhat.com/podman-deploy) scenario.

Inspect the images available on the host using `podman images`

```bash
podman images
```

<pre class="file">
REPOSITORY                                 TAG      IMAGE ID       CREATED              SIZE
localhost/el-httpd2                        latest   d074aab93289   About a minute ago   505 MB
localhost/el-httpd1                        latest   b04fe2c73b03   6 minutes ago        279 MB
registry.access.redhat.com/ubi8-init       latest   8c376a94293d   2 weeks ago          231 MB
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
CONTAINER ID  IMAGE                       COMMAND     CREATED         STATUS             PORTS               NAMES
561019c2a69f  localhost/el-httpd2:latest  /sbin/init  13 seconds ago  Up 13 seconds ago  0.0.0.0:80->80/tcp  suspicious_sammet
</pre>

Note the ports and command match the metadata set using `buildah config`.

Inspect the image metadata for the application container using `buildah inspect`.

```bash
buildah inspect localhost/el-httpd2
```

<pre class="file">
"rootfs": {
            "type": "layers",
            "diff_ids": [
                "sha256:6d0bba8b32ffa211bb78d415b96d67dd7955cb30b1f86555d9c9f0da9a914626"
            ]
        },
</pre>

Look for the `rootfs` section in the JSON output. You will see the single layer created by the `buildah commit` subcommand.

Click on the ***Container httpd*** tab to see the index.html deployed into the application container.

>_NOTE:_ You may need to hit the *refresh* icon to see the new page.
