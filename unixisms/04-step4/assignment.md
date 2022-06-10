---
slug: step4
id: qbziwlyf9y9n
type: challenge
title: Step 4
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
timelimit: 600
---
# Running commands as __root__ vs using `sudo`

`sudo`, on the other hand, is a command which allows non-root users to
perform administrative tasks. Users in the _wheel_ group have access to the
`sudo` command.

>_NOTE:_ When logged in as __root__, the character in the command prompt is `#`. When you switch users to __rhel__, this character changes to `$`. __root__ will always be symbolized by `#` to give you the warning that any command you enter will be run with the highest level of administrative privileges.

Use the `su` command to switch to the __rhel__ user:

```
su - rhel
```

Then, try to access the following file:

```
cat /etc/shadow
```

<pre class=file>
cat: /etc/shadow: Permission denied
</pre>

This configuration file's permissions prevent __rhel__ from reading its contents.
However, __rhel__ is part of the _wheel_ group, so you can circumvent this
permissions issue temporarily by prepending `sudo` to your previous command:

```
sudo cat /etc/shadow
```

<pre class=file>
<< OUTPUT ABRIDGED >>
root:!*::0:99999:7:::
bin:*:18849:0:99999:7:::
daemon:*:18849:0:99999:7:::
adm:*:18849:0:99999:7:::
lp:*:18849:0:99999:7:::
sync:*:18849:0:99999:7:::
shutdown:*:18849:0:99999:7:::
halt:*:18849:0:99999:7:::
mail:*:18849:0:99999:7:::
operator:*:18849:0:99999:7:::
games:*:18849:0:99999:7:::
ftp:*:18849:0:99999:7:::
nobody:*:18849:0:99999:7:::
systemd-coredump:!!:19136::::::
dbus:!!:19136::::::
polkitd:!!:19136::::::
tss:!!:19136::::::
</pre>

`sudo` allowed you to access the contents of the file without changing the
associated permissions.

>_NOTE:_ `sudo !!` is a shortcut for rerunning the previous command with `sudo`

Assuming the system is properly configured, most users should not need to
regularly use `sudo` during day-to-day usage. This command should only be
necessary when making administrative changes. If you plan to make lots of
administrative changes, it can save you some time to log in as __root__.
However, the administrative block can act as a safeguard in the case that you
erroneously execute an operation that will modify the system. Seeing
"permission denied" will cause you to double check the command before re-running it
using `sudo`.
