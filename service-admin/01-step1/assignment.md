---
slug: step1
id: x3tdnsgrfq0f
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Overview:

    Services are processes that run in the background of a system, out of the user’s view. They typically lack an interface and therefore have to be interacted with using commands. Services streamline the user experience by taking care of operations automatically and in a way that does not distract the user. There is actually a service that manages the starting and stopping of other services, `systemd`. This lab provides the basics of starting and stopping services using `systemctl`, which is the command that allows users to interact with the `systemd` service.

    # Goal:

    After completing this lab, users will understand how to start, restart, and stop a service. You will also learn how to make a service start every time the system starts.

    # Concepts included in this scenario:

    * View and kill processes
    * Learn how processes and services are related
    * View the status of a service
    * Learn how `systemd` and `systemctl` are related
    * Enable a service with `systemctl` to make it persistent
    * Restart a service to activate configuration changes
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Terminal 2
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 600
---
# What are processes?

_Files_ keep track of information on a Linux system, providing a way for users
to organize and store information. Sometimes, files contain information that
can be run to carry out a specific operation. These kinds of files are called
_programs_. When you run a program, the running instance is called a _process_.
Modern Linux systems have tons of processes running at any given moment, so it
is crucial to have a way to manage these processes.

# Viewing processes

The command that lets you view processes on Linux is `ps`, short for "Process Status".
This command will show you all processes running in the current shell if called without
any options. However, it is frequently useful to see processes that may not
have been started with your user ID. The command `ps aux` will show you all processes,
including those running without a controlling terminal. This command will also give
information about the users associated with these processes.

```
ps aux
```

<pre class=file>
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.7 186268 14440 ?        Ss   16:09   0:03 /usr/lib/systemd/systemd --switched-root --system --deserialize 17
root           2  0.0  0.0      0     0 ?        S    16:09   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   16:09   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   16:09   0:00 [rcu_par_gp]

<< OUTPUT ABRIDGED >>
</pre>

This output is very extensive, so often when you call this command you want to
pipe the output into `grep` to search for a specific phrase. To practice this,
start a process, background it, and then search for it in the original
terminal. The `dd` command can be used to create an indefinite process. The command below begins copying data from a file of infinite zeros into a file that discards all inputs, so the process will continue indefinitely. The `&` sends the process into the background so that we do not interact with it in the terminal.

```
dd if=/dev/zero of=/dev/null &
```

When you run this command, you will not see an output as the process will
continue running in the foreground until you interrupt it. Returning to the
original terminal, run a search on `ps aux` to find this indefinite `dd` process:

```
ps aux | head -n1 ; ps aux | grep '[d]d '
```

<pre class=file>
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        3790  101  0.0   7352   944 pts/1    R+   17:38   0:01 dd if=/dev/zero of=/dev/null
</pre>

>_NOTE:_ The first command in this line will print the column headers for `ps aux` so that you can see what each entry means. The second command searches for a process called `dd `, where the single quotes ensure the trailing space is part of the search criteria. Enclosing the first "d" in square brackets prevents the `grep` search from finding itself when it looks through the process list. Take note of the second column, the Process ID. This ID is how you interact with the process, as it can be used in other commands as a unique reference to this process. Now you know how to find a process. The next step will walk you through terminating this indefinite process.
