---
slug: guestfish
id: r0rvtt4nesg7
type: challenge
title: guestfish
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
difficulty: basic
timelimit: 1
---
`guestfish` is the Guest Filesystem Shell, and is one tool that can be used to view or modify your newly created image. Today we're going to use it to check that the partition table we asked Image Builder to layout actually applied. 

First lets launch guestfish this utility is part of the libguestfs-tools package, and has already been installed on this system. 

```bash
guestfish -a composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2
```

<pre>
$ guestfish -a composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2

Welcome to guestfish, the guest filesystem shell for
editing virtual machine filesystems and disk images.

Type: ‘help’ for help on commands
      ‘man’ to read the manual
      ‘quit’ to quit the shell

><fs>
</pre>

Once we're at the `<fs>` prompt, we have to tell guestfish to initialize the libguestfs library and attach to the disk with the `run` command. 

```bash
run
```

And then we can ask it to list filesystems with the `list-filesystems` command

```bash
list-filesystems
```

You should see the following:
<pre>
><fs> run
><fs> list-filesystems
/dev/sda1: unknown
/dev/sda2: vfat
/dev/sda3: xfs
/dev/rootvg/homelv: xfs
/dev/rootvg/rootlv: xfs
/dev/rootvg/tmplv: xfs
</pre>

You can also view, or edit files interactively with guestfish. You'll need to mount a filesystem, and then you can interact with it similarly to bash. Let's try that.

```bash
mount /dev/rootvg/rootlv /
```
Then let's see what `ls /` gives us.

```bash
ls /
```

<pre>
><fs> mount /dev/rootvg/rootlv /
><fs> ls /
afs
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
><fs>
</pre>

You can use `vi` to edit files, or `cat` to view them. `guestfish` is also scriptable, you can check `man guestfish` for more information. 

In the next step we'll look at another libguestfs related tool, `virt-customize`

You can exit guestfish with `exit`

```bash
exit
```

