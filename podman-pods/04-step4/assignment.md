---
slug: step4
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Pod networking

Let's run a container, that lets us get to a bash shell within our pod, to show that the httpd service is in fact accessible, just not from outside the pod. 

```bash
podman run -it --pod my-pod --rm registry.access.redhat.com/ubi9/ubi
```
In this example, we're running a container, interactively, insdie of our pod.  You should get to a bash prompt inside of a RHEL UBI container. 

<pre type=file>
# podman run -it --pod my-pod --rm registry.access.redhat.com/ubi9/ubi
[root@my-pod /]# 
</pre>

This container doesnt run any services, but if we try to use curl on localhost, we'll see that in fact we get a response!

```bash
curl http://127.0.0.1
```

<pre type=file>
[root@my-pod /]# curl http://127.0.0.1
<html><body><h1>It works!</h1></body></html>
[root@my-pod /]# 
</pre>

You can exit that shell with

```bash
exit
```

<pre type=file>
[root@my-pod /]# exit
exit
[gangrif@tmm-host1 ~]$ 
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

<pre type=file>
# podman pod ps
POD ID        NAME              STATUS      CREATED         INFRA ID      # OF CONTAINERS
63c4292d1879  my-networked-pod  Running     19 seconds ago  74be17e394e6  2

# podman ps
CONTAINER ID  IMAGE                                    COMMAND           CREATED         STATUS             PORTS                 NAMES
74be17e394e6  localhost/podman-pause:4.0.2-1652984291                    26 seconds ago  Up 13 seconds ago  0.0.0.0:8080->80/tcp  63c4292d1879-infra
0d13004a35e7  docker.io/library/httpd:latest           httpd-foreground  13 seconds ago  Up 12 seconds ago  0.0.0.0:8080->80/tcp  my-networked-httpd
</pre>

And we should be able to test that with `curl` now. 

```bash
curl http://127.0.0.1:8080
```

<pre type=file>
$ curl http://127.0.0.1:8080
<html><body><h1>It works!</h1></body></html>
</pre>
