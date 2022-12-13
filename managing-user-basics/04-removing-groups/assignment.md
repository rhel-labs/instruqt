---
slug: removing-groups
id: j3vufyz08aoi
type: challenge
title: Removing a user for a group
teaser: Working with the `gpasswd` and `groupdel` commands
notes:
- type: text
  contents: In this next step you will practice removing user accounts from groups.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

If you want to remove a user from a group without deleting the group, run the following command:

```bash
gpasswd -d guest viewers
```

<pre class=file>
Removing user guest from group viewers
</pre>

>_NOTE:_ This change will not take effect until the user logs in again.

## Deleting a group

If instead you want to delete the group all together, run the `groupdel` command as root.

```bash
groupdel viewers
```

 If you are trying to remove the primary group of a user, you must remove that user first.

Attempting to add a user to this group will print an error message showing that it now does not exist.

```bash
usermod -aG viewers guest
```

<pre class=file>
usermod: group 'viewers' does not exist
</pre>
