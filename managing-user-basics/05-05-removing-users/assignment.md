---
slug: 05-removing-users
id: eltbbsrgt6jb
type: challenge
title: Removing Users
teaser: Working with the `usermod` and `userdel` commands
notes:
- type: text
  contents: |-
    In this final step, you will walk through the process of removing a user from the system.

    If a user is leaving your organization, you will want to disable an account. Unlike deleting the account, this maintains their files and account information, but prevents them from accessing the system using their credentials.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 600
---
The `usermod` command has a lock password option (`-L`) which informs the system to stop accepting a user's login attempts.

```
usermod -L guest
```

This operation does not have an output, but calling `passwd` with the summary option (`-S`) allows you to confirm this change.

```
passwd -S guest
```

<pre class=file>
guest LK 2021-10-21 0 99999 7 -1 (Password locked.)
</pre>

After expiring this account, __root__ will still be able to log in. However, no other user will be able to access __guest__.

>_Note:_ If you prefer, `chage` can accomplish this same functionality. Run `chage` with no arguments to see a summary of the account access features this command provides.

# Deleting a user account

Sometimes you may want to do more than just disable the account. Deleting a user is very similar to deleting a group. Running `userdel guest` removes the __guest__ account from the system. It is often the case that you would also want to delete this user's home directory. This avoids a new user account inheriting __guest__'s files when the new account inherits the user ID that used to belong to __guest__. If you do wish to delete the home directory along with the account, first back up __guest__'s files. Then, add the `-r` option to specify that you wish to delete the user's home directory along with the user account.

```
userdel -r guest
```

Try logging in as __guest__ to confirm the account deletion:

```
su - guest
```

<pre class=file>
su: user guest does not exist
</pre>

Also confirm that the __guest__ home directory has been deleted:

```
ls /home/guest
```

<pre class=file>
ls: cannot access '/home/guest': No such file or directory
</pre>

>_NOTE:_ If you try to delete a user that still has active processes, you will get the error displayed below. You must kill this user's processes and try again.

<pre class=file>
userdel: user guest is currently used by process 1909
</pre>