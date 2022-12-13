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

```bash
./status.sh
```

![status script run](../assets/statusscriptrun.png)

Let's focus on the permissions of `status.sh`.

<a href="#1">
 <img alt="1" src="../assets/status-sh-permissions.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/status-sh-permissions.png" />
</a>

The first three letters of the access mode show that the owner of the file has full permissions, __rwx__, so the owner can read, write, and execute this file. See the image below.

<a href="#2">
 <img alt="2" src="../assets/status-sh-permissions2.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/status-sh-permissions2.png" />
</a>

Users in the group that owns this file have __r-x__, so they can read and execute but cannot write to this file. See the image below.

<a href="#3">
 <img alt="3" src="../assets/status-sh-permissions3.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/status-sh-permissions3.png" />
</a>

Finally, all other users have no permissions, __---__, so they are unable to read, write, or execute this file.

<a href="#4">
 <img alt="4" src="../assets/status-sh-permissions4.png" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/status-sh-permissions4.png" />
</a>


Switch to the `Guest` tab and traverse into the `/srv` directory.

```bash
cd /srv
```

![srv guest](../assets/srvguest.png)

Try executing the status script as __guest__. Since the guest account is not the user owner of the file and is not part of any owner groups, you are unable to execute this script from this user account.

```bash
./status.sh
```

![denied!](../assets/permissiondeniedasguest.png)

Now that you know how files behave differently when operated on by different user accounts, the next steps will show you how to customize permissions to control this behavior.

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
