---
slug: interacting-with-different-users
id: eqlj1dxwvlwq
type: challenge
title: Interacting with a file from different user accounts
teaser: Working with user permissions
notes:
- type: text
  contents: 'In this step, you will be executing the `status.sh` script as two different
    user accounts: __root__, which owns the file, and __guest__, who falls into the
    _other users_ permissions category. This script prints the user who executed it,
    so you will be able to clearly see whether or not a specific user can execute
    the script.'
tabs:
- title: Root
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "root" > /dev/null 2>&1
- title: Guest
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "guest" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Recall from the previous step that __status.sh__ has the following permissions:

<pre class=file>
-rwxr-x---
</pre>

Therefore, __root__ has permission to execute this script. Run the script by copying and pasting the following into the terminal window.

```
./status.sh
```

![status script run](../assets/statusscriptrun.png)

Let's focus on the permissions of `status.sh`.

![status permissions](../assets/status-sh-permissions.png)

The first three letters of the access mode show that the owner of the file has full permissions, __rwx__, so the owner can read, write, and execute this file. See the image below.

![status2](../assets/status-sh-permissions2.png)

Users in the group that owns this file have __r-x__, so they can read and execute but cannot write to this file. See the image below.

![status3](../assets/status-sh-permissions3.png)

Finally, all other users have no permissions, __---__, so they are unable to read, write, or execute this file.

![status4](../assets/status-sh-permissions4.png)

Switch to the bottom pane in the terminal by pressing `ctrl-b`, releasing the keys, then pressing the down arrow.

![switch](../assets/switchpanes.png)

Switch to the `Guest` tab and traverse into the `/srv` directory.

```bash
cd /srv
```

![srv guest](../assets/srvguest.png)

Try executing the status script as __guest__. Since the guest account is not the user owner of the file and is not part of any owner groups, you are unable to execute this script from this user account.

```
./status.sh
```

![denied!](../assets/permissiondeniedasguest.png)

Now that you know how files behave differently when operated on by different user accounts, the next steps will show you how to customize permissions to control this behavior.