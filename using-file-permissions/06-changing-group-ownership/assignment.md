---
slug: changing-group-ownership
id: hmwnvyeqkynq
type: challenge
title: Changing Group Ownership
teaser: Using the `chgrp` command
notes:
- type: text
  contents: Changing group ownership can be much more efficient than manually assigning
    owners, when there are many users that should have the same access to a file.
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
Group ownership can be changed with the `chgrp` command by adding a colon before the name of the group.

Return to the **Root tab**.

Change the group permission of the __tasks.txt__ file:

```bash
chown :team tasks.txt
```

Verify the change using `ls -l`:

```bash
ls -l tasks.txt
```

<pre class=file>
-rwxr-x---. 1 rhel team 117 Jun  2 23:01 tasks.txt
</pre>

This change is reflected in the fourth column of the `ls -l` output, which now says __team__ instead of __root__.

>_NOTE:_ Some people prefer the `chgrp` command for changing groups as it has identical syntax to `chown`, you do not have to add a colon when using `chgrp`. Others prefer to use `chown` with the colon as above so that they do not have to remember two different commands.

The final step in this lab will walk you through using `find` to locate any files that may have their permissions configured incorrectly.
