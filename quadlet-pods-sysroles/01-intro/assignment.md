---
slug: intro
id: r2harhf3giol
type: challenge
title: Intro, and some background
notes:
- type: text
  contents: |
    # Introduction
    After completing this lab, you will have some introductory experience with several container management technologies included in Red Hat Enterprise Linux, Including
    * Podman
    * Multi-container pods
    * Controling podman entities with SystemD through Quadlet
    * Deploying containers and pods using RHEL System Roles

    These skills are useful for deploying containers that do not require a heavier container orchestration system, but still require a production level of service.
tabs:
- id: pagnywoqclhc
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # What is Podman?
  If you are not already familiar with podman, let us give you some brief background.  Podman is an Open Container Initiative (OCI) compliant container runtime for Linux.  It is not the purpose of this lab to teach you the basics of Podman, but know that it is a docker-compatible command line tool that will allow you to run Containers on linux.  You can find more labs related to Podman in other [Red Hat Online Labs](https://lab.redhat.com) if you would like to learn more.

  # What is a Pod?
  Additionally you may be wondering what a Pod is within podman.  A pod quite simply is a container for containers.  A pod will group containers together, linking their dns resolution, networking, and a few other resources.  This also allows you to manage them as an individual unit.  If you had, for example, and web application, and the database back-end for that application all within a pod.  Those two containers would be able to communicate with each-other, and you would be able to start and stop both containers by telling the pod to start or stop once it is defined.

  # And what then, is Quadlet?
  Quadlet is a generator for Systemd that will create unit files to control podman resources through systemctl.  For instance, you can define a pod within quadlet, and then use systemctl to start and stop the entire pod.  When these pods are then stopped, they are deleted, and then when they are started, they are re-created from the definition.  Turning container updates into a simple `systemctl stop <podname>` then `systemctl start <podname>`.

  In this lab we will use all of these technologies to show you how to more easily manage container's on your Red Hat Enterprise Linux system.

  # Making our pod
  Let's start out by creating a pod, and some containers.  Then later we'll export that pod's definition for use with Quadlet.

  Making a pod is easy, we just use `podman pod create` and tell podman what to call our pod, and what Ports to forward into the containers within the pod.

  ```bash,run
  podman pod create --name my-app -p 8080:80
  ```

  With the pod created, we will need to make some containers, and tell them what pod to attach to using the `--pod` command line options.

  ```bash,run
  podman run -d --pod my-app --name http registry.access.redhat.com/ubi9/httpd-24
  ```

  We'll also create a second container within our pod for a database back-end.
  ```bash,run
  podman run -d --pod my-app --name database -e MYSQL_ROOT_PASSWORD="r3dh@t123" -e MYSQL_USER="dbuser" -e MYSQL_PASSWORD="redhat" -e MYSQL_DATABASE="testdb" quay.io/fedora/mariadb-105
  ```

  And now, if we check `podman pod ps` we should see our pod running with 3 containers (one of them is the infrastructure container for the pod).
  ```bash,run
  podman pod ps
  ```
<pre type=file>
# podman pod ps
POD ID        NAME        STATUS      CREATED         INFRA ID      # OF CONTAINERS
89f060fcc759  my-app      Running     12 minutes ago  e5906434e3f9  3
</pre>

We can check on the log output from the entire pod at once as well.
```bash,run
podman pod logs my-app
```

now, we can generate a Kube definition of our pod, using `podman generate`.  We will use this later in our exercise.

```bash,run
podman generate kube my-app -f my-app.yaml
```
Now you have a my-app.yaml in your working directory.  Feel free to have a look at it.
```bash,run
cat my-app.yaml
```

Now, we can stop our pod, and delete it.  It can be re-created using this yaml definition.
```bash,run
podman pod stop my-app&&podman pod rm my-app
```
```bash,run
podman play kube my-app.yaml
```