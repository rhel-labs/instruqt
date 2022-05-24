---
slug: apply
id: m3fknhr6o0jo
type: challenge
title: Apply the File Access Policy
teaser: Apply the File Access Policy
notes:
- type: text
  contents: Apply the File Access Policy
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 10
---
Now that we've seen how the daemon is configured, let's see it in action.

Switch to the user `rhel`.

```bash
su - rhel
```

In the user's home directory is a compiled binary, `cowsay`. There is nothing inherently malicious about this binary, though it provides a good example for our application control workflow.

You should have no problems executing the `cowsay` binary:

```bash
./cowsay "mooooo"
```

Let's start up fapolicyd and see what happens:

```bash
sudo systemctl start fapolicyd
```

The password is `redhat`.

```bash
redhat
```

Now run the `cowsay` command again.

```bash
./cowsay "mooooo"
```

You'll obtain the following error.

![opnotpermitted](../assets/opnotpermitted.png)

Great! Because the `cowsay` binary isn't in the RPM database, or the file-backed trust database configured at `/etc/fapolicyd/fapolicyd.trust`, the execution is blocked.

What if we know that this binary is trusted, and we want to allow it on the system? We have a couple of options:

* We could create a RPM spec file for the binary, build an RPM, sign it, and install it into the RPM database
* We can update the file-backed trust database

The second option seems better for this scenario - let's update the file-backed trust database. We can use the `fapolicyd-cli` to update the trust source:

```bash
sudo fapolicyd-cli --file add /home/rhel/cowsay
```

If we take a look at the file `/etc/fapolicyd/fapolicyd.trust` we can see that changes that have been made:

```bash
sudo cat /etc/fapolicyd/fapolicyd.trust
```

* The full-path to the file is listed (`/home/rhel/cowsay`)
* The size of the file has been calculated and added
* The SHA-256 hash for the file has been calculated and added

Remember that we have `integrity = none` in our fapolicyd config file? These last two attributes - size and the SHA-256 has - are used for integrity checking. We'll take a closer look at this in the next step of the lab.

Now you can update the daemon:

```bash
sudo fapolicyd-cli --update
```

Let's try the binary again:

```bash
./cowsay "mooooo"
```

Success! We've verified that fapolicyd can block unauthorized processes and applications on a system, and that we can manage exceptions for trusted applications.
