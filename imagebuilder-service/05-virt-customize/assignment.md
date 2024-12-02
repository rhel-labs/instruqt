---
slug: virt-customize
id: xthofgtzv34q
type: challenge
title: The virt-customize tool
tabs:
- id: yizkymmy4qcx
  title: Terminal
  type: terminal
  hostname: rhel
- id: ejxoml36ldgs
  title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
difficulty: basic
timelimit: 1
enhanced_loading: null
---
`virt-customize` is another libguestfs interface tool that will let you edit a disk image.  `guestfish` is great for interactive editing (and is of course able to be scripted), and `virt-customize` is better for actions that are carried out automatically.

For instance.  With `guestfish` I could either directly create, or script the creation, of a file within a guest image.  With `virt-customize` it's easier to just place an already created file, or install that file via an rpm.  These are both powerful tools, that serve similar jobs in different ways.

Let's improve the root security of our image by setting a default password from a file.  You can set root's password in other ways of course, `virt-customize` can even generate a random one for you.  In your home directory, there is a file called `rootpw` it contains nothing more than the password we would like to set root to.

```bash,run
cat ./rootpw
```
<pre>
# cat ./rootpw
redhat1
</pre>

So we'll use `virt-customize` to set root's password to the contents of that file.

```bash,run
virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --root-password file:./rootpw
```
<pre>
#  virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --root-password file:./rootpw
[   0.0] Examining the guest ...
[  10.0] Setting a random seed
[  10.0] Setting passwords
[  13.3] Finishing off
</pre>

`virt-customize` will also let us copy files in place. and set permissions.  Let's say we've got a sudoers drop-in we'd like in place on all of our systems.  In your home directory is a drop-in to allow users in the `superusers` group to control the `sshd` service.

```bash,run
virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --copy-in superusers:/etc/sudoers.d/
```

Then to be safe, we should correct the permissions on the file that we just placed.

```bash,run
virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --chmod 0640:/etc/sudoers.d/superusers
```

<pre>
# virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --copy-in superusers:/etc/sudoers.d/
[   0.0] Examining the guest ...
[  10.5] Setting a random seed
[  10.5] Copying: superusers to /etc/sudoers.d/
[  10.8] Finishing off
# virt-customize -a ./composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2 --chmod 0640:/etc/sudoers.d/superusers
[   0.0] Examining the guest ...
[  10.4] Setting a random seed
[  10.4] Changing permissions of /etc/sudoers.d/superusers to 0640
[  10.7] Finishing off
</pre>

Now, in the next step, we'll use guestfish again to verify our changes.

