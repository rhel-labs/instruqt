---
slug: inspect
id: zparnbi5qrae
type: challenge
title: Inspect the image
notes:
- type: text
  contents: |+
    # Inspecting the image

    In this step, you will access the machine image created in a previous step in order to verify that the `nodejs` and `nginx` packages added in earlier steps were added to the resulting machine image.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Inspecting the image

In the next steps, you will access the machine image, however it will not work
if the machine image is not yet completed.  The below command is a small
`until` shell script that will run until the completed machine image is created.

```
until $(composer-cli compose status | head -n1 | grep FINISHED &>/dev/null); do echo "Compose not finished ... waiting 10 seconds"; sleep 10; done; echo "COMPOSE FINISHED"
```

Now that the machine image compose is finished, download the completed machine
image into your current directory.

```
composer-cli compose image $(composer-cli compose status | head -n1 | cut -f1 -d" ")
```

<pre class="file">
00403772-ff12-43d4-b09a-bddf28f20709-disk.qcow2: 686.96 MB
</pre>

The above command takes the UUID of the compose as an argument.  We embedded
an additional call to `composer-cli compose status` along with some data
grooming to put this into the command for you to run.  Alternatively, you could
have copy/pasted from the output of your status from the previous step.

Now that the machine image is available locally, mount the disk image into your
directory tree at the /mnt mountpoint. For this, we will mount the qcow2 image
as a network block device (NBD).

Load the NBD kernel module using the `modprobe` utility -

```
modprobe nbd
```

Attach a qcow2 virtual image file that was downloaded into the current directory -

```
qemu-nbd --connect=/dev/nbd0 $(composer-cli compose status | head -n1 | cut -f1 -d" ")-disk.qcow2
```

Find the virtual machine partition so that we can mount it -

```
fdisk /dev/nbd0 -l
```

<pre class="file">
Disk /dev/nbd0: 10 GiB, 10737418240 bytes, 20971520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: D209C89E-EA5E-4FBD-B161-B461CCE297E0

Device        Start      End  Sectors  Size Type
/dev/nbd0p1    2048     4095     2048    1M BIOS boot
/dev/nbd0p2    4096   413695   409600  200M EFI System
/dev/nbd0p3  413696  1437695  1024000  500M Linux extended boot
/dev/nbd0p4 1437696 20971486 19533791  9.3G Linux filesystem
</pre>

The partition of the disk is `/dev/nbd0p4`

Mount the partition to some mountpoint (in this case `/mnt`) -

```
mount /dev/nbd0p4 /mnt
```

Temporarily change the root directory of the bash shell to be the directory holding the contents of
your machine image.

```
chroot /mnt
```

Now, all the commands run are being executed from within the machine image
and use the machine image's files and content.  Use an `rpm` query to confirm
that `nodejs` and `nginx` are included in the machine image.

```
rpm -q nodejs nginx
```

<pre class="file">
nodejs-16.14.0-4.el9_0.x86_64
nginx-1.20.1-10.el9.x86_64</pre>

From the above output, you can verify that both the `nodejs` and `nginx` packages were
installed into this machine image.

Now that the verification is complete, you can exit the chroot'ed bash shell.

```
exit
```

Unmount the verified machine disk image from your filesystem.

```
umount /mnt
```

Disconnect the network block device

```
qemu-nbd --disconnect /dev/nbd0
```

<pre class="file">
/dev/nbd0 disconnected
</pre>

Remove the NBD kernel module

```
rmmod nbd
```
