---
slug: sudo
id: qbziwlyf9y9n
type: challenge
title: Running commands as __root__ vs using sudo
notes:
- type: text
  contents: |
    # Running commands as __root__ vs using `sudo`
    __root__ is the name of the administrator account. This account has the highest amount of control of any account on the system. If a person has the root password, they can access and make changes to any part of the system.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

`sudo`, on the other hand, is a command which allows non-root users to perform administrative tasks. Users in the _wheel_ group have access to the `sudo` command.

>_NOTE:_ When logged in as __root__, the character in the command prompt is `#`. When you switch users to __rhel__, this character changes to `$`. __root__ will always be symbolized by `#` to give you the warning that any command you enter will be run with the highest level of administrative privileges.

Use the `su` command to switch to the __rhel__ user:

```bash
su - rhel
```

Then, try to access the following file:

```bash
cat /etc/shadow
```

<pre class=file>
cat: /etc/shadow: Permission denied
</pre>

This configuration file's permissions prevent __rhel__ from reading its contents. However, __rhel__ is part of the _wheel_ group, so you can circumvent this permissions issue temporarily by prepending `sudo` to your previous command:

```bash
sudo cat /etc/shadow
```

<pre class=file>
<< OUTPUT ABRIDGED >>
apache:!!:19314::::::
clevis:!!:19314::::::
cockpit-ws:!!:19314::::::
cockpit-wsinstance:!!:19314::::::
setroubleshoot:!!:19314::::::
rhel:!!:19314:0:99999:7:::
bas:*:19557:0:99999:7:::
mochtar:*:19557:0:99999:7:::
ade:*:19557:0:99999:7:::
arslan:*:19557:0:99999:7:::
gke-930957db5604c7804fbd:*:19557:0:99999:7:::
gke-f34473de869e40d6894d:*:19557:0:99999:7:::
</pre>

`sudo` allowed you to access the contents of the file without changing the
associated permissions.

>_NOTE:_ `sudo !!` is a shortcut for rerunning the previous command with `sudo`

Assuming the system is properly configured, most users should not need to regularly use `sudo` during day-to-day usage. This command should only be necessary when making administrative changes. If you plan to make lots of administrative changes, it can save you some time to log in as __root__. However, the administrative block can act as a safeguard in the case that you erroneously execute an operation that will modify the system. Seeing "permission denied" will cause you to double check the command before re-running it using `sudo`.
