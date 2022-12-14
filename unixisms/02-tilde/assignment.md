---
slug: tilde
id: jkqa10tzpfkv
type: challenge
title: What is the '~' directory?
notes:
- type: text
  contents: |
    # What is the `~` directory?
    Linux is filled with shortcuts, and learning these shortcuts is a crucial step to speeding up your work. One such shortcut is the tilde `~`.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

The tilde `~` is aliased to the current user's home directory. To test out some applications of this, change directories to the root directory of the system:

```bash
cd /
```

The `~` alias works in any case where you have to specify a path. If you wanted to list the contents of the _openscap_data_ subdirectory located in the home directory of __root__, the following command is
valid:

```bash
ls ~/openscap_data
```

<pre class=file>
eval_remediate_report.html  eval_remediate_results.xml
</pre>

>_NOTE:_ This is another place where you can practice tab completion.
Typing `ls ~/op` and then pressing tab will complete the path for you
since there is nothing else in __root__'s home directory starting
with `op`.

This means that running `cd ~` will always change directories to
the home directory of the user that you are logged in as.

```bash
cd ~
```

You will see that your current directory has changed from

<pre class=file>
root@rhel:/#
</pre>

to

<pre class=file>
root@rhel:~#
</pre>

>_NOTE:_ The `cd` command contains yet another shortcut, where
running `cd` without any arguments will behave the same as
running `cd ~`.

Print the full path to the directory you are currently in,
the `~` directory, using the "print working directory" command:

```bash
pwd
```

<pre class=file>
/root
</pre>

This shows that `~` is equivalent to `/root`, the home directory for the __root__ user. Try the same test for a different user account on this system, __rhel__. Switch to __rhel__ in the second terminal tab:

```bash
su - rhel
```

Adding the `-` after `su` will automatically change directories into the __rhel__ user's home directory, so print the full directory again:

```bash
pwd
```

<pre class=file>
/home/rhel
</pre>

You can see that when logged in as __rhel__, `~` is equivalent to `/home/rhel`, which is the __rhel__ user's home directory.

>_NOTE:_ The __root__ user home directory is in a unique location, `/root`. All other users' home directories will be located following the convention `/home/<username>`, as in the case of the __rhel__ user's home directory.
