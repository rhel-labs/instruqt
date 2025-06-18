---
slug: quadlets
id: 
type: challenge
title: Quadlets
notes:
- type: text
  contents: |
    # Now let's move into Quadlets
    Quadlet is a definition that will generate a systemd unit to control podman resources.  In this step we'll take our yaml definition, and use Quadlet to make a systemd controlled pod out of it. 
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Files
We've created some clean files for you to use inside of `~/my-app`.  You will notice two files in that directory.  `my-app.yaml` and `my-app-configmap.yaml`.  We have taken the environment variables for the MariaDB container, and split them out into a ConfigMap.  A ConfigMap is a file which is meant to make it easier to maintain your environment and configuration settings.

You can build a pod using these two files using the following command.

```bash,run
podman play kube --configmap ~/my-app/my-app-configmap.yaml ~/my-app/my-app.yaml
```

Now you should have your pod running again. 

```bash,run
podman pod ps
```

But the goal here is to try to run this using Quadlet, so instead, let's do that. 

```bash,run
podman pod stop my-app&&podman pod rm my-app
```

With the pod stopped and removed, let's move into how Quadlet works. 

# How Quadlet works
Quadlet can be used to define podman resources such as containers, pods, even volumes, using systemd.  Quadlet is a systemd generator, which takes your podman definition, and turns it into a genuine systemd unit.  This unit will start a new instance of your resource when you start it, and destroy it when you stop it.  This fits container workflows very well, because there should be no reason to keep the old containers around once they're stopped, and starting a new instance of the container from the latest copy of the source image is also a good practice. 

We have created some quadlet definitions for you inside of `~/my-app/quadlet`, so let's have a look at them. 

```bash,run
cd ~/my-app/quadlet
```

Now have a look at `my-app.kube`

```bash,run
cat my-app.kube
```
