---
slug: step2
id: 6nhyrdwcs7ns
type: challenge
title: Pods and pod networking
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
## More on pods

Pods are good for more than just organization though.  A pod also containerizes the network communication between the containers within it.

If I run the same httpd container from earlier, without putting it inside of a pod, I can then access whatever ports I have exposed on the container, via localhost on my container host.

```bash
podman run -d -p 8080:80 --rm --name my-bare-httpd httpd
```

This tells podman to run the same container image, with a new name, and forward port 8080 on our host, to port 80 on the container.

Now if we look at `podman ps` again, we'll see a new httpd container, notice that it says its listening on `0.0.0.0:8080`

```bash
podman ps
```

<pre>
# podman ps
CONTAINER ID  IMAGE                                    COMMAND           CREATED         STATUS             PORTS                 NAMES
09996c7a624b  localhost/podman-pause:4.0.2-1652984291                    12 minutes ago  Up 10 minutes ago                        2d95aa4fdaee-infra
68ca89e03e63  docker.io/library/httpd:latest           httpd-foreground  10 minutes ago  Up 10 minutes ago                        my-httpd
90f6b39d18ac  docker.io/library/httpd:latest           httpd-foreground  4 seconds ago   Up 3 seconds ago   0.0.0.0:8080->80/tcp  my-bare-httpd
#
</pre>

And we can even test that out with `curl`

```bash
curl http://127.0.0.1:8080
```

<pre>
# curl http://127.0.0.1:8080
<html><body><h1>It works!</h1></body></html>
</pre>

Lets try to make a new httpd container, inside of our pod, that forwards in the same way.  First let's stop our new httpd container.

```bash
podman stop my-bare-httpd
```

Now, we still have an httpd container running, but we cant access it, not just because we havent forwarded any ports to it, but because its inside of a pod.  The pod acts almost like a firewall, allowing or disallowing ports to the containers within it.  Containers that run container images that are configured to listen on a given port are accessible to each other within the pod, but outside the pod are not accessible unless we tell the pod to allow it.

## Pod networking

Let's run a container that lets us get to a bash shell within our podfrom earlier, to show that the httpd service is in fact accessible, just not from outside the pod.

```bash
podman run -it --pod my-pod --rm registry.access.redhat.com/ubi9/ubi
```
In this example, we're running a container, interactively, insdie of our pod.  You should get to a bash prompt inside of a RHEL UBI container.

<pre>
# podman run -it --pod my-pod --rm registry.access.redhat.com/ubi9/ubi
[root@my-pod /]#
</pre>

This container doesn't run any services, but if we try to use curl on localhost, we'll see that in fact we get a response!

```bash
curl http://127.0.0.1
```

<pre>
[root@my-pod /]# curl http://127.0.0.1
<html><body><h1>It works!</h1></body></html>
[root@my-pod /]#
</pre>

You can exit that shell with

```bash
exit
```

<pre>
[root@my-pod /]# exit
exit
root@rhel:~#
</pre>

So let's re-create our pod, and make it listen on port 80.  Let's stop, and then delete our pod.

```bash
podman pod stop my-pod && podman pod rm my-pod
```

Now let's make a new pod, with a new httpd container, and have the pod forward port 8080 to port 80 inside the pod.

```bash
podman pod create --name my-networked-pod -p 8080:80
```

And then we'll need a container to listen on port 80, but we don't need to tell the container to forward anything, that's handled at the pod level.

```bash
podman run -d --pod my-networked-pod --name my-networked-httpd httpd
```

Now, if we check `podman pod ps` and `podman ps` we'll see that both the pod container, and the container itself show the port 8080 forward, even though we didnt specify that on the container.
```bash
podman pod ps
```
<pre>
# podman pod ps
POD ID        NAME              STATUS      CREATED         INFRA ID      # OF CONTAINERS
63c4292d1879  my-networked-pod  Running     19 seconds ago  74be17e394e6  2
</pre>

```bash
pomdn ps
```
<pre>
# podman ps
CONTAINER ID  IMAGE                                    COMMAND           CREATED         STATUS             PORTS                 NAMES
74be17e394e6  localhost/podman-pause:4.0.2-1652984291                    26 seconds ago  Up 13 seconds ago  0.0.0.0:8080->80/tcp  63c4292d1879-infra
0d13004a35e7  docker.io/library/httpd:latest           httpd-foreground  13 seconds ago  Up 12 seconds ago  0.0.0.0:8080->80/tcp  my-networked-httpd
</pre>

And we should be able to test that with `curl` now.

```bash
curl http://127.0.0.1:8080
```

<pre>
$ curl http://127.0.0.1:8080
<html><body><h1>It works!</h1></body></html>
</pre>
