---
slug: step4
id: gc9ul9x4zde4
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Quadlet

Quadlet is a systemd generator, that will take your pod definition, and register it as a service in systemd.  We have provided a quadlet pod defintion for you. 

```bash
cat my-networked-pod.kube
```

<pre>
output
</pre>

You can see the similarities in the above output, and a standard systemd unit file.  You can add in start up options, ordering, and other systemd configuration to tune when and how this pod starts up. 

As you can see, the path to the pod yaml is `/etc/containers/quadlet/my-networked-pod.yaml`.  You can place your yaml definition elsewhere if you would like, but this is also where the `.kube` quadlet defintion needs to be placed.  Keeping them toghether makes it clean for this lab. 

Let's copy the files into place. 

```bash
cp ~/my-networked-pod.yaml /etc/containers/systemd
```
And then
```bash
cp ~/my-networked-pod.kube /etc/containers/systemd
```

Now, if we reload systemd, quadlet will generate a service unit for our pod.  You can also test the generation using quadlet in a dry-run. 

```bash
/usr/libexec/podman/quadlet -dryrun
```

<pre>
Output
</pre>

Using this dry run, you can see what qadlet will do when you reload systemd.  This looks fine, so let's get this definiteion in place. 

```bash
systemctl daemon-reload
```

Now we can start the service up, but first, let's check podman, and make sure we dont already have our pod running.

```bash
podman pod ps
```

<pre>
Output
</pre>

Looks good, Let's start our pod up. 

```bash
systemctl start my-networked-pod.service
```

This should go and download any container images that are neccessary, and then start up our pod. 

```bash
systemctl status my-networked-pod.service
```

And 

```bash
podman pod ps
```

