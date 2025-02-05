---
slug: containerfile-basics
id: fvotyhxem9pa
type: challenge
title: Introduction to the Containerfile
tabs:
- id: btthhzhxkibc
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## What is a Containerfile

A `Containerfile` is a set of commands, almost like a script, that tells podman how to build your container image.  It defines things like what container image to base your new image on using the `FROM` command.  You also can `RUN` arbitrary commands, or `COPY` in files. Finally what `CMD` to run as the main process of the container.

In this exercise, we're going to build a basic container image, and then use it as a base for some other changes.

## A basic containerfile

We've staged a base `Containerfile` for you to start with.

```bash,run
cd ~/my-container
```

Have a look at the `Containerfile` in this directory.

```bash,run
cat Containerfile
```

<pre type="file">
FROM registry.access.redhat.com/ubi9/ubi
RUN dnf -y install httpd
EXPOSE 80
CMD ["/usr/sbin/httpd","-DFOREGROUND"]
</pre>

This `Containerfile` will start with a base RHEL 9 universal base image, and then add in Apache HTTPD.  Then we tell the image what port it should open, and finally we run httpd in the foreground.


Each command in this file will start a new layer in the container image's layered filesystem.  Every time you make a change, and rebuild the image, podman will pick up the build from the first change.  So let's build this image.

When you build from a `Containerfile`, you need to tell podman what to tag the new image as, this is how you'll use the image later, and where the `Containerfile` is.  We'll build from the working directory where the `Containerfile` exists, but you can also point do the `Containerfile` from a different directory.

First, make sure you're still in the `my-container` directory.

```bash,run
cd ~/my-container
```

Now build the container with.

```bash,run
podman build -t my-container .
```

You should see the output run through all of the commands we entered into the `Containerfile`.  Once it's complete, you should see an output similar to this:

<pre type="file">
STEP 1/4: FROM registry.access.redhat.com/ubi9/ubi
STEP 2/4: RUN dnf -y install httpd
Updating Subscription Management repositories.
subscription-manager is operating in container mode.
Red Hat Enterprise Linux 9 for x86_64 - BaseOS   40 MB/s |  42 MB     00:01
Red Hat Enterprise Linux 9 for x86_64 - AppStre  46 MB/s |  49 MB     00:01
Red Hat Universal Base Image 9 (RPMs) - BaseOS  2.1 MB/s | 525 kB     00:00
Red Hat Universal Base Image 9 (RPMs) - AppStre  12 MB/s | 2.3 MB     00:00
Red Hat Universal Base Image 9 (RPMs) - CodeRea 1.9 MB/s | 281 kB     00:00
Dependencies resolved.
...Truncated...
Installed products updated.

Installed:
  apr-1.7.0-12.el9_3.x86_64                apr-util-1.6.1-23.el9.x86_64
  apr-util-bdb-1.6.1-23.el9.x86_64         apr-util-openssl-1.6.1-23.el9.x86_64
  httpd-2.4.62-1.el9_5.2.x86_64            httpd-core-2.4.62-1.el9_5.2.x86_64
  httpd-filesystem-2.4.62-1.el9_5.2.noarch httpd-tools-2.4.62-1.el9_5.2.x86_64
  libbrotli-1.0.9-7.el9_5.x86_64           mailcap-2.1.49-5.el9.noarch
  mod_http2-2.0.26-2.el9_4.1.x86_64        mod_lua-2.4.62-1.el9_5.2.x86_64
  redhat-logos-httpd-90.4-2.el9.noarch

Complete!
--> d670a0566bde
STEP 3/4: EXPOSE 80
--> f168fd5c2ff4
STEP 4/4: CMD ["/usr/sbin/httpd","-DFOREGROUND"]
COMMIT test
--> bf4d4b1cd4bd
Successfully tagged localhost/test:latest
bf4d4b1cd4bde47e9d551698d87a5377dabf1d8bb1a09cec55cc4e40ae9505fc
</pre>

Now, if we check our local images, we should see my-container

```bash,run
podman image list
```

<pre type="file">
REPOSITORY                           TAG         IMAGE ID      CREATED         SIZE
localhost/my-container               latest      bf4d4b1cd4bd  19 minutes ago  440 MB
registry.access.redhat.com/ubi9/ubi  latest      b21b662817da  33 hours ago    234 MB
</pre>

> NOTE: You will also see the image that you based your container on.

Now we can run a container from our image!

```bash,run
podman run --name my-httpd -p 80:80 -d my-container
```

Now, if you check running containers, you should see your container, and you can view its log output with `podman logs`.

```bash,run
podman ps
```

<pre type="file">
CONTAINER ID  IMAGE                  COMMAND               CREATED         STATUS             PORTS                       NAMES
adc8c4a6659c  localhost/my-container:latest  /usr/sbin/httpd -...  59 seconds ago  Up About a minute  0.0.0.0:80->80/tcp, 80/tcp  my-httpd
</pre>

```bash,run
podman logs my-httpd
```

And that should show you the foreground output of httpd.

You should also be able to test your container with curl.

```bash,run
curl http://127.0.0.1
```

This should result in the apache test page.

Now that we've built a container, let's make a change to the `Containerfile` and rebuild it.