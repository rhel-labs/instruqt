---
slug: step4
id: svcdiszxo0jf
type: challenge
title: Managing Pods with Systemd and Quadlet
tabs:
- id: jk4wucyzgt2p
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Quadlet

Quadlet is a systemd generator, that will take your pod definition, and register it as a service in systemd.  We have provided a quadlet pod defintion for you.

```bash
cat my-networked-pod.kube
```

<pre>
root@rhel:~# cat my-networked-pod.kube
[Install]
WantedBy=default.target

[Unit]
# You can use standard unit options to control the start-up order of your pod.
# Such as:
#After=
#Requires=

[Kube]
# In this section you can define several things
# here we are simply calling the kube yaml we generated with podman
Yaml=/etc/containers/systemd/my-networked-pod.yaml

#We also need to define the ports that our pod maps int, just as we do a the pod level
PublishPort=8080:80
</pre>

You can see the similarities in the above output, and a standard systemd unit file.  You can add in start up options, ordering, and other systemd configuration to tune when and how this pod starts up.

As you can see, the path to the pod yaml is `/etc/containers/systemd/my-networked-pod.yaml`.  You can place your yaml definition elsewhere if you would like, but this is also where the `.kube` quadlet defintion needs to be placed.  Keeping them toghether makes it clean for this lab.

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

<pre type=file>
root@rhel:~# /usr/libexec/podman/quadlet -dryrun
quadlet-generator[4025]: Loading source unit file /etc/containers/systemd/my-networked-pod.kube
---my-networked-pod.service---
[Install]
WantedBy=default.target

[Unit]
SourcePath=/etc/containers/systemd/my-networked-pod.kube
RequiresMountsFor=%t/containers

# You can use standard unit options to control the start-up order of your pod.
# Such as:
#After=
#Requires=

[X-Kube]
# In this section you can define several things
# here we are simply calling the kube yaml we generated with podman
Yaml=/etc/containers/systemd/my-networked-pod.yaml

#We also need to define the ports that our pod maps int, just as we do a the pod level
PublishPort=8080:90

[Service]
KillMode=mixed
Environment=PODMAN_SYSTEMD_UNIT=%n
Type=notify
NotifyAccess=all
SyslogIdentifier=%N
ExecStart=/usr/bin/podman kube play --replace --service-container=true --publish 8080:90 /etc/containers/systemd/my-networked-pod.yaml
ExecStopPost=/usr/bin/podman kube down /etc/containers/systemd/my-networked-pod.yaml

</pre>

Using this dry run, you can see what qadlet will do when you reload systemd.

Notice the `ExecStart` command in the service.  You can see the `--replace` flag, which means each time you start this service, it will re-read the kube definition, and replace your pod.  This means that changes to the pod's definition and updates to the container images that the definition calls, will be pulled in automatically every time the pod is started using systemd.

This looks fine, so let's get this definiteion in place.

```bash
systemctl daemon-reload
```

Now we can start the service up, but first, let's check podman, and make sure we dont already have our pod running.

```bash
podman pod ps
```

<pre type=file>
root@rhel:~# podman pod ps
POD ID      NAME        STATUS      CREATED     INFRA ID    # OF CONTAINERS
</pre>

Looks good, Let's start our pod up.

```bash
systemctl start my-networked-pod.service
```

This should go and download any container images that are neccessary, and then start up our pod.

```bash
systemctl status my-networked-pod.service
```

<pre type=file>
root@rhel:~# systemctl status my-networked-pod
● my-networked-pod.service
     Loaded: loaded (/etc/containers/systemd/my-networked-pod.kube; generated)
     Active: active (running) since Wed 2024-01-31 19:19:45 UTC; 1min 2s ago
   Main PID: 4857 (conmon)
      Tasks: 3 (limit: 23073)
     Memory: 2.8M
        CPU: 444ms
     CGroup: /system.slice/my-networked-pod.service
             ├─4857 /usr/bin/conmon --api-version 1 -c 86b713eda7f56e49902b217268f7619bd9e455cebb2ef7d3b5820fd92ce58e41 -u 86b713eda7f56e>
             ├─4928 /usr/bin/conmon --api-version 1 -c cd046b7b107d64d13e47cc14449e69739aab23f8c526bbd54c394861ec253f72 -u cd046b7b107d64>
             └─4934 /usr/bin/conmon --api-version 1 -c fff1424f8329ee251d60be28f1eae7d2b79c367a1f82b94cda6309febebe05bf -u fff1424f8329ee
</pre>

And

```bash
podman pod ps
```

<pre type=file>
root@rhel:~# podman pod ps
POD ID        NAME              STATUS      CREATED             INFRA ID      # OF CONTAINERS
34c2405415bd  my-networked-pod  Running     About a minute ago  cd046b7b107d  2
</pre>

Now the `my-networked-pod` pod can be controlled via systemctl, and will even start up on system boot-up.