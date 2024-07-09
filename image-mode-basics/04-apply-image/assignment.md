---
slug: apply-image
id: x8zvennt6uwk
type: challenge
title: Apply the new image
teaser: Apply the new image changes to the system
notes:
- type: text
  contents: |
    # Goal:

    You will apply the updated image. You will also roll back to a previous version of the VM, without needing to snapshot it.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
- title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: ""
---
Check for updates within the running vm
===

Click on the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-2) tab.

> [!NOTE]
> You may need to tap `enter` to wake up the console, you should still be logged in as `core`

With the updated image available in the registry, let's see if `bootc` sees any updates available for the host.

```bash,run
sudo bootc upgrade --check
```

Initiate an update
===

Since `bootc` tracks a tag in the repository, we see our update available. We are also see some details about what changes will be made. Let's go ahead and stage this update locally.

```bash,run
sudo bootc upgrade
```

Let's see what happened on disk.

```bash,run
sudo bootc status
```

The `status` output shows us 4 main blocks of information, what image is booted, what image is staged, what image is cached for update, and what image is available for rollback. Look at each of these sections to see the URL of the image and the SHA256 digest.

Set up a test to prove image mode won't clobber configurations in /etc
===

When applying updates, bootc will pull any updates to `/usr` from the new image, letting us install new software. Any local changes to `/etc` will be merged with whats in the image, with local changes winning. Nothing in the bootc image `/var` structure will be applied, as this is considered machine state.

Let's test this by changing our user password to `1redhat`
```bash,run
echo 'core:1redhat' | sudo chpasswd
```

Once downloaded and prepared, we can activate this new image by rebooting whenever we're ready, for example if we needed to wait for a maintenance window. Let's do that now.

```bash,run
sudo reboot
```
Once the system has completed rebooting, you can log in with the new credentials. This user was already in `/etc`, your new password will be in effect.

Username:

```bash,run
core
```

Password:

```bash,run
1redhat
```

Now let's make sure Apache is still running and we have `vim` installed.

```bash,run
systemctl status httpd --no-pager
```

```bash,run
which vim
```

Here's what you should see as output.

![](../assets/test_httpd_vim.png)

Rollback
===

If we look at the output of `bootc status` we can now see that the `booted` image is the update we just applied, and the value for `rollback` has gone from `null` to our original image. You can check these against the `sha256.orig` and `sha256.vim` files we made earlier in the Terminal tab.
```bash,run
sudo bootc status
```

If there was some sort of issue with this update, for example a new Apache version that caused problems with an application, we could switch back via `bootc rollback` to the last known good state. At any time, `bootc` will only store the current, the rollback, and one cached update on disk.
```bash,run
sudo bootc rollback
```

Once downloaded and prepared, we can activate this new image by rebooting whenever we're ready, for example if we needed to wait for a maintenance window. Let's do that now.

```bash,run
sudo reboot
```

Test the rollback
===

Once the system has completed rebooting, you can log in with the new credentials. Even though we have rolled back to the previous image, remember `/etc` is local machine state. If the error with an update is configuration based, there may be no need to roll back.

Username:

```bash,run
core
```

Password:

```bash,run
1redhat
```

You should have been able to log in since the password configuration resides in `/etc` and is persisted through image updates and rollbacks.

Now let's make sure Apache is still running and `vim`is no installed.
```bash,run
systemctl status httpd
```

```bash,run
which vim
```

If we look at the output of `status` we can now see that the `booted` image and `rollback` image SHA256 digests have swapped. You can check these against the `sha256.orig` and `sha256.vim` files we made earlier in the Terminal tab.
```bash,run
sudo bootc status
```

You've now created a new image mode system from a Containerfile and seen what the management life cycle could look like. This should provide a good basis to explore image mode for RHEL with your own standard builds and applications.