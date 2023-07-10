---
slug: run-again
id: xp5ewqc3x5ek
type: challenge
title: Running the container and using the software
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
In the previous step, you committed your container image.  You can look at the images in the local container respository by using `podman image list`.

```bash
podman image list
```

<pre class="file">
REPOSITORY                           TAG         IMAGE ID      CREATED        SIZE

localhost/clumsy-bird                latest      e6b899ea7611  2 minutes ago  493 MB
localhost/moon-buggy                 latest      dbb1368db3f9  10 minutes ago 335 MB
registry.access.redhat.com/ubi9/ubi  latest      10f854072e7e  5 minutes ago  227 MB
registry.access.redhat.com/ubi8/ubi  latest      168c58a38365  15 minutes ago 228 MB
</pre>

Now that the image is available, you can run the container.  Because this application is managed by a service, you will use the `-d` option to run the container in a detatched mode.  Additionally, you will map content coming to port 8080 on the host system to be routed to the application running on the container's port 80.

```bash
podman run -d -p 8080:80 clumsy-bird
```

<pre class="file">
20d0b1f6d26fb91d9418b067d762974d36e331950c28538e0b5bd359416d8712
</pre>

You can now access the running `clumsy-bird` application by connecting to the system's port 8080.  The lab environment has this available to you under the __Containerized Web App__ tab.

