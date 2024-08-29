---
slug: rollback-a-host
id: ii7woss9bdxe
type: challenge
title: Rolling back software updates
teaser: Roll back changes to a deployed host
notes:
- type: text
  contents: |
    # Goal:

    Recovering from software problems is typically an expensive proposition that requires a lot of preparatory work. Operating in image mode, roll back is a native capability.

    In this exercise, we'll explore how to revert to an earlier image already on disk.
tabs:
- id: zje6jrqczgve
  title: Terminal
  type: terminal
  hostname: rhel
- id: tpkjptwwk0eu
  title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
- id: fzmfm00uw2yp
  title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: basic
timelimit: 1
---
> [!NOTE]
> You should still be in the VM Console tab. If not,
> Click on the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-2) tab.
> You may need to tap `enter` to wake up the console, you should still be logged in as `core`

We have a new built-in option available to image mode systems that typically takes more preparation with package mode operations: the rollback.

Since `bootc` manages state on disk, we have the previous working system available to us. Normally, we’d need to have set up snapshots or refer to a backup but `bootc` automatically provides us the rollback built in.

This isn't the sort of issue we'd normal need to recover from, but let's go ahead and check for an available rollback option to get us back to the previous image.

```bash,run
sudo bootc status | grep rollback: -A 8
```

You should see our original image, without the `v2` tag. Rollbacks are as simple as running one command. Let’s get this image back to the previous state then we can dig into what happened in the Containerfile.
```bash,run
sudo bootc rollback
```

The command should return very fast and the output looks like this:
````
bootfs is sufficient for calculated new size: 0 bytes
Next boot: rollback deployment
````

You should see the value of `rollbackQueued` has been updated as well. This can be useful to check before restarting a sysytem.
```bash,run
sudo bootc status | grep Queued
```

````
rollbackQueued: true
````

You can also check the boot order in the spec block to see what has been sent to the bootloader.
```bash,run
sudo bootc status | grep Order
```

````
bootOrder: rollback
````
Feel free to explore `bootc status` further before moving on.

As usual, a reboot is needed to apply changes. After the reboot, the rollback image will become the booted image, and will also become the new default in the boot order.
```bash,run
sudo reboot
```
