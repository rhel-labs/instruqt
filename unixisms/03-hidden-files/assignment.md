---
slug: hidden-files
id: dzcwlj6nyiyh
type: challenge
title: Accessing hidden files
notes:
- type: text
  contents: |
    # Accessing Hidden Files

    Sometimes it is useful to have a file or directory that it hidden, meaning it does not show up when running `ls` normally. This may be because the file is not often used, or because the file shouldn't be tampered with by inexperienced users.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

Any file or directory that begins with a `.` in the name will be interpreted as
hidden, and will only show up when using the `-a` option with `ls`.

List the files in your current directory:

```bash
ls
```

<pre class=file>
anaconda-ks.cfg  openscap_data  original-ks.cfg
</pre>

Now, try it again with the `-a` option. Many more files and directories will
show up, even though you have not changed where you are looking.

```bash
ls -a
```

`.  ..  anaconda-ks.cfg  .bash_history  .bash_logout  .bash_profile  .bashrc  .cshrc  openscap_data  original-ks.cfg  .ssh  .tcshrc  .vimrc`

Adding the `-a` option reveals that there are numerous hidden files and directories
in this home directory. These are hidden because they are not files that
you would interact with often, so there is no need for them to clutter up __root__'s
home directory visually. However, they are data that is associated with the
user, so it is beneficial from an organization point of view to store them
in the home directory associated with their specific user.

>_NOTE_: One common hidden directory you will commonly run into is the `.git`
directory. This is part of any git repository and stores data used in version
control for your local repository.

Creating a new hidden file or directory is quite simple, just start the name with
a `.`

```bash
touch .hidden-file
```

Now that this file is created, confirm that it only shows up when using `ls -a`:

```bash
ls
```

`anaconda-ks.cfg  openscap_data  original-ks.cfg`

```bash
ls -a
```

`.   anaconda-ks.cfg  .bash_logout   .bashrc  .hidden-file   original-ks.cfg  .tcshrc`
`..  .bash_history    .bash_profile  .cshrc   openscap_data  .ssh             .vimrc`
