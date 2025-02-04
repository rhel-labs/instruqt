---
slug: run-container
id: tsbh8ays0fxv
type: challenge
title: Run a container
tabs:
- id: ul4q2opyheyn
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
In this exercise we're going to introduce you to running a container.  We'll run one in the foreground, another in the background, and show you how to interact with containers once they're running.

## Running a basic container

First, let's run a RHEL UBI container in the foreground.

```bash,run
podman run -it --rm registry.access.redhat.com/ubi9/ubi
```

You should be brought into a new shell, that looks something like this:

<pre type="file">
[root@b5514553ad45 /]#
</pre>

Go ahead and poke around, you'll find that it feels a lot like a very minimal linux system.  And that's because it is!  The RHEL UBI is meant to be a base image, much like Alpine, or other lightweight linux images that you might use to base a container on.  Containers are, at their base, linux.  They share the running linux Kernel of the container host. Once you're done, just exit the shell by typing `exit` or hitting `ctrl-d`

```bash,run
exit
```

Let's talk a little bit about the command you use to run that container.

<pre type="file">
podman run -it --rm registry.access.redhat.com/ubi9/ubi
</pre>

The `-it` argument tells podman to run this container with a terminal, and run it interactively (or, in the foreground).

The `--rm` argument tells podman to remove the container once it exits.  This is only done here to help keep things tidy.  It's a great argument to remember when you're developing a new container, or just running something to test it out.

The last argument is always the container image you'd like to run.  You can shorten this for containers that you already have locally.  Remember that `podman pull` command from the first step?  An image that you've pulled is stored locally, and can be called by its image name without a whole registry address at the start.  If the image isn't found locally, podman will look to your configured registries to see if it can find the image.  If you have more than one registry defined, it will ask you which registry to pull from.

Now let's run something in the background.  First let's see what happens if we run UBI in the background.

```bash,run
podman run -d registry.access.redhat.com/ubi9/ubi
```

Ok, now let's see if its running.

```bash,run
podman ps
```

It's not there, is it?

<pre type="file">
root@rhel:~# podman run -d registry.access.redhat.com/ubi9/ubi
c401adc17a7b1f5900359b4fcd182f5b4da21a960a4340bec479bb614eb7606f
root@rhel:~# podman ps
CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
root@rhel:~#
</pre>

Remember how I said UBI was meant to be a base for building containers?  It's not configured out of the box to actually run anything if you just run it.  We only got a bash shell that first time becasue we ran it in the foreground.  Without a `CMD` to run the container simply exits.  We wont cover how to build a container from UBI in this particular lab, as we're here to cover the basics.

If you check `podman ps -a` you'll find our new container there, stopped.  Because it ran, and exited as it was supposed to.

```bash,run
podman ps -a
```

<pre type="file">
root@rhel:~# podman ps -a
CONTAINER ID  IMAGE                                       COMMAND     CREATED        STATUS                    PORTS       NAMES
c401adc17a7b  registry.access.redhat.com/ubi9/ubi:latest  /bin/bash   4 minutes ago  Exited (0) 4 minutes ago              wonderful_kirch
</pre>

Instead, let's run something that actually does something, and see how that works.

```bash,run
podman run -d --name my-httpd docker.io/httpd
```

Now, if we check `podman ps` we should see a new entry for our new container.

<pre type="file">
root@rhel:~# podman ps
CONTAINER ID  IMAGE                           COMMAND           CREATED         STATUS         PORTS       NAMES
9495ddeffdcb  docker.io/library/httpd:latest  httpd-foreground  10 seconds ago  Up 10 seconds  80/tcp      my-httpd
</pre>

Once a container is running it the background it might feel like you cant really interact with it, but you can!  First let's see what `podman logs` has to show us.

```bash,run
podman logs my-httpd
```

You should get the output from the apache httpd daemon that's running in the container.

<pre type="file">
root@rhel:~# podman logs my-httpd
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.88.0.5. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.88.0.5. Set the 'ServerName' directive globally to suppress this message
[Mon Feb 03 23:23:16.730955 2025] [mpm_event:notice] [pid 1:tid 1] AH00489: Apache/2.4.63 (Unix) configured -- resuming normal operations
[Mon Feb 03 23:23:16.731518 2025] [core:notice] [pid 1:tid 1] AH00094: Command line: 'httpd -D FOREGROUND'
</pre>

Commonly, when you run a process inside of a container, it's not run by any sort of init system.  It just runs as though you'd run it in the foreground.  But it's in the foreground, in this detatched state, inside of the container.  It's fully up and active like it was run in the background by an init system like systemd, but its not running under systemd, its running in the container.

So, what if for some reason you need to get a shell inside of that container?  Well we can do that too, with `podman exec`.  This command can run any executable that exists in the container.  You can run `bash`, or `ls`, or most other bash built-ins.  You can also run any utilities that have been baked into the container.  Let's try a few.

```bash,run
podman exec my-httpd ls /usr/local/apache2/htdocs
```

Or, we can get a shell by invoking bash, but remember we want this one to run in our terminal, interactively.

```bash,run
podman exec -it my-httpd /bin/bash
```

You should get a shell inside of your container, and you can look around and see where files live and what user permissions are.  This can come in handy when you're trying to figure out where to map in peristent storage.  Persistent storage is something we'll be covering in the next step, along with mapping in ports so our container can do something more than just sit there.
