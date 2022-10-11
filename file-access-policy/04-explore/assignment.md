---
slug: explore
id: 9awbr1y6xpk3
type: challenge
title: Explore fapolicyd integrity
teaser: Explore fapolicyd integrity
notes:
- type: text
  contents: Explore fapolicyd integrity
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
Let's take a quick look at fapolicyd and integrity. The `more` command is installed via the RPM database, so it's trusted to execute on the system:

```bash
sudo rpm -qf /bin/more
```

What if the more command was substituted out for something malicious? First, let's verify that fapolicyd is still running:

```bash
sudo systemctl status fapolicyd
```

Now let's substitute the `more` command for the `cowsay` binary in our user's home directory:

```bash
sudo /bin/cp ./cowsay /bin/more
```

```bash
/bin/more "mooooo"
```

Hmmmm. So by default, fapolicyd doesn't check what the file looks like, only where it is executing from. This means that an attacker could potentially hijack the execution path of a trusted file, and execute malicious code on behalf of a user.
