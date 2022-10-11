---
slug: 07-find-audit-permissions
id: 7qn94deb2lnn
type: challenge
title: Auditing permissions
teaser: Using `find` to audit permissions
notes:
- type: text
  contents: The `find` command is highly versatile, but in this case you will be using
    it to locate files that have permissions that may pose security risks.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
The `-perm` option causes the `find` command to look at the access modes for each file. In this case you are calling `find` without a path, which means it will start looking in the current directory. First, check for files that have the permission level __755__.

```
find -perm 755
```

This returns only a hidden OS file:

<pre class=file>
.
</pre>

>_NOTE:_ Recall from the previous step that __755__ corresponds to read, write, and execute access for the owner, and read and execute access for everyone else.

Consider a situation where you have determined that any permissions above a certain level could pose a security issue. Adding a dash before the permission tells the `find` command to return anything with a permission greater than or equal to the one you are searching for.

```
find -perm -755
```

<pre class=file>
.
./proprietary/contract01.txt
./proprietary/contract02.txt
./proprietary/contract03.txt
./proprietary/contract04.txt
</pre>

Notice that this returns many more files. You may not have seen these files from the output of `ls -l`, but `find` searches recursively so it can find files that otherwise may slip through the cracks. The contract files in the  __proprietary__ directory should not be readable by everyone. Furthermore, since these are text files, they should not be executable.

Running the `chmod` command with a level of __600__ ensures that these files are readable and writable by the owner, but others cannot access them. Instead of running `chmod` individually on each file, you can use the `find` command to execute this permission change on any file that exceeds a certain permission level. The `-type f` option only targets files, so the directory permissions will remain unchanged. The `{} \;` at the end of the command is telling `find` to execute the `chmod` command separately on each file that matches the search criteria.

```
find -perm -755 -type f -exec chmod 600 {} \;
```

To verify that access has been removed, try to read one of the files as the guest account. Switch to the __guest__ terminal and run this command:

```
cat proprietary/contract01.txt
```

<pre class=file>
cat: proprietary/contract01.txt: Permission denied
</pre>

>_NOTE:_ You may be tempted to use `chmod` with the recursive option (`-R`) to make this change instead of using `find`. The `chmod -R` command modifies subdirectories  as well as files, however. Since you are removing execute permissions, using `chmod` recursively would lead to a situation where you could not `cd` into any of the subdirectories that you just modified. This would also prevent you from running any recursive operations to fix this issue, and you would have to manually change the permissions on each subdirectory individually.

It is very important to double check your work when using the `find` to execute `chmod`, as running this command on the wrong directory could lock users out of all of their files.

This step is based on information from the [Enable Sysadmin article on the topic](https://www.redhat.com/sysadmin/audit-permissions-find). Head there for more information on increasing the specificity of what `find` returns.