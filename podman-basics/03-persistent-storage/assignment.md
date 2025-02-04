---
slug: persistent-storage
id: x6u1rwnztowr
type: challenge
title: Persistent Storage, and port forwarding
tabs:
- id: lajutiibrx9j
  title: Terminal
  type: terminal
  hostname: rhel
- id: f4xxl1wzblxo
  title: Test HTTPD container
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io
difficulty: basic
timelimit: 1
enhanced_loading: null
---
A container is ephemeral.  It's designed to be.  The whole idea of a container is, that if its not functioning properly, it can be killed and started back up fresh.  If it's compromised and someone lays down malware, just kill it and rebuilt it.  If there are updates  pushed to the code that runs in the container... You guessed it, kill it and rebuild it.  This sort of lack of persistence is very freeing, but it means... well.. You don't have any persistence.

No persistence is a problem for most applications.  Sure you could store all of your content in a database, or on some CDN, but sometimes you just need local files.  For that, you really need a place to store files, that doesn't go away when the container is deleted and re-created.  Podman, and docker, give us a few ways to accomplish this.  You can create named volumes, in a that support a variety of back-ends.  Or you can just map a local directory into your container.  This second method is what we'll cover here.

## Adding persistent storage

Adding local storage is pretty easy, there's a command-line argument that will pass along the local path, to the container path you'd like it mapped to. Let's try it.

You'll find a super-businessey web site inside of `~root/my-httpd/html`, let's map that to the location inside of this httpd container, that we know the web root exists in.

```bash,run
podman run -d -v ~/my-httpd/html:/usr/local/apache2/htdocs/:Z --name my-httpd httpd
```

Let's break down that `-v ~/my-httpd/html:/usr/local/apache2/htdocs/:Z`.

`-v` tells podman we're mapping in a local volume.
`~/my-httpd/html` is the local directory that we want to map to.  Then we put a `:` to denote the destination to map to.
`/usr/local/apache2/htdocs/` is the location inside of the container that we'd like to map to.
`:Z` this is a special command that tells podman to fix the SELinux contexts of the local file or directory that we've mapped in.  Containers are very picky about SELinux because that's part of how they are confined.  You should _definitely_ keep selinux in enforcing mode on a container host.

Now let's see if it worked!

```bash,run
podman exec my-httpd cat /usr/local/apache2/htdocs/index.html
```

You should get the same contents as if you'd looked at our local file.

```bash,run
cat ~/my-httpd/html/index.html
```

If you were to edit `~/my-httpd/html/index.html` those changes would immediately show up inside of the container as well.

But this only gets us one step closer to successfully running httpd inside of a container.  Without any network access, this container is still pretty useless.

## How container ports work

When a container image is written, the author adds special commands to the container definition that tells it what ports its supposed to listen on.  But you, as the container host administrator, need to then open those ports, much like you would in a firewall.  Podman doesn't do it automatically, for lots of reasons.  In the case of httpd, we know that it will listen on ports 80, and probably 443 if its configured with a TLS certificate.  But this one isn't.  If you look at the top of your lab environment, you'll see a tab that says `Test HTTPD Container`.  If you click on that, it'll open up a new browser tab and attempt to access our container, it should fail.

It fails because we haven't told podman to open port 80.  So let's do that.

## Forwarding a host port to a container.

Podman makes this rather easy as well.  You can even forward different ports to your container.  For example, if the container listens on 80, but you want to publish 8080, you can do that when you forward it.

First, let's stop and remove our httpd container.

```bash,run
podman stop my-httpd && podman rm my-httpd
```

Now, let's start it back up with our volume, and the forwarded port.

```bash,run
podman run -d -v ~/my-httpd/html:/usr/local/apache2/htdocs/:Z --name my-httpd -p 80:80 httpd
```

You'll see we added `-p 80:80` this tells podman to forward port 80 on our host to port 80 in the container.  If you wanted instead to forward the host port 8080 to 80, you'd enter `-p 8080:80`.  You can even forward a specific IP address's port to your containers port, if you have a system with several IP's associated with it.  That would look like `-p 10.2.3.4:80:80`.

Let's see if our container works now.  You should see my super-businessey web site!


