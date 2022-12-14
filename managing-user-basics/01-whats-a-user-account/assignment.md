---
slug: whats-a-user-account
id: 17fjy0blvoga
type: challenge
title: Creating user accounts with useradd
teaser: Working with the useradd command
notes:
- type: text
  contents: |-
    Linux is designed to be a multi-user system. User accounts are the segmentation method that keeps each individual from getting in each other's way.

    User accounts are tied to file permissions, meaning that users can control who has the ability to modify various files on the system. These user accounts also provide traceability if there is a file or process that is hogging system resources.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
---

Add a new account called __guest__ using the `useradd` command:

```bash
useradd guest
```

Confirm the account creation by examining the __passwd__ file.

```bash
grep -w guest /etc/passwd
```

<pre class=file>
guest:x:1005:1006::/home/guest:/bin/bash
</pre>

Next, a password needs to be added to the user account to enable login.
