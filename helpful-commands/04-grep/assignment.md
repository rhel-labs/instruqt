---
slug: grep
id: jvpastubgocy
type: challenge
title: Searching for text within files and outputs
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

`find` is great if you are looking for criteria about a file, but if you instead want to locate specific file contents, the `grep` command is what you need. To illustrate this, search for the words you added to the _messages_ log file. The command below uses the `-r` option to search recursively from the starting directory (_/var/log_). This will return all locations in any file residing in a subdirectory of _/var/log_ that contain the string "Hello World".

```bash
grep -r "Hello World" /var/log
```

<pre class=file>
/var/log/messages:Jul 16 21:38:22 be3f7e9f7264 root[24468]: Hello World
</pre>

The output shows the line you added using `logger` earlier in this lab. If you do not specify a search location in the `grep` command, it will default to your current directory. Additionally, the string being searched for is case-sensitive by default. If you want a case-insensitive search, add the `-i` option.

```bash
grep -ir "hello world" /var/log
```

<pre class=file>
/var/log/messages:Jul 16 21:38:22 be3f7e9f7264 root[24468]: Hello World
</pre>

This option can save you from believing that a string does not exist if you weren't sure about how it was capitalized in the file.

Sometimes you may want to see a few more lines before or after the result of your search. This is done using the context option (`-C`). This option allows you to specify a number of lines before and after the result of the search to display.

```bash
grep -C1 fact quote.txt
```

<pre class=file>
Just thinking about everything I have been through, and how huge it all feels.
The fact that it is just a small part of something larger
makes it seem more manageable.
</pre>

>_NOTE:_ If you wish to only display lines after the result, use `-A` (context __a__fter). For lines before the result, use `-B` (context __b__efore).

Another way to leverage `grep` is by piping the output of another command into `grep` using the `|` operator. This saves you effort if you are just looking for a specific word or phrase in a lengthy output. You will get a chance to try this out in step 6 of this lab.
