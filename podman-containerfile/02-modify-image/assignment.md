---
slug: modify-image
id: mgpsisqjpim2
type: challenge
title: Modify your container image
tabs:
- id: lqmxtymehsuy
  title: Terminal
  type: terminal
  hostname: rhel
- id: 3ije4pdbzeka
  title: Containerfile
  type: code
  hostname: rhel
  path: /root/my-container/Containerfile
difficulty: basic
timelimit: 1
enhanced_loading: null
---
In this step, we're going to make a simple change to our `Containerfile` and re-build our image.

## Modifying a Containerfile

At the top of the lab environment, you should see a new tab, called Containerfile.  If you click on that tab, you will see the contents of our Containerfile in an online editor.

Let's Switch to the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab, and open up the `Containerfile`.

After the line `EXPOSE 80` add the following command

```
COPY app/index.html /var/www/html
```

Now, switch back to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab, and let's re-build our image.

```bash,run
cd ~/my-container
podman build -t my-container .
```

This should re-build our container, but you'll notice that it does not go through the installation of httpd.  That's because our change happened after that command.  So podman doesn't re-create those layers, it picks up at the first different command.

<pre type="file">
STEP 1/5: FROM registry.access.redhat.com/ubi9/ubi
STEP 2/5: RUN dnf -y install httpd
--> Using cache def4d585daf2cf603426258667deda4623cc4c9f34219cab56eb09aeb896bad3
--> def4d585daf2
STEP 3/5: EXPOSE 80
--> Using cache 15a26e2e2fd302500a00337119a5de75e102fad955fa672d05bf8129bcc506af
--> 15a26e2e2fd3
STEP 4/5: COPY app/index.html /var/www/html
--> 7e444e3c5d8d
STEP 5/5: CMD ["/usr/sbin/httpd","-DFOREGROUND"]
COMMIT my-container
--> 28231e172741
Successfully tagged localhost/my-container:latest
28231e172741202495a8727916945ed0398ae087b37b115dcd52752a1067b75d
</pre>

Now, we can run a container from our image.

First, we should still have a running container from the last exercise.  You can stop it, and remove it with:

```bash,run
podman stop my-httpd && podman rm my-httpd
```

If our goal is to replace the old container with a new container running the new deployment of our app, we'll have to stop our old container.  We do not necessarily have to remove it though, we do here because we are re-using the same container name.  If instead we wanted to run the container with a new name, we could have stopped `my-httpd` and then started a new container with a new name.  If we didn't stop the old container, we would not be able to start the new container on port 80.

```bash,run
podman run -d -p 80:80 --name my-httpd my-container
```

With the new container running, we can test it with curl.

```bash,run
curl http://127.0.0.1
```

How, instead of the stock "It Worked" apache page, you should get the contents of the index.html we copied in.

In the next step, we're going to show you another way that you might run services inside of your container.



