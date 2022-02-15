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
cat /etc/tcsd.conf
```

<pre class=file>
cat: /etc/tcsd.conf: Permission denied
</pre>

This configuration file's permissions prevent __rhel__ from reading its contents.
However, __rhel__ is part of the _wheel_ group, so you can circumvent this
permissions issue temporarily by prepending `sudo` to your previous command:

```
sudo cat /etc/tcsd.conf
```

<pre class=file>
<< OUTPUT ABRIDGED >>
#
# Option: disable_ipv6
# Values: 0 or 1
# Description: This options determines if the TCSD will bind itself to the
# machine's local IPv6 addresses in order to receive requisitions through
# its TCP port. Value of 1 disables IPv6 support, so clients cannot reach
# TCSD using that protocol.
#
#  disable_ipv6 = 0
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
