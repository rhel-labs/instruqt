---
slug: update
id: 48nakfxpdogc
type: challenge
title: Update the File Access Policy
teaser: Update the File Access Policy
notes:
- type: text
  contents: Update the File Access Policy
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
What if we know that the `cowsay` binary is trusted, and we want to allow it on the system? We have a couple of options:

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
