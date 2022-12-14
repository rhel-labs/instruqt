---
slug: find
id: nvypxpvt3e3t
type: challenge
title: Locating files
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

Manipulating files is only useful if you can locate the file you need. This step will walk you through two commands that are useful for this, `locate` and `find`.

The `find` command is great for searching for files which satisfy some specified criteria. This step will show an example using the filename, but you can also use it to look for files with certain permissions, empty files, or much more.

```bash
find / -name messages
```

<pre class=file>
/var/log/messages
</pre>

The output is the full path to the file. If there are multiple matches, then this output would have multiple lines and it would be up to the user to decide which is the appropriate file. Instead of having to search through countless directories, you can quickly locate the file.

>_Note:_ An in-depth explanation of using `find` to sort by file permissions is included in the [File Permissions Basics lab](https://lab.redhat.com/file-permissions).

`find` can be input/output intensive, which can sap system resources, especially if you run a search that will scan a large amount of candidate files. In fact, the search above is exactly that kind of search, since it is looking for filenames starting from the root directory. It will check every single file on the entire system to see if it is a match. The `locate` command instead queries a database to avoid being too I/O intensive.

```bash
locate messages
```

<pre class=file>
<< OUTPUT ABRIDGED >>
/usr/share/vim/vim80/syntax/messages.vim
/usr/share/vim/vim80/syntax/msmessages.vim
/var/log/messages
</pre>

This command finds a variety of files containing _messages_ in their name, including the log file that you are looking for, `/var/log/messages`. The database that `locate` uses to optimize the search process is updated once per day by default, so that means if you are trying to locate a newly created file it will not be present in the database.

Create a new file with `touch`:

```bash
touch newFile
```

Try to find this newly created file using `locate`:

```bash
locate newFile
```

There will be no output, as _newFile_ is not in the `locate` database.
Update the `locate` database using the `updatedb` command:

```bash
updatedb
```

Re-run the `locate` command to look through the newly updated database:

```bash
locate newFile
```

<pre class=file>
/root/newFile
</pre>

Now the file is present. This is important to keep in mind so that you do not run into the frustrating situation where `locate` failed to find a file that existed all along.
