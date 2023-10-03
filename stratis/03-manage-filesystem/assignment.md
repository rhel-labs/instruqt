---
slug: manage-filesystem
id: 8oobs1kovdzc
type: challenge
title: Manage filesystems
teaser: Manage filesystems on your RHEL host with Stratis.
notes:
- type: text
  contents: Manage filesystems with Stratis.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
---
Create a filesystem
===================

A filesystem is a hierarchy of directories that is used to organize files on a storage media. Multiple Stratis filesystems may be created from a pool. Like pools, all filesystems must have a name; you can name the filesystem my_first_fs.

Create my_first_fs from the pool that you created, my_pool.

```
stratis filesystem create my_pool my_first_fs
```

List filesystems
================
At any point, you may list all existing Stratis filesystems.

```
stratis filesystem list
```

_*NOTE:*_ There is a shortcut command `stratis fs` that performs the same operation.

![list fs](../assets/listfs.png)

Rename a filesystem
===================

It is possible to rename a filesystem. This may be useful for a variety of reasons, such as updating the name of a test filesystem to a production ready name.

Rename `my_first_fs` to a new name, `my_fs`.

```
stratis filesystem rename my_pool my_first_fs my_fs
```

Then list the result.

```
stratis fs
```

![renamed](../assets/renamedfs.png)

Mount a filesystem
==================

Mounting a filesystem means making the particular filesystem accessible at a certain point in the Linux directory tree. Your filesystem is unmounted, and cannot be used to store, read from, or write to files.

Choose a mount point, the directory in which the filesystem will be mounted. You will mount the filesystem, `my_fs`, in the directory `/mnt/test_mnt`.

```
mkdir /mnt/test_mnt
```

Mount the filesystem using the `mount` command.

```
mount /dev/stratis/my_pool/my_fs /mnt/test_mnt
```

The mount point, `/mnt/test_mnt`, will now be the root directory of the filesystem.

_*Warning:*_ If you do not choose an empty directory, the directory's previous contents will become hidden until the filesystem is unmounted.

Confirm that the filesystem has been mounted by running the mount command.

```
mount
```
![mount output](../assets/mountoutput.png)

From the above output, you can see that the filesystem is now mounted successfully in the `/mnt/test_mnt` directory.

Create files on mounted filesystem
==================================

Create two empty files in the filesystem, my_fs.

```
touch /mnt/test_mnt/my_first_file
```

```
touch /mnt/test_mnt/my_second_file
```
Check that the files have been created.

```
ls /mnt/test_mnt
```

![two files](../assets/twofiles.png)

Both files are now accessible in the /mnt/test_mnt directory.
