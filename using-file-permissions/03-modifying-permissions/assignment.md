---
slug: modifying-permissions
id: 6batiimvpiyd
type: challenge
title: Changing permissions (symbolic)
teaser: Using the `chmod` command with symbolic paths
notes:
- type: text
  contents: |-
    The `chmod` command is how you modify the permissions associated with files and directories. The `chmod` command has two different ways to modify permissions: symbolic and absolute. Symbolic permissions have the same format as the access mode output of `ls -l`.  In this mode, you use the characters `r`, `w`, and `x` to set the read, write, and execute permissions. The other mode, absolute, instead uses a series of three numbers to correspond to the permissions for the owner, group, and others. These numbers are identical in meaning to the symbolic mode breakdown, they are just more compact and therefore quicker to type. Here is an example of how the two modes relate from Boolean World:

    ![Absolute vs Symbolic permissions](https://github.com/rhel-labs/learn-katacoda/raw/master/instruqt/file-permissions/assets/absVsSym.png)

    Image credit: Boolean World, ["An Introduction to Linux File Permissions"](https://www.booleanworld.com/introduction-linux-file-permissions/)

    >_NOTE:_ This image refers to absolute mode as numeric mode. These two terms are interchangeable and you will commonly see both.

    The crucial takeaway is that each character in a symbolic permission can be converted to a binary number, 1 if the user has that permission and 0 if the user does not. These three binary numbers become a single octal digit, and three such octal digits compose an absolute representation of the file's permissions.

    The upcoming sections walk through a examples of changing permissions using each of these two modes.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
In this step, you will be modifying the permissions on the `status.sh` script using symbolic syntax with the `chmod` command. In the previous step, you were unable to execute __status.sh__ as __guest__. To change that, use the `chmod` command. The plus (`+`) operator will add any permissions that you specify, but it will not change any permissions that you do not explicitly set in the command. So in this case, it will give others read and execute access, but will not change the value of write access for the group. Return to the root terminal to execute this command.

First we'll exit the `guest` account.

```bash
exit
```

Now change the permission of `status.sh`.

```bash
chmod o+rx status.sh
```

Verify that this command succeeded using `ls -l`, specifying that you want to only look at __status.sh__.

```
ls -l status.sh
```

<pre class=file>
-rwxr-xr-x. 1 root root  66 Jun  2 22:42 status.sh
</pre>

>_NOTE:_ Just as `o+rx` added read and execute permissions for others, `chmod` accepts the `-` argument to take away permissions. For example, `o-w` would remove write privileges from others while leaving the read and execute values untouched. The `=` argument can be used to explicitly set all permissions symbolically.

Now the __guest__ user will be able to read and execute __status.sh__. Switch back to the guest terminal:

```
su - guest
```

and re-run the status script:

```
cd /srv
./status.sh
```

<pre class=file>
status.sh successfully executed by guest
</pre>

Since you added read and execute permissions, you can do more than just execute this file as __guest__. Use the `cat` command to verify that you can read this file as __guest__.

```
cat status.sh
```

<pre class=file>
#!/bin/bash
echo -n "status.sh successfully executed by "
whoami
</pre>

Symbolic mode is the more expanded permissions format which can appeal to newer users. However, the absolute mode described in the next step can save on keystrokes if you take the time to familiarize yourself with it.