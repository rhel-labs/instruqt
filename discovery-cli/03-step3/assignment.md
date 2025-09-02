---
slug: step3
id: bpqpnod3l1kc
type: challenge
title: Operationalizing Pods with kube
tabs:
- id: jos50vepqb5y
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Podman generate, and podman play
Another great feature of pods is that you can generate a yaml definition of your pod, and use it to re-create your pod using `podman generate` and `podman play`.

Let's generate a definition for your newly networked pod.

```bash
podman generate kube my-networked-pod > my-networked-pod.yaml
```

Now, we can see what we generated

```bash
cat my-networked-pod.yaml
```

<pre type=file>
root@rhel:~# cat my-networked-pod.yaml
# Save the output of this file and use kubectl create -f to import
# it into Kubernetes.
#
# Created with podman-4.4.1
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-09-26T19:58:57Z"
  labels:
    app: my-networked-pod
  name: my-networked-pod
spec:
  containers:
  - image: docker.io/library/httpd:latest
    name: my-networked-httpd
    ports:
    - containerPort: 80
      hostPort: 8080
    resources: {}
  hostname: my-networked-pod
  restartPolicy: Never
status: {}
</pre>

Now, if we stop, and remove our pod.

```bash
podman pod stop my-networked-pod && podman pod rm my-networked-pod
```

We can re-create it easily with podman play.

```bash
podman play kube my-networked-pod.yaml
```

>_NOTE_: This feature of podman works on other items as well, you can, for instance, define a volume and use podman generate to store the volume definition as a yaml file.  Then re-create it on another system using podman play.

<pre type=file>
root@rhel:~# podman play kube my-networked-pod.yaml
Pod:
2f3d42d6cac720972889496334ef23260fa33030ddb3bccdcb7ff3a15dea07ac
Container:
f87d81a769a3cef7b5caf52e958426fd4f3f614e130bbb5e91c193ac36b3a27d
</pre>

Now, if we check on `podman pod ps` and `podman ps` we will see a new pod, and container within it.

```bash
podman pod ps
```
<pre>
root@rhel:~# podman pod ps
POD ID        NAME              STATUS      CREATED        INFRA ID      # OF CONTAINERS
2f3d42d6cac7  my-networked-pod  Running     3 minutes ago  d9f73884ad91  2
</pre>

```bash
podman ps
```
<pre>
root@rhel:~# podman ps
CONTAINER ID  IMAGE                                    COMMAND           CREATED        STATUS        PORTS                 NAMES
d9f73884ad91  localhost/podman-pause:4.4.1-1682527828                    3 minutes ago  Up 3 minutes  0.0.0.0:8080->80/tcp  2f3d42d6cac7-infra
f87d81a769a3  docker.io/library/httpd:latest           httpd-foreground  3 minutes ago  Up 3 minutes  0.0.0.0:8080->80/tcp  my-networked-pod-my-networked-httpd
</pre>

Now, if you try your curl command from earlier, you should get your test site just as before.  You can see how this is a great way to save the deployment information and re-deploy quickly.

```bash
curl http://127.0.0.1:8080
```

<pre type=file>
# curl http://127.0.0.1:8080
<xmp><html><body><h1>It works!</h1></body></html></xmp>
</pre>


In the next step, we're going a little deeper into operationalizing your pod, with Quadlet.
