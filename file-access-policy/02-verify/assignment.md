---
slug: verify
id: m3fknhr6o0jo
type: challenge
title: Verify the File Access Policy
teaser: Verify the File Access Policy
notes:
- type: text
  contents: Verify the File Access Policy
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
Now that we've seen how the daemon is configured, let's see it in action.

Switch to the user `rhel`.

```bash,run
su - rhel
```

Let's pull down a new application from an internet source, `cowsay`. There is nothing inherently malicious about this binary, though it provides a good example for our application control workflow.

```bash,run
curl -L -O https://github.com/Code-Hex/Neo-cowsay/releases/download/v2.0.4/cowsay_2.0.4_Linux_x86_64.tar.gz
```
Now, extract `cowsay` into the user's home directory.
```bash,run
tar xsf cowsay_2.0.4_Linux_x86_64.tar.gz
```

You should have no problems executing the `cowsay` binary:

```bash,run
./cowsay "mooooo"
```

Let's start up fapolicyd and see what happens:

```bash,run
sudo systemctl start fapolicyd
```

The password is `redhat`.

```bash
redhat
```

Now run the `cowsay` command again.

```bash,run
./cowsay "mooooo"
```

You'll obtain the following error.

![opnotpermitted](../assets/opnotpermitted.png)

Great! Because the `cowsay` binary isn't in the RPM database, or the file-backed trust database configured at `/etc/fapolicyd/fapolicyd.trust`, the execution is blocked.
