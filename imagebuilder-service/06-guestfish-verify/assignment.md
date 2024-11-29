---
slug: guestfish-verify
id: foasxwtdrx9f
type: challenge
title: Verify changes with Guestfish
tabs:
- id: xaoshsbrahdv
  title: Terminal
  type: terminal
  hostname: rhel
- id: nkfm4jswfdqo
  title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Now that we think our changes in place, it's a good idea to verify them.  We can go back to guestfish and look at the files in place on the system.

>_NOTE_: The -i option for guestfish tells the tool to inspect the disk, and mount it for you. So we won't have to go through the steps of listing, and then mounting disk partitions.

```bash
guestfish -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 -i
```

<pre>
$ guestfish -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 -i

Welcome to guestfish, the guest filesystem shell for
editing virtual machine filesystems and disk images.

Type: ‘help’ for help on commands
      ‘man’ to read the manual
      ‘quit’ to quit the shell

Operating system: Red Hat Enterprise Linux 9.1 (Plow)
/dev/rootvg/rootlv mounted on /
/dev/sda3 mounted on /boot
/dev/sda2 mounted on /boot/efi
/dev/rootvg/homelv mounted on /home
/dev/rootvg/tmplv mounted on /tmp
</pre>

In the last step, we set the root password, and we added a sudoers drop-in.  Let's make sure both of the changes are in place.

```bash
grep root /etc/shadow
```

This should output root's entry in /etc/shadow, we can see that a hash is in place where it should be for the root users password.

<pre>
><fs> grep root /etc/shadow
root:$6$f.IB9InB1qla9fYT$OeOiVqhs5CMg/qx3xD7tvan0gIz.0mVJM.P3y0FEhRQqcTJhgiHPlDw6HYWDw1DIrGhuDl3dTzwhb7VWv0bAH/:19121:0:99999:7:::
</pre>

>_NOTE_: Your hash will likely differ from the one listed above

Now, what about that sudoers drop in?

```bash
ll /etc/sudoers.d
```

>_NOTE_: Guestfish feels like bash, but it is not.  For instance, in order to see the long listing in a directory, we might use `ls -l` in bash, but in guestfish this will return an error.  We must use `ll` instead.

<pre>
><fs> ll /etc/sudoers.d
total 16
drwxr-x---.  2 root root   24 Mar 27 18:45 .
drwxr-xr-x. 92 root root 8192 Mar 27 16:48 ..
-rw-r-----   1 1000 1000  173 Mar 27 18:40 superusers
</pre>

We can see that the file `superusers` is present, and the permissions are as we expect them.  Let's view the contents

```bash
cat /etc/sudoers.d/superusers
```
<pre>
><fs> cat /etc/sudoers.d/superusers
Cmnd_Alias SERVICES = /usr/bin/systemctl start sshd, /usr/bin/systemctl stop sshd, /usr/bin/systemctl restart sshd, /usr/bin/systemctl status sshd

%superusers ALL=SERVICES
</pre>

You can now exit guestfish with `exit`

```bash
exit
```

At this point we can be reasonably sure that our image is ready to be used as a base for new installs.  You could however test further by running a new local VM based on this image using libvirt, or by uploading the image to your cloud provider to validate its configuration.

Information on how you might upload a customized image builder image to your cloud provider can be found in the documention: [Deploying Red Hat Enterprise Linux 9 on public cloud platforms](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/deploying_red_hat_enterprise_linux_9_on_public_cloud_platforms/index).