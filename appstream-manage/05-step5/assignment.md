---
slug: step5
id: 11wqbdpdavh3
type: challenge
title: Step 5
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "Terminal1" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Now that the ruby 3.1 is installed, you can also look at how the modular package management is reported by `dnf`.

```bash,run
dnf module list ruby
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
Name       Stream        Profiles            Summary
ruby       3.1 [e]       common [d] [i]      An interpreter of object-oriented scripting language

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
</pre>

From the above output, you can see that ruby 3.1 is the enabled `[e]` module and that it is installed `[i]` on the system.

As Red Hat releases updated application streams, you will use a similar process of removing the installed application stream and installing a newer one.

To see the full list of available modular packaged application streams an their versions available for your system:

```bash,run
dnf module list
```
