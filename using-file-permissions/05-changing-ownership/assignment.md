---
slug: changing-ownership
id: nns3sgpndgdz
type: challenge
title: Changing file ownership
teaser: Using the `chown` command
notes:
- type: text
  contents: Sometimes it is useful to change who owns a file so that permissions can
    align with the purpose of the file. The `chown` command can do this very easily.
    Just specify the new owner and the file you would like to change.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Exit the `guest` account.

```
exit
```

From the root terminal, confirm that __root__ is the initial owner of the file __tasks.txt__:

```
ls -l tasks.txt
```

<pre class=file>
-rwxr-x---. 1 root root 117 Jun  2 23:01 tasks.txt
</pre>

The third and fourth column of this output are the user and group that own the file. Right now, __root__ is the owner in both cases. Switch to the guest terminal and attempt to read the file:

```
su - guest
```

```
cat /srv/tasks.txt
```

<pre class=file>
cat: tasks.txt: Permission denied
</pre>

This read operation is denied, as __guest__ does not have read permission. Returning to the root terminal, change the user that owns __tasks.txt__ to __guest__:

```
exit
```

```
chown guest tasks.txt
```

Repeating the search shows that the owner (column 3) has been updated:

```
su - guest
```

```
ls -l /srv/tasks.txt
```

<pre class=file>
-rwxr-x---. 1 guest root 117 Jun  2 23:01 tasks.txt
</pre>

Now that __guest__ owns the file instead of __root__, this user has permission to read the file without reconfiguring the access modes.

```
su - guest
```

```
cat /srv/tasks.txt
```

<pre class=file>
1. Finish this Permissions Lab
2. Do the Networking Configuration Basics Lab
3. Listen to the latest episode of RHEL Presents
</pre>

The fourth column of the `ls -l` output is the group which owns the file. The next step will walk you through changing group ownership.

Exit the `guest` account.

```
exit
```