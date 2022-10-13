---
slug: step2
id: 6nhyrdwcs7ns
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
# Introduction to Podman Pods

A pod within podman is a way of grouping containers that make up services.  We can create a pod easily, with the following command.

```bash
podman pod create --name my-pod
```
You should see output similar to this:
<pre type=file>
# podman pod create --name my-pod
2d95aa4fdaee5f9b612ad018a42a6f48855ff240784c4be3c9c65f540f6c6448
#
</pre>

Now we can create a container within that pod simply by tellig podman what pod to create the container in.

```bash
podman run --pod my-pod -d --name my-httpd httpd
```
Again, you should see output similar to this:
<pre type=file>
# podman run --pod my-pod -d --name my-httpd httpd
68ca89e03e63df047cc59cbf8ecb648b71c136cc4c9611a709577195b2f2b048
#
</pre>
Now, we can see that our container is running with
```bash
podman ps
```
<pre type=file>
# podman ps
CONTAINER ID  IMAGE                                    COMMAND           CREATED         STATUS             PORTS       NAMES
09996c7a624b  localhost/podman-pause:4.0.2-1652984291                    2 minutes ago   Up 51 seconds ago              2d95aa4fdaee-infra
68ca89e03e63  docker.io/library/httpd:latest           httpd-foreground  51 seconds ago  Up 50 seconds ago              my-httpd
#
</pre>

But what is that extra container? `2d95aa4fdaee-infra`

That is a special container that runs our pod.  We can see that the pod is up and running, with two containers, even though we only started a single container inside of it.

```bash
podman pod ps
```

<pre type=file>
# podman pod ps
POD ID        NAME        STATUS      CREATED        INFRA ID      # OF CONTAINERS
2d95aa4fdaee  my-pod      Running     5 minutes ago  09996c7a624b  2
#
</pre>
