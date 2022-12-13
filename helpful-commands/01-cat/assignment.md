---
slug: cat
id: h4xdmyhstyic
type: challenge
title: Manipulating file contents
notes:
- type: text
  contents: |
    # Overview:

    Faced with a blinking cursor on your command line, Linux can be intimidating to
    new users who do not know where to start. This lab is designed to show you a
    series of must-know commands that will prove useful on all facets of system
    administration, from finding files to checking the status of system resources.

    # Goal:

    Build a toolbox of basic commands useful to every Linux user.

    # Concepts included in this scenario:
    * Viewing file contents with `cat`
    * Viewing the last 10 lines of a file with `tail`
    * Appending command outputs to a file with the `>>` operator
    * Locating files that match certain criteria using `find` and `locate`
    * Using `grep` with other commands to isolate a portion of their output
    * Checking disk space with `df`
    * Viewing and managing processes with `ps` and `top`
    * Using `free` to view information about the system memory usage
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
---

The first step towards modifying files is knowing which files exist. Use `ls` to take a look at the contents of the current directory:

```bash
ls
````

<pre class=file>
root@rhel:~# ls
quote.txt
</pre>

Use the `cat` command to quickly check what is in file `quote.txt`. The `cat` command is short for "concatenate", but it is much more versatile than that name suggests.

```bash
cat quote.txt
````

<pre class=file>
Just thinking about everything I have been through, and how huge it all feels.
The fact that it is just a small part of something larger
</pre>

Now you can complete the quote by redirecting the output of the `echo` command. The command below uses the append redirection operator (`>>`) to cause the output of the `echo` command to be written to the end of the file _quote.txt_.

```bash
echo "makes it seem more manageable." >> quote.txt
````

There is no output, so view the file contents once again to see this change reflected:

```bash
cat quote.txt
````

<pre class=file>
Just thinking about everything I have been through, and how huge it all feels.
The fact that it is just a small part of something larger
makes it seem more manageable.
</pre>

The `>>` operator allows you to add to files from the command line and is particularly
useful in shell scripting. You can also use it when a command has a lengthy output
and you want to view that output in a text editor.

>_NOTE:_ You may also encounter the `>` redirection operator. This operator will write the output to a file, overwriting the file if it already exists. By contrast, the `>>` operator will append the output to the specified file. The input operator (`<`) will redirect data as an input to whatever is called before the operator. The pipe operator (`|`) is used to send the output of one command to another command so that you can carry out an operation on the results of the first command.
