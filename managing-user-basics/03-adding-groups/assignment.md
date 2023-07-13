---
slug: adding-groups
id: pcxkaatrea0j
type: challenge
title: Adding Groups
teaser: Working with the groupadd command
notes:
- type: text
  contents: |-
    This next step will demonstrate how to add users to groups on a system.

    Groups are useful ways to carry out batch operations on a set of users. For example, files can be given permissions which apply to all users in the group that owns that file.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Create a group called __viewers__ using the `groupadd` command. You will use the `-g` option to specify a group ID (GID), in this case 10000:

```bash
groupadd -g 10000 viewers
```

>_NOTE:_ Every time a new user is created, there is a primary group that is automatically generated for the user. When creating your own group, it is best practice to specify a GID that leaves room for primary groups to be be generated with the same ID as the user account. New user IDs are typically generated ascending from 1000.  Selecting a GID of 10000 in this example ensures that new user accounts will have ample space to generate their own primary group IDs that are equivalent to their user ID.

Search for the group name in the `/etc/group` file to confirm this was successful:

```bash
grep -w viewers /etc/group
```

<pre class=file>
viewers:x:10000:
</pre>

This file shows the group name, the GID, and which users belong to the group. In this case, __viewers__ does not yet have any users associated with it, but you can see the custom GID of 10000 was successfully set. Now you will see how to add users to this group.

# Adding users to a group

Now that you have created this group, add the __guest__ user from the previous step to the __viewers__ group using `usermod`. You will use the secondary group option (`-G`) in conjunction with the append option (`-a`) to add __viewers__ without overwriting any existing groups associated with __guest__.

```bash
usermod -aG viewers guest
```

The `groups` command is useful for validating this change, because it lists all groups associated with a user:

```bash
groups guest
```

<pre class=file>
guest : guest viewers
</pre>

The __viewers__ group has been added alongside the account's primary group (__guest__).

>_NOTE:_ Using the secondary group option (`-G`) adds __viewers__ as a _secondary group_ for the __guest__ user. Users can have any number of secondary groups. If you instead wanted to replace the primary group for __guest__, use `-g` when calling `groupadd`. You cannot use `-a` to append a primary group, as users can only have one primary group.
