---
slug: step3
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## More on pods

Pods are good for more than just organization though.  A pod also containerizes the network communication between the containers within it.  

If I run the same httpd container from earlier, without putting it inside of a pod, I can then access whatever ports I have exposed on the container, via localhost on my container host. 

```bash
podman run -d -p 8080:80 --name my-bare-httpd httpd
```

This tells podman to run the same container image, with a new name, and forward port 8080 on our host, to port 80 on the container. 

Now if we look at `podman ps` again, we'll see a new httpd container, notice that it says its listening on `0.0.0.0:8080` 

```bash
podman ps
```

<pre type=file>
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

<pre type=file>
# curl http://127.0.0.1:8080
<html><body><h1>It works!</h1></body></html>
</pre>

Lets try to make a new httpd container, inside of our pod, that forwards in the same way.  First let's stop our new httpd container. 

```bash
podman stop my-bare-httpd
```

Now, we still have an httpd container running, but we cant access it, not just because we havent forwarded any ports to it, but because its inside of a pod.  The pod acts almost like a firewall, allowing or disallowing ports to the containers within it.  Containers that run container images that are configured to listen on a given port are accessible to each other within the pod, but outside the pod are not accessible unless we tell the pod to allow it. We'll demonstrate this in the next step. 


