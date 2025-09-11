---
slug: explore
id: zmdtd6otpfio
type: challenge
title: Explore fapolicyd integrity
teaser: Explore fapolicyd integrity
notes:
- type: text
  contents: Explore fapolicyd integrity
tabs:
- id: 5yb7hqlxxemx
  title: rhel
  type: terminal
  hostname: rhel
- id: y1gwy4eaickr
  title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Let's take a quick look at fapolicyd and integrity. The `more` command is installed via the RPM database, so it's trusted to execute on the system:

```bash,run
sudo rpm -qf /bin/more
```

What if the more command was substituted out for something malicious? First, let's verify that fapolicyd is still running:

```bash,run
sudo systemctl status fapolicyd
```

Now let's substitute the `more` command for the `cowsay` binary in our user's home directory:

```bash,run
sudo /bin/cp ./cowsay /bin/more
```

```bash,run
/bin/more "mooooo"
```

Hmmmm. So by default, fapolicyd doesn't check what the file looks like, only where it is executing from. This means that an attacker could potentially hijack the execution path of a trusted file, and execute malicious code on behalf of a user.
