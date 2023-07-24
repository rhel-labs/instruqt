---
slug: kill
id: hhhza1syfujr
type: challenge
title: Killing processes
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: Terminal 2
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

Now that you found the `dd` process on Terminal 1, terminate it using the `kill` command. You would typically just manually enter the process ID after `kill`. The process ID is the second column of the `ps aux` output from before. However, to make this command clickable for each new lab instance the `pidof` (__P__rocess __ID of__) command is used to automatically find the process ID.

```bash
kill $(pidof dd)
```

There is no output, but switching back to Terminal 2 reveals that the `dd` process has been terminated.

<pre class=file>
Terminated
</pre>

The `kill` command can send a variety of signals. Calling the command without any options will default to `-SIGTERM`. This command will inform the process that it is time for it to stop, but allow it to run any cleanup procedures that it has. This often takes the form of closing files and freeing memory. In this sense, `-SIGTERM` is the graceful option for terminating a process.

If you instead use the `kill -SIGKILL` command, this will instruct the kernel to immediately stop the process. This prevents any cleanup that may have otherwise occurred, leaving memory allocated and potentially leading to corrupted files. Therefore, only use `-SIGKILL` as a last resort.

>_NOTE:_ You will also see the `kill` signals referred to numerically. `-SIGTERM`
is equivalent to `-15` and `-SIGKILL` is equivalent to `-9`.
