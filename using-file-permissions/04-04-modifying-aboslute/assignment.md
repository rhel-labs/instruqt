---
slug: 04-modifying-aboslute
id: buys41zo6wcp
type: challenge
title: Changing permissions (absolute)
teaser: Using `chmod` with an absolute path
notes:
- type: text
  contents: |-
    Now your next goal is to modify the permissions on __status.sh__ to keep full access for the owner and group members, but prevent anyone else from writing to or executing the file. You can do this with three numbers if you use the absolute syntax.

    The number you would use to do this with `chmod` is __774__. The image below explains how the absolute permission of __774__ relates to the access mode string that is output by `ls -l`.

    ![Absolute permission breakdown](https://github.com/rhel-labs/learn-katacoda/raw/master/instruqt/file-permissions/assets/absBreakdown.png)
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
The owner user and owner group will have full permissions, but others will only be able to read the file. Return to the first terminal where you are logged in as __root__. Use `chmod` to modify the permissions on __status.sh__ as discussed above:

```chmod 774 status.sh
```

Confirm that this change has succeeded by checking the access mode for __status.sh__

```
ls -l status.sh
```

<pre class=file>
-rwxrwxr--. 1 root root  66 Jun  2 22:42 status.sh
</pre>

Now, from the guest terminal, verify that you do not have permission to execute the status script as __guest__:

```
./status.sh
```

<pre class=file>
bash: ./status.sh: Permission denied
</pre>

However, if you try to read this file, you will see you do have read access as __guest__:

```
cat status.sh
```

<pre class=file>
#!/bin/bash
echo -n "status.sh successfully executed by "
whoami
</pre>

>_NOTE:_ You can use `vi` or any other write command to verify that you do not have write access as __guest__ if you wish to verify this as well.

Many users default to absolute permissions because of how much quicker they are to type. If you are still unsure exactly what these commands are doing, please check out the “How do I manage permissions?” section of [this Enable Sysadmin article](https://www.redhat.com/sysadmin/manage-permissions) to learn more.

The next step will walk you through changing which user owns a file.