---
slug: running-init
id: ojyme7ny6loc
type: challenge
title: Running init in your container
tabs:
- id: 0m3ytsk29ro6
  title: Terminal
  type: terminal
  hostname: rhel
- id: betryoal0rqx
  title: Containerfile
  type: code
  hostname: rhel
  path: /root/my-container/Containerfile
difficulty: basic
timelimit: 1
enhanced_loading: null
---

## Running containers with init

Some container base images, offer the ability to start services using a lightweight init system, rather than calling them directly in the foreground.  The container community usually frowns upon running service this way, but some services were simply not designed to run without being controlled by an init system.  And running them in the foreground could lead to data corruption if the foreground process does not exit properly when the container exits.  If you would like to run a container using init, this might be a helpful example for you.

First, let's Switch back over to the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab, and open up the `Containerfile`.

The RHEL UBI base image that we've been using, has an alternate build that supports a stripped down systemd init.  You can use it simply by following a few basic steps.  First we need to change the `FROM` line to:

```
FROM registry.access.redhat.com/ubi9/ubi-init
```

Now, we also need to enable the httpd service within systemd. So, somewhere after httpd is installed, but before the `CMD` you should add the following:

```
RUN systemctl enable httpd
```

In our example we add this as the last line before `CMD`.

The last change we need to make is the `CMD` itself.  Change `CMD` to :

```
CMD ["/sbin/init"]
```

Your `Containerfile` should now look like this:

<pre type="file">
FROM registry.access.redhat.com/ubi9/ubi-init
RUN dnf -y install httpd
EXPOSE 80
COPY app/index.html /var/www/html
RUN systemctl enable httpd
CMD ["/sbin/init"]
</pre>

Switch back to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab, so we can continue with the container image build.

Now let's build our new container image.  But maybe we're building this as an alternative to the standard `my-container`, or perhaps we're testing this and do not want to replace `my-container`, so let's give this build a descriptive tag.

```bash,run
cd ~/my-container
podman build -t my-container:init .
```

This should build us a new version of the image, starting from scratch, based on the new base image.

```bash,run
podman image list
```

<pre type="file">
REPOSITORY                                TAG         IMAGE ID      CREATED         SIZE
localhost/my-container                    init        67ad17fb6a7a  9 minutes ago   457 MB
localhost/my-container                    latest      927f6e6bd6b9  14 minutes ago  440 MB
registry.access.redhat.com/ubi9/ubi-init  latest      1b963a3e7137  15 hours ago    252 MB
registry.access.redhat.com/ubi9/ubi       latest      b21b662817da  19 hours ago    234 MB
</pre>

Notice that there are now two images named `localhost/my-container`, but they have different tags, init, and latest.  Let's run a new container with the new image. Again, we'll need to be sure that our old container is stopped first.

```bash,run
podman stop my-httpd
podman run -d -p 80:80 --name my-httpd-init my-container:init
```

Now, you should once again be able to connect to your container with curl.

```bash,run
curl http://127.0.0.1
```
