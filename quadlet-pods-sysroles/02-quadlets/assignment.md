---
slug: quadlets
id: d5xm48kki5au
type: challenge
title: Quadlets
notes:
- type: text
  contents: |
    # Now let's move into Quadlets
    Quadlet is a definition that will generate a systemd unit to control podman resources.  In this step we'll take our yaml definition, and use Quadlet to make a systemd controlled pod out of it.
tabs:
- id: k8b0u3hdkftu
  title: RHEL
  type: terminal
  hostname: rhel
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

The `.kube` extension tells Quadlet that this is a generated Kube definition from Podman.  There are several other extensions that Quadlet supports, such as `.container`, `.pod`, and `.volume`.

It doesnt really matter where you save your pod's Kube definition, or the Configmap Yaml, but it's good practice to place them somewhere common, and not in your home directory.  Unless you are creating systemd user units, which is possible with Quadlet as well, but we are not covering those in this lab.  You might notice that we've defined the paths to the two required files within the quadlet definition as `/etc/containers/systemd`.  This is also where the .kube file needs to be places for a system level unit file, so let's copy all of the files there.

```bash,run
cp ~/my-app/my-app.yaml ~/my-app/my-app-configmap.yaml ~/my-app/quadlet/my-app.kube /etc/containers/systemd
```

Now, we can test to see what Quadlet will generate for our systemd unit file using quadlet's `--dryrun` command line option.

```bash,run
/usr/libexec/podman/quadlet --dryrun
```
You should see the dry run output displayed in the terminal.

Now, to generate the output for real, all we will need to do is reload systemd.

```bash,run
systemctl daemon-reload
```

Let's start it up.

```bash,run
systemctl start my-app
```

As you would with any systemd service, you can check the status and log output using the usual `systemctl` and `journalctl` commands.

```bash,run
systemctl status my-app
```

```bash,run
journalctl -xeu my-app
```

And of course you should see the pod running in podman

```bash,run
podman pod ps
```
Now, if we stop the service, the pod will not just stop, but it gets removed. 

```bash,run
systemctl stop my-app
podman pod ps
```

And of course if we start it back up, it will start with a new pod. 

```bash,run
systemctl start my-app
```

